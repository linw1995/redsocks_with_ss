#!/bin/bash
set -e

cp /shadowsocks_config.json.template /shadowsocks_config.json
cp /redsocks.conf.template /redsocks.conf

# log current settings
echo "== Envs =="
echo "  redsocks_local_ip=$redsocks_local_ip"
echo "  redsocks_local_port=$redsocks_local_port"

echo "  ss_server=$ss_server"
echo "  ss_server_port=$ss_server_port"
echo "  ss_local_address=$ss_local_address"
echo "  ss_local_port=$ss_local_port"
echo "  ss_password=$ss_password"
echo "  ss_method=$ss_method"

# apply current settings
sed -i "s/<local_ip>/$redsocks_local_ip/g" /redsocks.conf
sed -i "s/<local_port>/$redsocks_local_port/g" /redsocks.conf
sed -i "s/<ip>/$ss_local_address/g" /redsocks.conf
sed -i "s/<port>/$ss_local_port/g" /redsocks.conf

sed -i "s/<server>/$ss_server/g" /shadowsocks_config.json
sed -i "s/<server_port>/$ss_server_port/g" /shadowsocks_config.json
sed -i "s/<local_address>/$ss_local_address/g" /shadowsocks_config.json
sed -i "s/<local_port>/$ss_local_port/g" /shadowsocks_config.json
sed -i "s/<password>/$ss_password/g" /shadowsocks_config.json
sed -i "s/<method>/$ss_method/g" /shadowsocks_config.json

# log applyed result
echo "== sslocal configuration =="
cat /shadowsocks_config.json

echo "== redsocks configuration =="
cat /redsocks.conf

# running
echo ">> starting sslocal <<"
sslocal -c /shadowsocks_config.json -d start

echo ">> starting redsocks <<"
redsocks -c /redsocks.conf
