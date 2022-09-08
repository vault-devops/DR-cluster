#!/usr/bin/env bash 


function unseal_vault {
    local addr="$1"
    local keys="$2"
    
    echo "[$(date)] Now Unseal $addr"
    vault operator unseal -address="$addr" $(grep 'Key 1:' "$keys" | awk '{print $NF}')
    vault operator unseal -address="$addr" $(grep 'Key 2:' "$keys" | awk '{print $NF}')
    vault operator unseal -address="$addr" $(grep 'Key 3:' "$keys" | awk '{print $NF}')
    if [[ "$?" -ne 0 ]]; then 
        echo "[$(date)] vault unseal failed on  $addr "
        exit 1
    fi 
}

echo "[$(date)] Initialising vault01 "

# check if vault is initialised  - vault status
#
keys=$(vault operator init -address=http://127.0.0.1:8200)  
if [[ "$?" -ne 0 ]]; then 
    echo "[$(date)]  vault operator init on vault01 failed"
    exit 1
fi 
echo -e "$keys" > vault01_keys
keys=$(vault operator init -address=http://127.0.0.1:8300 ) 
if [[ "$?" -ne 0 ]]; then 
    echo "[$(date)]  vault operator init on vault02 failed"
    exit 1
fi 
echo -e "$keys" > vault02_keys

unseal_vault "http://127.0.0.1:8200" vault01_keys
  
unseal_vault "http://127.0.0.1:8300" vault02_keys