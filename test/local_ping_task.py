import json

import ping_task

if __name__ == '__main__':
    ping_task.lambda_handler({
        'Records': [
            {
                'body': json.dumps({
                    'name': 'group_1',
                    'ping_ips': ['www.baidu.com']
                })
            }
        ]
    },{})
