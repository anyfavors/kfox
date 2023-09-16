FROM ghcr.io/linuxserver/baseimage-kasmvnc:ubuntujammy

RUN echo "Package: firefox*" >> /etc/apt/preferences.d/99mozillateamppa
RUN echo "Pin: release o=LP-PPA-mozillateam" >> /etc/apt/preferences.d/99mozillateamppa
RUN echo "Pin-Priority: 501" >> /etc/apt/preferences.d/99mozillateamppa
RUN echo "" >> /etc/apt/preferences.d/99mozillateamppa
RUN echo "Package: firefox*" >> /etc/apt/preferences.d/99mozillateamppa
RUN echo "Pin: release o=Ubuntu" >> /etc/apt/preferences.d/99mozillateamppa
RUN echo "Pin-Priority: -1" >> /etc/apt/preferences.d/99mozillateamppa

RUN sudo add-apt-repository -y ppa:mozillateam/ppa && apt-get update && apt -y install -t 'o=LP-PPA-mozillateam' firefox

COPY /root /

RUN chmod o+x ./harden.sh \
    && sh ./harden.sh \
    && rm ./harden.sh

RUN curl -L -o /tmp/xz-5.2.5.tar.gz https://github.com/therootcompany/xz-static/releases/download/v5.2.5/xz-5.2.5-linux-x86_64.tar.gz \
    && tar xvf /tmp/xz-5.2.5.tar.gz \
    &&  mv ./xz-*/*xz /usr/local/bin/


    

