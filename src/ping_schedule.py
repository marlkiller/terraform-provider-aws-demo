import json
import logging

import boto3

"""
# PE
192.168.201.34
192.168.201.30
"""


def lambda_handler(event, context):
    queue_resource = boto3.resource(
        'sqs',
        region_name='cn-north-1'
    )
    ip_groups = [{
        'name': 'group_PE',
        'ping_ips': [
            '192.168.201.34',
            '192.168.201.30',
        ]
    }]
    sqs_ping_queue_list = queue_resource.queues.filter(
        QueueNamePrefix='ping_queue_',
        MaxResults=100
    )
    for sqs_item in sqs_ping_queue_list:
        for item in ip_groups:
            print(f'sqs : {sqs_item}, msg : {item}')
            sqs_item.send_message(
                MessageBody=json.dumps(item),
                DelaySeconds=0,
                # MessageGroupId=str(uuid.uuid1()), # fifo need
            )

    return {
        'statusCode': 200,
        'body': json.dumps('Hello from Lambda!')
    }


if __name__ == '__main__':
    lambda_handler({},{})
