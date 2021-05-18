#!/bin/bash

name="$(getent passwd $(whoami) | awk -F: '{print $5}')"
out_dir='/root/module-signing'
# sudo mkdir ${out_dir}
sudo openssl \
    req \
    -new \
    -x509 \
    -newkey \
    rsa:2048 \
    -keyout ${out_dir}/MOK.priv \
    -outform DER \
    -out ${out_dir}/MOK.der \
    -days 36500 \
    # -subj "/CN=${henry}/"
sudo chmod 600 ${out_dir}/MOK*
