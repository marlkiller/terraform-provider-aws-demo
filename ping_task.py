import json
import re
import time
from concurrent.futures import ThreadPoolExecutor
from subprocess import getoutput

import boto3

regex = r"([0-9\.]+)% packet loss"

queue_resource = boto3.resource(
    'sqs',
    region_name='cn-north-1'
)
queue = queue_resource.Queue('https://sqs.cn-north-1.amazonaws.com.cn/298456415402/action_queue')


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
