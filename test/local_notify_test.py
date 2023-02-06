from datetime import datetime

import boto3

client = boto3.client(
    'events',
    region_name='cn-north-1'
)


def test_put_event():
    response = client.put_events(
        Entries=
        [
            {
                'Time': datetime(2022, 12, 12),
                'Source': 'test.bmw.com',
                "Resources": [
                    "resource1",
                    "resource2"
                ],
                "DetailType": "myDetailType",
                "Detail": '{ "test": "lambda", "error": "this is a testing error" }'
            }
        ]
    )
    print(response)


if __name__ == '__main__':
    test_put_event()

