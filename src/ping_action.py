import os
import time

import boto3
from datetime import datetime
import logging
import json

os.putenv('TZ', 'Asia/Shanghai')
time.tzset()

client = boto3.client(
    'ec2',
    region_name='cn-north-1'
)


def filter_allow(i):
    # Egress 出口
    return i.get('RuleNumber') == 100 and i.get('CidrBlock') == '0.0.0.0/0' \
        and i.get('Protocol') == '-1' and not i.get('Egress') and i.get('RuleAction') == 'allow'


def filter_deny(i):
    return i.get('RuleNumber') == 100 and i.get('CidrBlock') == '0.0.0.0/0' \
        and i.get('Protocol') == '-1' and not i.get('Egress') and i.get('RuleAction') == 'deny'


def close_acl(acl_id):
    # deny
    # acls_entries = client.describe_network_acls(NetworkAclIds=[ACL_ID])['NetworkAcls'][0]['Entries']
    # current_entry = list(filter(filter_deny, acls_entries))
    # if len(current_entry) > 0:
    #     print(f'{acl_id} already deny')
    #     return
    client.replace_network_acl_entry(
        CidrBlock='0.0.0.0/0',
        Egress=False,
        NetworkAclId=acl_id,
        Protocol='-1',
        RuleAction='deny',
        RuleNumber=100
    )
    print(f"ACL closed time: {datetime.now()}")
    # acl_table.put_item(Item={
    #     'arn': ACL_ID,
    #     'status': 'deny',
    #     'update_time': str_now_time()
    # })


def open_acl(acl_id):
    # allow
    # acls_entries = client.describe_network_acls(NetworkAclIds=[ACL_ID])['NetworkAcls'][0]['Entries']
    # current_entry = list(filter(filter_allow, acls_entries))
    # if len(current_entry) > 0:
    #     print(f'{acl_id} already allow')
    #     return
    client.replace_network_acl_entry(
        CidrBlock='0.0.0.0/0',
        Egress=False,
        NetworkAclId=acl_id,
        Protocol='-1',
        RuleAction='allow',
        RuleNumber=100
    )
    print(f"ACL opened time: {datetime.now()}")
    # acl_table.put_item(Item={
    #     'arn': ACL_ID,
    #     'status': 'allow',
    #     'update_time': str_now_time()
    # })


def str_now_time():
    return datetime.now().strftime("%Y-%m-%d %H:%M:%S")


def lambda_handler(event, context):
    print(event)
    re = event['Records'][0]
    if re:
        event_source = re.get('EventSource')
        if event_source == "aws:sns":
            body = json.loads(re.get("Sns", {}).get('Message'))
            action = body.get('action', "")
            acl_id = body.get('acl_id')

            if action == "acl-close":
                logging.debug("closing")
                close_acl(acl_id)
            if action == "acl-open":
                logging.debug("opening")
                open_acl(acl_id)

    print(f"trigger time : {datetime.now()}")
