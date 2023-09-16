FROM ghcr.io/linuxserver/baseimage-kasmvnc:ubuntujammy

RUN echo "Package: firefox*" >> /etc/apt/preferences.d/99mozillateamppa
RUN echo "Pin: release o=LP-PPA-mozillateam" >> /etc/apt/preferences.d/99mozillateamppa
RUN echo "Pin-Priority: 501" >> /etc/apt/preferences.d/99mozillateamppa
RUN echo "" >> /etc/apt/preferences.d/99mozillateamppa
RUN echo "Package: firefox*" >> /etc/apt/preferences.d/99mozillateamppa
RUN echo "Pin: release o=Ubuntu" >> /etc/apt/preferences.d/99mozillateamppa
RUN echo "Pin-Priority: -1" >> /etc/apt/preferences.d/99mozillateamppa

RUN  apt-get update && apt-get install -y apt-transport-https

RUN echo "deb     [signed-by=/usr/share/keyrings/tor-archive-keyring.gpg] https://deb.torproject.org/torproject.org jammy main" >> /etc/apt/sources.list.d/tor.list
RUN echo "deb-src [signed-by=/usr/share/keyrings/tor-archive-keyring.gpg] https://deb.torproject.org/torproject.org jammy main" >> /etc/apt/sources.list.d/tor.list

RUN wget -qO- https://deb.torproject.org/torproject.org/A3C4F0F979CAA22CDBA8F512EE8CBC9E886DDD89.asc | gpg --dearmor | tee /usr/share/keyrings/tor-archive-keyring.gpg >/dev/null

RUN apt-get update && add-apt-repository -y ppa:mozillateam/ppa && apt-get update && apt -y install -t 'o=LP-PPA-mozillateam' firefox libevent-dev libssl-dev  tor deb.torproject.org-keyring

COPY /root /

RUN chmod o+x ./harden.sh \
    && sh ./harden.sh \
    && rm ./harden.sh

RUN curl -L -o /tmp/xz-5.2.5.tar.gz https://github.com/therootcompany/xz-static/releases/download/v5.2.5/xz-5.2.5-linux-x86_64.tar.gz \
    && tar xvf /tmp/xz-5.2.5.tar.gz \
    &&  mv ./xz-*/*xz /usr/local/bin/

#RUN mkdir tor && cd tor && curl https://dist.torproject.org/torbrowser/12.5.4/tor-browser-linux64-12.5.4_ALL.tar.xz --output tb.tar.xz && tar -xf tb.tar.xz && chmod 777 -R .


    

