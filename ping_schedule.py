import json

import boto3

"""
{
    "group_1": {
        "ips": [
            "10.0.0.1",
            "10.0.0.2",
            "10.0.0.3"
        ],
        "acl_ids": [
            "acl-xxxx1",
            "acl-xxxx2"
        ]
    },
    "group_2": {
        "ips": [
            "10.0.0.4",
            "10.0.0.5",
            "10.0.0.6"
        ],
        "acl_ids": [
            "acl-xxxx3",
            "acl-xxxx4"
        ]
    }
}
"""


def lambda_handler(event, context):
    queue_resource = boto3.resource(
        'sqs',
        region_name='cn-north-1'
    )
    queue = queue_resource.Queue('https://sqs.cn-north-1.amazonaws.com.cn/298456415402/ping_queue')

    ip_groups = [{
        'name': 'group_1',
        'ping_ips': ['www.baidu1.com']
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
