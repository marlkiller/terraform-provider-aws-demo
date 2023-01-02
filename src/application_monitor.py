import logging
import os
import time
import colorlog
from logging import handlers


def get_color_logger():
    logger = logging.getLogger()
    logger.setLevel(logging.DEBUG)

    rfh = handlers.RotatingFileHandler(
        "./monitor.log",
        mode='a',
        maxBytes=10 * 1024 * 1024,
        backupCount=1,
        encoding=None,
        delay=False
    )
    rfh.setLevel(logging.DEBUG)

    ch = logging.StreamHandler()
    ch.setLevel(logging.DEBUG)

    log_colors_config = {
        "DEBUG": "cyan",
        "INFO": "green",
        "WARNING": "yellow",
        "ERROR": "red",
        # "CRITICAL": "bold_red"
        "CRITICAL": "red,bg_white"
    }

    # 定义handler的输出格式
    formatter = colorlog.ColoredFormatter(
        fmt='%(log_color)s%(asctime)s.%(msecs)03d ''-[%(levelname)s]: %(message)s',
        reset=True,
        datefmt="%Y-%m-%d %H:%M:%S",
        # log_colors=log_colors_config,
        secondary_log_colors={},
        style='%'
    )
    ch.setFormatter(formatter)
    rfh.setFormatter(formatter)

    # 给logger添加handler
    logger.addHandler(ch)
    logger.addHandler(rfh)

    return logger


def monitor_application_task():
    logger = get_color_logger()

    ip = "10.0.0.50"
    while 1:

        cmd = f"ping -c 1 -W 1 {ip}"
        ret = os.system(cmd)
        if ret == 0:
            logger.info("Application Network Status: [CONNECTION]")
        else:
            logger.warning("Application Network Status: [DISCONNECTION]")
        time.sleep(0.1)


if __name__ == '__main__':
    monitor_application_task()





