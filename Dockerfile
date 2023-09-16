FROM ghcr.io/linuxserver/baseimage-kasmvnc:ubuntujammy
RUN apt-get update && apt-get -y install apt-transport-https \
    && snap install firefox \
    && wget -qO- https://deb.torproject.org/torproject.org/A3C4F0F979CAA22CDBA8F512EE8CBC9E886DDD89.asc | gpg --dearmor | tee /usr/share/keyrings/tor-archive-keyring.gpg >/dev/null \
    && apt install tor deb.torproject.org-keyring

COPY /root /
COPY /root/tor.list /etc/apt/sources.list.d/

RUN chmod o+x ./harden.sh \
    && sh ./harden.sh \
    && rm ./harden.sh \
    && useradd --system --no-create-home --shell /bin/false www-data 
    

