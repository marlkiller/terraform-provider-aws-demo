import json
import logging
import random
import re
import socket
import time
from concurrent.futures import ThreadPoolExecutor
from datetime import datetime, timedelta
from subprocess import getoutput
from uuid import uuid1

import boto3
from boto3.dynamodb.conditions import Attr
from moto.transcribe.exceptions import ConflictException


def get_logging():
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

queue_resource = boto3.resource(
    'sqs',
    region_name='cn-north-1'
)
acton_queue = queue_resource.Queue('https://sqs.cn-north-1.amazonaws.com.cn/298456415402/action_queue')
ping_queue = queue_resource.Queue('https://sqs.cn-north-1.amazonaws.com.cn/298456415402/ping_queue')

lock_table = boto3.resource('dynamodb').Table('network_monitor_lock')


def get_pkg_loss(ip):
    """
    -d：使用 Socket 的 SO_DEBUG 功能；
    -c<完成次数>：设置完成要求回应的次数；
    -f：极限检测；
    -i<间隔秒数>：指定收发信息的间隔时间；
    -I<网络界面>：使用指定的网络界面送出数据包；
    -l<前置载入>：设置在送出要求信息之前，先行发出的数据包；
    -n：只输出数值；
    -p<范本样式>：设置填满数据包的范本样式；
    -q：不显示指令执行过程，开头和结尾的相关信息除外；
    -r：忽略普通的 Routing Table，直接将数据包送到远端主机上；
    -R：记录路由过程；
    -s<数据包大小>：设置数据包的大小；
    -t<存活数值>：设置存活数值TTL的大小；
    -v：详细显示指令的执行过程。
    """
    regex = r"([0-9\.]+)% packet loss"
    cmd = "ping -c 1 {}".format(ip)
    ret = getoutput(cmd)

    '''
    PING www.a.shifen.com (110.242.68.4): 56 data bytes
    64 bytes from 110.242.68.4: icmp_seq=0 ttl=51 time=12.747 ms

    --- www.a.shifen.com ping statistics ---
    2 packets transmitted, 2 packets received, 0.0% packet loss
    round-trip min/avg/max/stddev = 11.337/12.042/12.747/0.705 ms
    '''
    search = re.search(regex, ret, re.MULTILINE)
    loss = float(search.groups()[0])
    logger.info(f"cmd : {cmd}, ret :{ret} , loss :{loss}")
    return loss


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


def create_ttl(milliseconds: int = None, seconds: int = None, minutes: int = None, hours: int = None,
               days: int = 1) -> int:
    ''' Get a TTL value for dynamodb for minutes, hours or days in the future.
    This function will use only minutes, only hours or only days, depending on
    the values. If minutes and hours are 0, days are used. If minutes are 0 and
    hours has a value greater than 0, hours will be used. If minutes has a
    value greater than 0, minutes will be used.

    Args:
        milliseconds (int): number of milliseconds from now on when ttl ends
        seconds (int): number of seconds from now on when ttl ends
        minutes (int): number of minutes from now on when ttl ends
        hours (int): number of hours from now on when ttl ends
        days (int): number of days from now on when ttl ends

    Returns:
        ttl (int): the ttl value as integer
    '''
    if milliseconds:
        ttl = int((datetime.now() + timedelta(milliseconds=int(milliseconds))).timestamp())
    elif seconds:
        ttl = int((datetime.now() + timedelta(seconds=int(seconds))).timestamp())
    elif minutes:
        ttl = int((datetime.now() + timedelta(minutes=int(minutes))).timestamp())
    elif hours:
        ttl = int((datetime.now() + timedelta(hours=int(hours))).timestamp())
    else:
        ttl = int((datetime.now() + timedelta(days=int(days))).timestamp())
    return ttl


def lock_resource(name, uuid):
    logger.info('Create new resource lock for %s with uuid %s', name, uuid)
    lock_date = datetime.now()
    locked = False
    while not locked:
        try:
            args = {
                'Item': {
                    'arn': name,
                    'ttl': create_ttl(seconds=get_remaining_seconds(lock_date)),
                    'uuid': uuid,
                    'source': 'group',
                    'status': 'LOCKED'
                },
                'ConditionExpression': Attr('arn').not_exists()
            }

            lock_table.put_item(**args)
            locked = True

        except lock_table.meta.client.exceptions.ConditionalCheckFailedException:
            if 0 < get_remaining_seconds(lock_date):
                random_sleep = random.randrange(1, 5)
                logger.info('Retry to lock arn %s again in %s seconds. %s seconds '
                            'left to lock the resource.', name, random_sleep, get_remaining_seconds(lock_date))
                time.sleep(random_sleep)
            else:
                raise ConflictException(
                    message=f'ARN {name} is currently locked. Please retry in a couple of minutes.',
                    conflict_errors=[name])


def get_remaining_seconds(lock_date):
    return (lock_date - datetime.now()).total_seconds() + 120


def do_task(event):
    logger.info(f'do_task event : {event}')
    current_group = json.loads(event)
    ip_list = current_group.get('ping_ips')
    name = current_group.get('name')
    logger.info(f'current_group : {current_group}, ip_list : {ip_list}')

    uuid = str(uuid1())

    t_start = time.time()
    t_end = t_start + 120

    try:
        lock_resource(name, uuid)

        while time.time() < t_end:
            ping_fail_count = 0
            for ip in ip_list:
                if do_ping(ip) != 0:
                    ping_fail_count = ping_fail_count + 1
            action_body = {}
            if ping_fail_count > 0:
                action_body['action'] = 'acl-close'
            else:
                action_body['action'] = 'acl-open'
            acton_queue.send_message(
                MessageBody=json.dumps(action_body),
                DelaySeconds=0,
            )
            logger.info(f'acton_queue send  {action_body}')
            time.sleep(2)

    finally:
        try:
            lock_table.delete_item(
                Key={'arn': name},
                ConditionExpression=Attr('uuid').eq(uuid)
            )
        except Exception as e:
            logger.error('Can\'t delete resource lock for %s , msg : %s', name, e)

    logger.info(f'do_task complete current_group :{current_group} , cost time - {time.time() - t_start:.4f}s')


def lambda_handler(event, context):
    thread_pool = ThreadPoolExecutor(20)

    while True:
        msg = ping_queue.receive_messages()
        if msg and len(msg) > 0:
            logger.info(f'ping_queue receive msg  {len(msg)}')
            for item in msg:
                thread_pool.submit(do_task, item.body)
        time.sleep(1)

    return {
        'statusCode': 200,
        'body': json.dumps('Hello from Lambda!')
    }
