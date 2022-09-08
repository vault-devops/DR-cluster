#!/usr/bin/env bash 
set -eu

VAULT_VERSION=1.5.9+ent
ARCH='amd64'

VAULT_BIN=vault_${VAULT_VERSION}_linux_${ARCH}.zip

if [ ! -f ${VAULT_BIN} ] ; then 
    echo "[$(date)] downloading vault $VAULT_BIN "

    curl https://releases.hashicorp.com/vault/${VAULT_VERSION}/${VAULT_BIN} -o  ${VAULT_BIN}
    echo "[$(date)] unziping $VAULT_BIN "
    unzip ${VAULT_BIN}
fi 

mkdir -p vault02/config
mkdir -p vault02/file 
echo '{"backend": {"raft": {"path": "vault02/file"}}, "default_lease_ttl": "168h", "max_lease_ttl": "720h", "listener": {"tcp":{"address": "127.0.0.1:8300", "tls_disable": true}}, "cluster_addr":"http://127.0.0.1:8301", "api_addr":"http://127.0.0.1:8300", "disable_mlock": true}'> vault02/config/vault02.json



./vault server -config vault02/config/vault02.json     