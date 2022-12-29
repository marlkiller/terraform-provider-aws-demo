import logging
import time

from logging import handlers
from datetime import datetime
from pathlib import Path
import os


def get_logger(log_file_path: str = "/opt/logs/monitor.logs"):
    # 检测日志目录
    log_dir_path = os.path.dirname(log_file_path)
    log_dir = Path(log_dir_path)
    if not log_dir.exists():
        os.mkdir(log_dir_path)

    # 创建一个logger，并设置日志级别
    logger = logging.getLogger()
    logger.setLevel(logging.DEBUG)

    # 设置滚动文件10M
    rfh = handlers.RotatingFileHandler(
        log_file_path,
        mode='a',
        maxBytes=10 * 1024 * 1024,
        backupCount=1,
        encoding=None,
        delay=False
    )
    rfh.setLevel(logging.INFO)

    # 创建一个handler，用于将日志输出到控制台，并设置日志级别
    ch = logging.StreamHandler()
    ch.setLevel(logging.INFO)

    # 定义handler的输出格式
    formatter = logging.Formatter(
        '%(asctime)s-%(name)s-[%(filename)s:%(lineno)d]''-[%(levelname)s]: %(message)s')
    rfh.setFormatter(formatter)
    ch.setFormatter(formatter)

    # 给logger添加handler
    logger.addHandler(rfh)
    logger.addHandler(ch)

    return logger


if __name__ == '__main__':
    logger = get_logger("./logs/monitor.log")
    for x in range(10):
        logger.info(f"Test Record Time: {datetime.now()}")
        time.sleep(0.1)
