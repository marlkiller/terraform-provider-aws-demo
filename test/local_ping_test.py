from ping3 import ping
import time
import os
from subprocess import getoutput

addr = "192.168.1.123"


# addr = "baidu.com"


def t1():
    for x in range(1):
        # print(x)
        a = ping(addr)
        print(a)
        # time.sleep(1)


def t2():
    for x in range(1):
        cmd = f"ping -c 1 -t 1 {addr}"
        # print(x)
        rs_code = os.system(cmd)
        print(rs_code)
        # time.sleep(1)


def t3():
    for x in range(1):
        cmd = f"ping -c 1 -t 1 {addr}"
        # print(x)
        a = getoutput(cmd)
        print(a)
        # time.sleep(1)


def do_func(x):
    print("\n")
    s = time.time()
    x()
    e = time.time()
    print(e - s)
    print("\n")


class ConflictException(Exception):
    def __init__(self, message) -> None:
        super().__init__(self)
        self.message = message

    def __str__(self):
        return self.message


def do_dev(x):
    raise ConflictException(
        message=f'ARN {"name"} is currently locked more than {"TASK_RUN_TIME"} seconds. Release this lock ??')


if __name__ == '__main__':
    try:
        do_dev('')
    except ConflictException as e:
        print(e)
    except Exception as e:
        print(e)
