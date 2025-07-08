FROM python:3.11-bookworm

WORKDIR /app

COPY . /app

RUN rm -rf /etc/apt/sources.list.d/* && \
    echo "deb https://mirrors.tuna.tsinghua.edu.cn/debian bookworm main contrib non-free non-free-firmware\n\
deb https://mirrors.tuna.tsinghua.edu.cn/debian-security bookworm-security main contrib non-free non-free-firmware\n\
deb https://mirrors.tuna.tsinghua.edu.cn/debian bookworm-updates main contrib non-free non-free-firmware\n\
deb https://mirrors.tuna.tsinghua.edu.cn/debian bookworm-backports main contrib non-free non-free-firmware" \
> /etc/apt/sources.list

RUN apt-get update

RUN apt-get install -y curl gnupg

RUN curl -sL https://deb.nodesource.com/setup_20.x  | bash -

RUN apt-get install -y nodejs

RUN pip install --no-cache-dir -i https://mirrors.aliyun.com/pypi/simple/ -r requirements.txt

RUN apt-get update

RUN apt-get install -y --no-install-recommends ffmpeg tzdata

RUN ln -fs /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

RUN dpkg-reconfigure -f noninteractive tzdata

RUN rm -rf /var/lib/apt/lists/*

CMD ["python", "main.py"]
