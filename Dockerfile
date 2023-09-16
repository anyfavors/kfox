FROM ghcr.io/linuxserver/baseimage-kasmvnc:ubuntujammy
RUN apt-get update && apt-get -y install firefox

COPY /root /

RUN chmod o+x ./harden.sh \
    && sh ./harden.sh \
    && rm ./harden.sh \
    && useradd --system --no-create-home --shell /bin/false www-data
    

