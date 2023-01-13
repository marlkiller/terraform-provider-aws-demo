import _thread
import json
import urllib.request
import urllib.parse

import boto3

"""
# PE
192.168.201.34
192.168.201.30
"""

vm_status_table = boto3.resource('dynamodb').Table('network_monitor_vm')
queue_resource = boto3.resource('sqs')


def url_lib_post(url, body):
    try:
        params = json.dumps(body)
        headers = {'Accept-Charset': 'utf-8', 'Content-Type': 'application/json'}
        params = bytes(params, 'utf8')
        req = urllib.request.Request(url=url, data=params, headers=headers, method='POST')
        urllib.request.urlopen(req).read()
    except Exception as e:
        print(f'url_lib_post error {url}: {str(e)}')


def lambda_handler(event, context):
    ip_groups = [{
        'name': 'group_PE',
        'ping_ips': [
            '192.168.201.34',
            '192.168.201.30',
        ]
    }]
    vm_list = vm_status_table.scan()['Items']
    if not vm_list:
        raise Exception("vm_list is null")
    for vm in vm_list:
        for ip_group in ip_groups:
            print(f"url_lib_post : {vm.get('receive_messages_url')},{ip_group}")
            _thread.start_new_thread(url_lib_post, (vm.get('receive_messages_url'), ip_group))

    # sqs_ping_queue_list = queue_resource.queues.filter(
    #     QueueNamePrefix='ping_queue_',
    #     MaxResults=100
    # )
    # for sqs_item in sqs_ping_queue_list:
    #     for item in ip_groups:
    #         print(f'sqs : {sqs_item}, msg : {item}')
    #         sqs_item.send_message(
    #             MessageBody=json.dumps(item),
    #             DelaySeconds=0,
    #             # MessageGroupId=str(uuid.uuid1()), # fifo need
    #         )

    return {
        'statusCode': 200,
        'body': json.dumps('Hello from Lambda!')
    }


if __name__ == '__main__':
    lambda_handler({}, {})
