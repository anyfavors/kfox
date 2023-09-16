FROM ghcr.io/linuxserver/baseimage-kasmvnc:ubuntujammy
RUN apt-get update && apt-get install libgtk-3-0
    
COPY /root /

RUN chmod o+x ./harden.sh \
    && sh ./harden.sh \
    && rm ./harden.sh \
    && useradd --system --no-create-home --shell /bin/false www-data \
    && curl -L -o /tmp/xz-5.2.5.tar.gz https://github.com/therootcompany/xz-static/releases/download/v5.2.5/xz-5.2.5-linux-x86_64.tar.gz \
    && tar xvf /tmp/xz-5.2.5.tar.gz \
    && sudo mv /tmp/xz-*/*xz /usr/local/bin/


    

