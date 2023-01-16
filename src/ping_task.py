import json
import logging
import os
import platform
import random
import re
import socket
import time
import traceback
import uuid
from concurrent.futures import ThreadPoolExecutor
from datetime import datetime
from logging import handlers
from pathlib import Path
from subprocess import getoutput

import boto3
from boto3.dynamodb.conditions import Attr
from flask import Response, request, Flask

"""
pip3 install boto3
pip3 install flask
"""

app = Flask(__name__)
thread_pool = ThreadPoolExecutor(10)

os.putenv('TZ', 'Asia/Shanghai')
time.tzset()

ec2_client = boto3.client('ec2')
sns_client = boto3.client('sns')

lock_table = boto3.resource('dynamodb').Table('network_monitor_lock')
status_table = boto3.resource('dynamodb').Table('network_monitor_status')
vm_status_table = boto3.resource('dynamodb').Table('network_monitor_vm')

FMT_PATTERN = "%Y-%m-%d %H:%M:%S"
PING_COUNT = 4
TASK_RUN_TIME = 120
SUCCESS_DIFF = 60
CURRENT_PLATFORM = platform.system()

if CURRENT_PLATFORM.lower() == 'darwin':
    PING_TIMEOUT = '-t 5'
elif CURRENT_PLATFORM.lower() == 'linux':
    PING_TIMEOUT = '-w 5'
else:
    pass

def get_logger(log_file_path: str = "./monitor.log"):
    # 检测日志目录
    log_dir_path = os.path.dirname(log_file_path)
    log_dir = Path(log_dir_path)
    if not log_dir.exists():
        os.mkdir(log_dir_path)

    # 创建一个logger，并设置日志级别
    _logger = logging.getLogger()
    _logger.setLevel(logging.DEBUG)

    # 设置滚动文件10M
    rfh = handlers.RotatingFileHandler(
        log_file_path,
        mode='a',
        maxBytes=10 * 1024 * 1024,
        backupCount=1,
        encoding=None,
        delay=False
    )
    rfh.setLevel(logging.INFO)

    # 创建一个handler，用于将日志输出到控制台，并设置日志级别
    ch = logging.StreamHandler()
    ch.setLevel(logging.INFO)

    # 定义handler的输出格式
    formatter = logging.Formatter(
        '%(asctime)s-%(name)s-[%(filename)s:%(lineno)d]''-[%(levelname)s]: %(message)s')
    rfh.setFormatter(formatter)
    ch.setFormatter(formatter)

    # 给logger添加handler
    _logger.addHandler(rfh)
    _logger.addHandler(ch)

    return _logger


logger = get_logger()


def get_vm_identity_arn():
    """
       linux : ec2-metadata -i
       ubuntu : ec2metadata --instance-id
       instance-id: i-0d6798f7153de256b
    """
    # vm hostname
    # hostname = socket.gethostname()
    # vm ip
    # ip = socket.gethostbyname(hostname)
    # vm mac address
    # mac = uuid.UUID(int=uuid.getnode()).hex[-12:]
    # mac_address = ":".join([mac[e:e + 2] for e in range(0, 11, 2)])
    # ('02:78:e9:8a:50:28', '192.168.216.11', 'ip-192-168-216-11.cn-north-1.compute.internal')
    # return mac_address, ip, hostname
    instance_id = getoutput('ec2-metadata -i')
    if instance_id.__contains__('i-'):
        return instance_id
    else:
        return None


def filter_allow(i):
    # Egress 出口
    return i.get('RuleNumber') == 100 and i.get('CidrBlock') == '0.0.0.0/0' \
        and i.get('Protocol') == '-1' and not i.get('Egress') and i.get('RuleAction') == 'allow'


def filter_deny(i):
    return i.get('RuleNumber') == 100 and i.get('CidrBlock') == '0.0.0.0/0' \
        and i.get('Protocol') == '-1' and not i.get('Egress') and i.get('RuleAction') == 'deny'


