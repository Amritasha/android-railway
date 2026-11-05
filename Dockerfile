FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive
ENV ANDROID_HOME=/opt/android-sdk
ENV PATH=$PATH:$ANDROID_HOME/cmdline-tools/latest/bin:$ANDROID_HOME/platform-tools

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y wget curl git python3 python3-pip neofetch \
        openjdk-17-jdk gradle \
        net-tools iproute2 iputils-ping dnsutils \
        vim nano htop tree unzip zip \
        build-essential gcc g++ make \
        openssh-client telnet netcat-openbsd \
        jq less man-db sudo lsof strace && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

RUN mkdir -p $ANDROID_HOME/cmdline-tools && \
    wget -q https://dl.google.com/android/repository/commandlinetools-linux-11076708_latest.zip -O /tmp/cmdtools.zip && \
    unzip -q /tmp/cmdtools.zip -d /tmp/cmdtools && \
    mv /tmp/cmdtools/cmdline-tools $ANDROID_HOME/cmdline-tools/latest && \
    rm -rf /tmp/cmdtools /tmp/cmdtools.zip

RUN yes | sdkmanager --licenses && \
    sdkmanager "platform-tools" "build-tools;34.0.0" "platforms;android-34"

RUN wget -qO /bin/ttyd https://github.com/tsl0922/ttyd/releases/download/1.7.3/ttyd.x86_64 && \
    chmod +x /bin/ttyd

RUN echo "neofetch" >> /root/.bashrc && \
    echo "cd /root" >> /root/.bashrc && \
    echo "export ANDROID_HOME=$ANDROID_HOME" >> /root/.bashrc && \
    echo "export PATH=\$PATH:\$ANDROID_HOME/cmdline-tools/latest/bin:\$ANDROID_HOME/platform-tools" >> /root/.bashrc

EXPOSE 7681

CMD ["/bin/bash", "-c", "\
    echo \"export PS1='\\[\\033[01;32m\\]$USERNAME@\\h\\[\\033[00m\\]:\\[\\033[01;34m\\]\\w\\[\\033[00m\\]\\$ '\" >> /root/.bashrc && \
    exec /bin/ttyd -p \"$PORT\" -c \"$USERNAME:$PASSWORD\" /bin/bash"]
