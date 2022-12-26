import json
import logging
import os
import random
import re
import socket
import time
import traceback
from concurrent.futures import ThreadPoolExecutor
from datetime import datetime
from subprocess import getoutput
from uuid import uuid1
import platform

import boto3
from boto3.dynamodb.conditions import Attr
from moto.transcribe.exceptions import ConflictException

"""
pip3 install moto
pip3 install boto3
"""

os.putenv('TZ', 'Asia/Shanghai')
time.tzset()

queue_resource = boto3.resource(
    'sqs',
    region_name='cn-north-1'
)
acton_queue = queue_resource.Queue('https://sqs.cn-north-1.amazonaws.com.cn/298456415402/action_queue')
ping_queue = queue_resource.Queue('https://sqs.cn-north-1.amazonaws.com.cn/298456415402/ping_queue')

lock_table = boto3.resource('dynamodb').Table('network_monitor_lock')
acl_table = boto3.resource('dynamodb').Table('network_monitor_acl')

PING_COUNT = 4

TASK_RUN_TIME = 120

CURRENT_PLATFORM = platform.system()
PING_TIMEOUT = '-w 5'
if CURRENT_PLATFORM.lower() == 'Darwin':
    PING_TIMEOUT = '-t 5'


def get_logging():
    # TODO Compress the log files automatically

    fm = "%(asctime)s %(levelname)s [%(threadName)s] [%(filename)s(%(funcName)s:%(lineno)d)] - %(message)s'"

    logging_level = logging.INFO
    logging.basicConfig(level=logging_level,
                        # filename="../log/log1.log",
                        format=fm
                        )
    _logger = logging.getLogger()
    _logger.setLevel(logging_level)
    return _logger


logger = get_logging()


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
    return int(loss)


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
                    message=f'ARN {name} is currently locked more than {TASK_RUN_TIME} seconds. Release this lock ??',
                    conflict_errors=[name])


def get_remaining_seconds(lock_date):
    return (lock_date - datetime.now()).total_seconds() + TASK_RUN_TIME


def do_task(event):
    logger.info(f'do_task event : {event}')
    current_group = json.loads(event)
    ping_ips = current_group.get('ping_ips', [])
    group_name = current_group.get('name')
    ips_thread_pool = ThreadPoolExecutor(len(ping_ips), thread_name_prefix='ip_pool')
    t_start = time.time()
    t_end = t_start + TASK_RUN_TIME
    lock_uuid = str(uuid1())
    try:
        lock_resource(group_name, lock_uuid)

        while time.time() < t_end:
            pending_list = []
            for ip in ping_ips:
                future_task = ips_thread_pool.submit(do_ping, ip)
                pending_list.append(future_task)
            ping_loss_result = set()
            for pend_item in pending_list:
                result = pend_item.result()
                ping_loss_result.add(result)
                if result == 100:
                    break
            logger.info(f"ping_loss_result : {ping_loss_result}")
            ping_loss_result = (list(ping_loss_result))
            action = None
            if ping_loss_result.__contains__(100):
                # Network Unreachable , loss 100%
                action = 'acl-close'
            elif len(ping_loss_result) == 1 and ping_loss_result[0] == 0:
                # All testing IP, no packet loss
                action = 'acl-open'
            if action:
                action_body = {}
                db_acl = acl_table.get_item(
                    Key={'arn': 'acl-0d5098dea8ba07575'}
                ).get('Item')
                if action == 'acl-close':
                    if db_acl and db_acl.get('status') == 'deny':
                        logger.info("already closed , ignore")
                        continue
                    action_body['action'] = action
                elif action == 'acl-open':
                    if db_acl and db_acl.get('status') == 'allow':
                        logger.info("already opened , ignore")
                        continue
                    action_body['action'] = action
                if action_body.get('action'):
                    acton_queue.send_message(
                        MessageBody=json.dumps(action_body),
                        DelaySeconds=0,
                    )
                    logger.info(f'acton_queue send  {action_body}')
                    time.sleep(2)
    except Exception as e:
        traceback.print_exc()
        logger.error(e)
    finally:
        try:
            lock_table.delete_item(
                Key={'arn': group_name},
                ConditionExpression=Attr('uuid').eq(lock_uuid)
            )
        except Exception as e:
            logger.error('Can\'t delete resource lock for %s , msg : %s', group_name, e)

    logger.info(f'do_task complete current_group :{current_group} , cost time - {time.time() - t_start:.4f}s')


if __name__ == '__main__':
    thread_pool = ThreadPoolExecutor(20, thread_name_prefix='task_pool')

    while True:
        msg = ping_queue.receive_messages()
        if msg and len(msg) > 0:
            logger.info(f'ping_queue receive msg  {len(msg)}')
            for item in msg:
                thread_pool.submit(do_task, item.body)
        # time.sleep(1)
