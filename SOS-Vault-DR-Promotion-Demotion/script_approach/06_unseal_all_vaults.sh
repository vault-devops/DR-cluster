#!/usr/bin/env bash 

function unseal_vault {
    local addr="$1"
    local keys="$2"
    
    echo "[$(date)] Now Unseal $addr"
    vault operator unseal -address="$addr" $(grep 'Key 1:' "$keys" | awk '{print $NF}')
    vault operator unseal -address="$addr" $(grep 'Key 2:' "$keys" | awk '{print $NF}')
    vault operator unseal -address="$addr" $(grep 'Key 3:' "$keys" | awk '{print $NF}')
 
}



unseal_vault "http://127.0.0.1:8200" vault01_keys
  
unseal_vault "http://127.0.0.1:8300" vault02_keys