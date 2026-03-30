#!/bin/bash

mkdir -p certs && cd certs
openssl genrsa -out ca.key 2048
 
openssl req -x509 -new -nodes -key ca.key -sha256 -days 3650 -out ca.crt \
    -subj "//CN=SS-Project-CA"

openssl genrsa -out server.key 2048

openssl req -new -key server.key -out server.csr \
    -subj "//CN=192.168.50.20" \
    -addext "subjectAltName=IP:192.168.50.20"
 
openssl x509 -req -in server.csr \
    -CA ca.crt -CAkey ca.key -CAcreateserial \
    -out server.crt -days 365 -sha256 \
    -copy_extensions copyall
