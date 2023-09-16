FROM ghcr.io/linuxserver/baseimage-kasmvnc:ubuntujammy
RUN apt-get update && apt-get -y install libgtk-3-0
    
COPY /root /

RUN chmod o+x ./harden.sh \
    && sh ./harden.sh \
    && rm ./harden.sh

RUN curl -L -o /tmp/xz-5.2.5.tar.gz https://github.com/therootcompany/xz-static/releases/download/v5.2.5/xz-5.2.5-linux-x86_64.tar.gz \
    && tar xvf /tmp/xz-5.2.5.tar.gz \
    &&  mv ./xz-*/*xz /usr/local/bin/


    

