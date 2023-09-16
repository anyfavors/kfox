FROM ghcr.io/linuxserver/baseimage-kasmvnc:ubuntujammy
RUN apt-get install firefox

COPY /root /

RUN chmod o+x ./harden.sh \
    && sh ./harden.sh \
    && rm ./harden.sh
    

