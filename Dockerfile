FROM python:3.11

WORKDIR /app

COPY . /app

RUN rm -rf /etc/apt/sources.list.d/* && \
    echo "deb http://mirrors.aliyun.com/debian bookworm main contrib non-free\n\
deb http://mirrors.aliyun.com/debian-security bookworm-security main contrib non-free\n\
deb http://mirrors.aliyun.com/debian bookworm-updates main contrib non-free\n\
deb http://mirrors.aliyun.com/debian bookworm-backports main contrib non-free" \
> /etc/apt/sources.list && \
    apt-get update && \
    apt-get install -y curl gnupg && \
    curl -sL https://deb.nodesource.com/setup_20.x  | bash - && \
    apt-get install -y nodejs

RUN pip install --no-cache-dir -i https://mirrors.aliyun.com/pypi/simple/ -r requirements.txt

RUN apt-get update && \
    apt-get install -y ffmpeg tzdata && \
    ln -fs /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && \
    dpkg-reconfigure -f noninteractive tzdata

CMD ["python", "main.py"]
