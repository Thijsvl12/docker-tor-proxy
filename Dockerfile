FROM debian:sid-slim

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get upgrade -y && \
  apt-get install -y \
    apt-utils \
    apt-transport-https \
    ca-certificates \
    gpg \
    nftables \
    wget \
  --no-install-recommends && \
  echo "deb [signed-by=/usr/share/keyrings/tor-archive-keyring.gpg] https://deb.torproject.org/torproject.org sid main\ndeb-src [signed-by=/usr/share/keyrings/tor-archive-keyring.gpg] https://deb.torproject.org/torproject.org sid main" > /etc/apt/sources.list.d/tor.list && \
  wget -qO- https://deb.torproject.org/torproject.org/A3C4F0F979CAA22CDBA8F512EE8CBC9E886DDD89.asc | gpg --dearmor | tee /usr/share/keyrings/tor-archive-keyring.gpg >/dev/null && \
  apt-get update && apt-get install -y \
    tor \
  --no-install-recommends && \
  rm -rf /var/lib/apt/lists/*
  
COPY ./torrc /etc/torrc

COPY ./nftables.conf /etc/nftables.conf

COPY ./docker-entrypoint.sh  /docker-entrypoint.sh

ENTRYPOINT [ "/bin/sh", "/docker-entrypoint.sh" ]