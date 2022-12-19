import json
import re
import time
from concurrent.futures import ThreadPoolExecutor
from subprocess import getoutput

import boto3

regex = r"([0-9\.]+)% packet loss"

queue_resource = boto3.resource(
    'sqs',
    aws_access_key_id='AKIAUK7LDPSVOWZAH57B',
    aws_secret_access_key='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',
    region_name='cn-north-1'
)
queue = queue_resource.Queue('https://sqs.cn-north-1.amazonaws.com.cn/298456415402/action_queue')


def get_pkg_loss(ip):
    # -i 可设置 ping 的时间间隔
    # -c 指定 ping 的次数
    cmd = "ping -c 1 {}".format(ip)

    ret = getoutput(cmd)

    '''
    PING www.a.shifen.com (110.242.68.4): 56 data bytes
    64 bytes from 110.242.68.4: icmp_seq=0 ttl=51 time=12.747 ms

    --- www.a.shifen.com ping statistics ---
    2 packets transmitted, 2 packets received, 0.0% packet loss
    round-trip min/avg/max/stddev = 11.337/12.042/12.747/0.705 ms
    '''
    print(ret)
    search = re.search(regex, ret, re.MULTILINE)
    loss = float(search.groups()[0])
    print(f"ret :{ret} , loss :{loss}")
    return loss


def do_ping(ip):
    loss = get_pkg_loss(ip)
    return loss >= 30


def lambda_handler(event, context):
    print(event)
    start = time.time()
    current_group = json.loads(event['Records'][0]['body'])
    print(current_group)
    ip_list = current_group.get('ping_ips')
    thread_pool = ThreadPoolExecutor(len(ip_list))
    pending_list = []
    for ip in ip_list:
        future_task = thread_pool.submit(do_ping, ip)
        pending_list.append(future_task)
    ping_fail_count = 0
    for item in pending_list:
        if item.result():
            ping_fail_count = ping_fail_count + 1

    action_body = {}
    if ping_fail_count > 0:
        action_body['action'] = 'acl-close'
    else:
        action_body['action'] = 'acl-open'

    queue.send_message(
        MessageBody=json.dumps(action_body),
        DelaySeconds=0,
    )
    print(f'send {action_body}')

    print(f"mainlogrecords {current_group} - {time.time() - start:.4f}s")

    return {
        'statusCode': 200,
        'body': json.dumps('Hello from Lambda!')
    }
