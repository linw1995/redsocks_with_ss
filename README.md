# Redsocks with ss

Proxy network traffic throught the ss.

## Build

```
docker build -t redsocks_with_ss .
```

## Using iptables to redirect the http[s] traffic coming from 172.21.0.1/32

```
docker run \
    -d \
    --privileged \
    --name rs \
    --net host \
    -e ss_server=$server \
    -e ss_server_port=$server_port \
    -e ss_password=password \
    redsocks_with_ss
iptables \
    -t nat \
    -I PREROUTING 1 \
    -s 172.21.0.1/32 \
    -p tcp \
    -m multiport 80,443 \
    -j REDIRECT --to-ports 1081 \
    -w \
    -m comment --comment "redsocks with ss proxy"
```
