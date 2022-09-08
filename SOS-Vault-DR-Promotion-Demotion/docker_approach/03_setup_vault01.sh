#!/usr/bin/env bash 
echo "[$(date)] vault01 env variables "

export VAULT_ADDR="http://127.0.0.1:8200"
export VAULT_TOKEN=$( grep 'Initial Root Token: ' vault01_keys|awk '{print $NF}')

vault secrets enable -path=kv kv
 
echo "[$(date)] Write some secrets "

for s in $(seq 0 50); do 
    vault write kv/"$s" value="$(date)"
done 