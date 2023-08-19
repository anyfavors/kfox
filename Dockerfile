FROM ghcr.io/linuxserver/baseimage-kasmvnc:alpine318
RUN apk add --no-cache firefox
COPY /root /

RUN chmod o+x ./harden.sh \
    && sh ./harden.sh \
    && rm ./harden.sh
    

