# FROM指令指定了基础镜像是python:3.6-alpine，这个基础镜像包含了Alpine Linux操作系统和Python 3.6

FROM python : 3.6 - alpine
# WORKDIR指令将工作目录切换为/app
WORKDIR / app

# ADD指令将当前目录下的所有内容（app.py、requirements.txt）复制到镜像的 /app 目录下
ADD . / app

# RUN指令运行pip命令安装依赖
RUN pip install - i https : //pypi.tuna.tsinghua.edu.cn/simple -r requirements.txt

# EXPOSE指令暴露允许被外界访问的8083端口
EXPOSE 8083

# ENV指令设置环境变量NAME
ENV NAME World

# CMD指令设置容器内进程为：python app.py，即：这个 Python 应用的启动命令
CMD ["python", "app.py"]
