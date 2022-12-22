import boto3
from datetime import datetime
import logging
import json

ACL_ID = "acl-0d5098dea8ba07575"

client = boto3.client(
    'ec2',
    region_name='cn-north-1'
)


def close_acl(acl_id):
    # deny
    client.replace_network_acl_entry(
        CidrBlock='0.0.0.0/0',
        Egress=False,
        NetworkAclId=acl_id,
        Protocol='-1',
        RuleAction='deny',
        RuleNumber=100
    )
    print(f"ACL closed time: {datetime.now()}")


def open_acl(acl_id):
    # allow
    client.replace_network_acl_entry(
        CidrBlock='0.0.0.0/0',
        Egress=False,
        NetworkAclId=acl_id,
        Protocol='-1',
        RuleAction='allow',
        RuleNumber=100
    )
    print(f"ACL opened time: {datetime.now()}")


def lambda_handler(event, context):
    print(event)
    re = event['Records'][0]
    if re:
        event_source = re.get('eventSource')
        if event_source == "aws:sqs":
            body = json.loads(re.get("body", {}))
            action = body.get('action', "")

            if action == "acl-close":
                logging.debug("closing")
                close_acl(ACL_ID)
            if action == "acl-open":
                open_acl(ACL_ID)
                logging.debug("opening")

    print(f"触发时间: {datetime.now()}")
