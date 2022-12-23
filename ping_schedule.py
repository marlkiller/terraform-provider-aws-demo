import json

import boto3

"""

"""


def lambda_handler(event, context):
    queue_resource = boto3.resource(
        'sqs',
        region_name='cn-north-1'
    )
    queue = queue_resource.Queue('https://sqs.cn-north-1.amazonaws.com.cn/298456415402/ping_queue')

    ip_groups = [{
        'name': 'group_1',
        'ping_ips': [
            'www.baidu.com0',
            'www.baidu.com1',
            'www.baidu.com2',
            'www.baidu.com3',
            'www.baidu.com4',
            'www.baidu.com5',
            'www.baidu.com6',
            'www.baidu.com7',
            'www.baidu.com8',
            'www.baidu.com9',
        ]
    }]

    for item in ip_groups:
        print(f'current : {item}')
        resp = queue.send_message(
            MessageBody=json.dumps(item),
            DelaySeconds=0,
            # MessageGroupId=str(uuid.uuid1()), # fifo need
        )
        print(resp)

    return {
        'statusCode': 200,
        'body': json.dumps('Hello from Lambda!')
    }
