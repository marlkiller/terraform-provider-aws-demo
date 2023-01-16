import _thread
import json
import os
import urllib.request
import urllib.parse

import boto3

"""
# PE
192.168.201.34
192.168.201.30
"""

vm_status_table = boto3.resource('dynamodb').Table('network_monitor_vm')
ssm_client = boto3.client('ssm')


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
    """
    {
        "name": "group_PE",
        "ping_ips": [
            "192.168.201.34",
            "192.168.201.30"
        ],
        "acl_id": "acl-0d5098dea8ba07575"
    } 
    """
    traffic_config = ssm_client.get_parameter(
        Name=os.getenv('TRAFFIC_CONFIG'),
        WithDecryption=True
    )['Parameter']['Value']
    ip_group = json.loads(traffic_config)
    vm_list = vm_status_table.scan()['Items']
    if not vm_list:
        raise Exception("vm_list is null")
    for vm in vm_list:
        print(f"url_lib_post : {vm.get('receive_messages_url')},{ip_group}")
        _thread.start_new_thread(url_lib_post, (vm.get('receive_messages_url'), ip_group))

    return {
        'statusCode': 200,
        'body': json.dumps('Hello from Lambda!')
    }
