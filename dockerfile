FROM debian:latest

RUN apt-get update
RUN apt-get upgrade -qy
RUN apt-get install redsocks shadowsocks -qy

ADD src/* /

ENV redsocks_local_ip=0.0.0.0
ENV redsocks_local_port=12345
ENV ss_server=127.0.0.1
ENV ss_server_port=12345
ENV ss_local_address=127.0.0.1
ENV ss_local_port=1080
ENV ss_password=password
ENV ss_method=aes-256-cfb

CMD /run.sh
