import boto3
import json

queue_resource = boto3.resource(
    'sqs',
    aws_access_key_id='AKIAUK7LDPSVOWZAH57B',
    aws_secret_access_key='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',
    region_name='cn-north-1'
)
# queue = queue_resource.Queue('https://sqs.cn-north-1.amazonaws.com.cn/298456415402/action_queue')
queue = queue_resource.get_queue_by_name(QueueName='action_queue')


def acl_close():
    action_body = {'action': 'acl-close'}
    queue.send_message(
        MessageBody=json.dumps(action_body),
        DelaySeconds=0,
    )


def acl_open():
    action_body = {'action': 'acl-open'}
    queue.send_message(
        MessageBody=json.dumps(action_body),
        DelaySeconds=0,
    )


if __name__ == '__main__':
    acl_close()
    # test_open()
