import json
import os

from datetime import datetime
import smtplib
import traceback
from email.mime.multipart import MIMEMultipart
from email.mime.text import MIMEText


def send_email(event, receiver, subject, to_cc: list = []):
    username = os.getenv("USERNAME", "PM92652@europe.bmw.corp")
    password = os.getenv("PASSWORD", "Ilovetoeatbanana2024*")
    sender = os.getenv("SENDER", "TSP-CLOUD-Notification@bmw.com")
    mail_host = os.getenv("MAIL_HOST", "mail.bmwgroup.net")
    port = os.getenv("PORT", "587")

    message = MIMEMultipart()
    message.add_header('From', sender)
    message.add_header('To', ','.join(receiver))
    message.add_header('Cc', ','.join(to_cc))
    message.add_header('Subject', '[Automatic Notification]' + subject)
    message.add_header('Date', datetime.now().strftime('%Y-%m-%d'))
    content = process_event(event)
    message.attach(MIMEText(content, 'html'))
    toaddrs = receiver + to_cc
    try:
        print(f"send mail log record : {message}")
        smtp = smtplib.SMTP(mail_host, port)
        smtp.starttls()
        smtp.login(username, password)
        smtp.sendmail(sender, toaddrs, message.as_string())
    except Exception as e:
        traceback.print_exc()
        print('send email error {}'.format(e))
        return 0
    return 200


def process_event(event):
    # TODO event logic
    return json.dumps(event)


def lambda_handler(event, context):
    # this group can read from dynamodb
    notify_mail_group = [
        "liu.zhan@99cloud.net"
    ]
    subject = "testing lambda subject"
    cc_list = []

    send_email(event, notify_mail_group, subject, cc_list)
    # TODO implement
    return {
        'statusCode': 200,
        'body': json.dumps('Hello from Lambda!')
    }
