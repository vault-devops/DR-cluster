#!/usr/bin/env bash 
echo "[$(date)] vault02 env variables "

export VAULT_ADDR="http://127.0.0.1:8300"
export VAULT_TOKEN=$( grep 'Initial Root Token: ' vault02_keys|awk '{print $NF}')


