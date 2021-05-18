# -*- coding:UTF-8 -*-

import os

# 检测进程是否存在
def isRunning(process_name):
    try:
        process = len(os.popen('ps aux | grep "' + process_name + '" | grep -v grep | grep -v tail | grep -v keepH5ssAlive').readlines())
        if process >= 1:

            return True
        else:
            return False
    except:
        print("Check process ERROR!!!")
        return False

# 重新拉起进程
def startProcess(process_script):
    try:
        result_code = os.system(process_script)
        if result_code == 0:
            return True
        else:
            return False
    except:
        print("Process start Error!!!")
        return False

# 服务监控入口
def monitorService(process_name):
    if isRunning(process_name) == False:
       startProcess('your_start_process_script')
