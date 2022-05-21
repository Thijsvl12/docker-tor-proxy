#!/bin/sh

set -eux

echo "nameserver 127.0.0.1" > /etc/resolv.conf

/usr/sbin/nft -f /etc/nftables.conf

/usr/sbin/tor -f /etc/torrc