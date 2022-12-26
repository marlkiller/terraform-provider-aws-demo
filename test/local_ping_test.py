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


if __name__ == '__main__':
    do_func(t1)
    do_func(t2)
    do_func(t3)
