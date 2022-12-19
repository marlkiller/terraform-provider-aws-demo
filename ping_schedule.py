import json

import boto3


def lambda_handler(event, context):
    queue_resource = boto3.resource(
        'sqs',
        aws_access_key_id='AKIAUK7LDPSVOWZAH57B',
        aws_secret_access_key='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',
        region_name='cn-north-1'
    )
    queue = queue_resource.Queue('https://sqs.cn-north-1.amazonaws.com.cn/298456415402/ping_queue')

    ip_groups = [{
        'name': 'group_1',
        'ping_ips': ['www.baidu.com']
    }]

    for item in ip_groups:
        print(f'current : {item}')
        resp = queue.send_message(
            MessageBody=json.dumps(item),
            DelaySeconds=0,
            # MessageGroupId=str(uuid.uuid1()), # fifo need
        )
        # time.sleep(1)
        print(resp)

    return {
        'statusCode': 200,
        'body': json.dumps('Hello from Lambda!')
    }