class ConflictException(Exception):
    def __init__(self, message) -> None:
        super().__init__(self)
        self.message = message

    def __str__(self):
        return self.message


def get_pkg_loss(ip):
    regex = r"([0-9\.]+)% packet loss"
    cmd = f"ping -c {PING_COUNT} {PING_TIMEOUT} {ip}"
    ret = getoutput(cmd)

    '''
    PING www.a.shifen.com (110.242.68.4): 56 data bytes
    64 bytes from 110.242.68.4: icmp_seq=0 ttl=51 time=12.747 ms

    --- www.a.shifen.com ping statistics ---
    4 packets transmitted, 0 packets received, 100.0% packet loss
    round-trip min/avg/max/stddev = 11.337/12.042/12.747/0.705 ms
    '''
    logger.info(f"cmd : {cmd}, ret :{ret}")
    search = re.search(regex, ret, re.MULTILINE)
    if not search:
        return 100
    loss = search.groups()[0]
    return int(float(loss))


def get_socket_stats(ip):
    split = ip.split(":")
    sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    try:
        sock.settimeout(1)
        state = sock.connect_ex((split[0], int(split[1])))
        print(f"{split[0]}:{split[1]} {state}")
        if 0 == state:
            return True
    finally:
        sock.close()
    return False


def do_ping(ip):
    # return get_socket_stats(ip)
    loss = get_pkg_loss(ip)
    return loss


def lock_resource(name, uuid):
    logger.info('Create new resource lock for %s with uuid %s', name, uuid)
    first_lock_date = datetime.now()
    locked = False
    while not locked:
        try:
            args = {
                'Item': {
                    'arn': name,
                    'lock_date': datetime.now().strftime("%Y-%m-%d %H:%M:%S"),
                    'uuid': uuid,
                    'source': 'group',
                    'status': 'LOCKED'
                },
                'ConditionExpression': Attr('arn').not_exists()
            }

            lock_table.put_item(**args)
            locked = True
            logger.info(f"Lock resource [{name}] successful")

        except lock_table.meta.client.exceptions.ConditionalCheckFailedException:
            if 0 < get_remaining_seconds(first_lock_date):
                random_sleep = random.randrange(1, 5)
                logger.info('Retry to lock arn %s again in %s seconds. %s seconds '
                            'left to lock the resource.', name, random_sleep, get_remaining_seconds(first_lock_date))
                time.sleep(random_sleep)
            else:
                logger.error(f'ARN {name} is currently locked more than {TASK_RUN_TIME} seconds. Release this lock ??')
                # lock_table.delete_item(
                #     Key={'arn': name},
                # )
                raise ConflictException(
                    message=f'ARN {name} is currently locked more than {TASK_RUN_TIME} seconds. Release this lock ??')


def str_now_time():
    return datetime.now().strftime(FMT_PATTERN)


def save_ping_status(arn, ping_loss_result):
    status_table.put_item(Item={
        'arn': arn,
        'ping_loss_result': str(ping_loss_result),
        'update_time': str_now_time()
    })
    logger.info(f'save ping status :{arn} - {ping_loss_result}')


def get_remaining_seconds(lock_date):
    return (lock_date - datetime.now()).total_seconds() + TASK_RUN_TIME


