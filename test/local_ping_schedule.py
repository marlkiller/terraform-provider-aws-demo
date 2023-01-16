import os

from src import ping_schedule

if __name__ == '__main__':
    os.environ.setdefault('TRAFFIC_CONFIG','dev-cn.traffic.config')
    ping_schedule.lambda_handler({}, {})

