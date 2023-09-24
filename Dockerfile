FROM ghcr.io/linuxserver/baseimage-kasmvnc:alpine318
RUN apk add --no-cache flatpak firefox
RUN flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
RUN flatpak install -y flathub com.brave.Browser
COPY /root /

RUN chmod o+x ./harden.sh \
    && sh ./harden.sh \
    && rm ./harden.sh