def do_task(event):
    """
    {
        "ping_ips":["127.0.0.1"],
        "name":"group_name",
        "acl_id": "acl-0d5098dea8ba07575"
    }    
    """
    logger.info(f'do_task event : {event}')
    current_group = json.loads(event)
    ping_ips = current_group.get('ping_ips', [])
    group_name = current_group.get('name')
    acl_id = current_group.get('acl_id')
    ips_thread_pool = ThreadPoolExecutor(len(ping_ips), thread_name_prefix='ip_pool')
    t_start = time.time()
    t_end = t_start + TASK_RUN_TIME
    # lock_uuid = str(uuid.uuid1())
    try:
        # lock_resource(group_name, lock_uuid)

        while time.time() < t_end:

            db_status = status_table.get_item(Key={'arn': group_name}).get('Item')

            pending_list = []
            for ip in ping_ips:
                future_task = ips_thread_pool.submit(do_ping, ip)
                pending_list.append(future_task)
            # ping_loss_result = set()
            ping_loss_result = []
            for pend_item in pending_list:
                result = pend_item.result()
                ping_loss_result.append(result)
                if result == 100:
                    break
            logger.info(f"ping_loss_result : {ping_loss_result}")
            # ping_loss_result = (list(ping_loss_result))
            action = None
            if db_status:
                if db_status.get('ping_loss_result') != str(ping_loss_result):
                    save_ping_status(group_name, ping_loss_result)
            else:
                save_ping_status(group_name, ping_loss_result)
            if ping_loss_result.__contains__(100):
                # Network Unreachable , loss 100%
                action = 'acl-close'
                acl_entries = ec2_client.describe_network_acls(NetworkAclIds=[acl_id])['NetworkAcls'][0]['Entries']
                current_entry = list(filter(filter_deny, acl_entries))
                if len(current_entry) > 0:
                    logger.info(f'{acl_id} already deny')
                    continue
            else:
                set_ping_loss_result = set(ping_loss_result)
                if len(set_ping_loss_result) == 1 and set_ping_loss_result.pop() == 0:
                    if not db_status:
                        continue
                    db_ping_loss_result = set(json.loads(db_status.get('ping_loss_result',[])))
                    if not (len(db_ping_loss_result) == 1 and db_ping_loss_result.pop() == 0):
                        continue
                    diff_seconds = (datetime.now() - datetime.strptime(db_status.get('update_time'),FMT_PATTERN)).seconds
                    logger.info(f'diff_seconds :{diff_seconds}/{SUCCESS_DIFF}')
                    if diff_seconds >= SUCCESS_DIFF:
                        action = 'acl-open'
                        save_ping_status(group_name, ping_loss_result)
                        acl_entries = ec2_client.describe_network_acls(NetworkAclIds=[acl_id])['NetworkAcls'][0][
                            'Entries']
                        current_entry = list(filter(filter_allow, acl_entries))
                        if len(current_entry) > 0:
                            logger.info(f'{acl_id} already allow')
                            continue
            if action:
                action_body = {'action': action, 'acl_id': acl_id}
                """
                TODO LIST
                1. 上锁
                """
                sns_client.publish_batch(
                    TopicArn='arn:aws-cn:sns:cn-north-1:298456415402:ping_action',
                    PublishBatchRequestEntries=[
                        {
                            'Id': str(uuid.uuid1()),
                            'Message': json.dumps(action_body),
                            'Subject': 'ping_action',
                        },
                    ]
                )
                logger.info(f'acton_sns send  {action_body}')
    except ConflictException as e:
        logger.error(e)
    except Exception as e:
        traceback.print_exc()
        logger.error(e)
    finally:
        pass
        # try:
        #     lock_table.delete_item(
        #         Key={'arn': group_name},
        #         ConditionExpression=Attr('uuid').eq(lock_uuid)
        #     )
        # except Exception as e:
        #     logger.error('Can\'t delete resource lock for %s , msg : %s', group_name, e)

    logger.info(f'do_task complete current_group :{current_group} , cost time - {time.time() - t_start:.4f}s')


def put_vm_identity():
    # local_vm_identity = get_vm_identity_arn()
    local_vm_identity = 'local'
    if not local_vm_identity:
        raise Exception("local_vm_identity is null")
    logger.info(f'vm identity is : {local_vm_identity}')
    vm_status_table.put_item(Item={
        'arn': local_vm_identity,
        'update_time': str_now_time(),
        'receive_messages_url': f"http://{socket.gethostbyname(socket.gethostname())}:8080/receive_messages",
    })


@app.route('/receive_messages', methods=['POST', 'GET'])
def receive_messages():
    rep = Response(json.dumps({}), content_type='application/json', status=200)
    thread_pool.submit(do_task, request.data.decode('utf-8'))
    return rep


put_vm_identity()

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=8080)
