# SOS-Vault-DR-Promotion-Demotion
A playground using Docker to get familiar with promoting and demoting DR cluster

For more details check [Disaster Recovery Replication Setup](https://learn.hashicorp.com/tutorials/vault/disaster-recovery?in=vault/enterprise) 
# **NOTE: There are NO secrets here**

# Overview 

There two approaches for the tutorial using Docker or Bash scripts 


## Docker Approach Overview

The `Dockerfile` and `docker-entrypoint.sh` based on [this repo](https://github.com/hashicorp/docker-vault/blob/72a3539fd91085b2d51cfc87cd9bcf0804e3a5cf/0.X/Dockerfile). Only

We will be following the steps outlined in the [Disaster Recovery Replication Setup](https://learn.hashicorp.com/tutorials/vault/disaster-recovery?in=vault/enterprise)and [Monitoring Vault Replication](https://learn.hashicorp.com/tutorials/vault/monitor-replication) to check the status of the replication 

Two single-node cluster will be created with `docker compose up` vault01 and vault02. vault01 will be primary and vault02 will be secondary. 

### Initial Setup (Docker)

1. Setup 2 single-node clusters which is using Raft storage backend 

```shell
$ ./01_bringup_vaults.sh # docker compose up 
```

2. Run `./setup_base.sh` to initialise and unseal the backend 

```shell
$ ./02_setup_base.sh
```

3. Create 2 separate shell, one will be for vault01 and the other for vault02. Please make sure use source or `. ./script`

> on shell 1. Some keys/secrets will be created

```shell
$ . ./03_setup_vault01.sh
```


> on shell 2 

```shell
$ . ./04_setup_vault02.sh

```


## Script Approach Overview
 

Two single-node cluster will be created. vault01 will be primary and vault02 will be secondary. 

### Initial Setup  

1. On terminal or shell 1. Setup 2 single-node clusters which is using Raft storage backend

```shell
$ ./01_bringup_vault01.sh
```

2. Create a separate terminal or shell. And run  

```shell
$ ./02_bringup_vault02.sh
```

3.  Run `./03_setup_base.sh` to initialise and unseal the backend 

```shell
$ ./03_setup_base.sh

```
4. Create 2 separate shells again, one will be for vault01 and the other for vault02. Please make sure use source or `. ./script`

> on shell 1. Some keys/secrets will be created

```shell
$ . ./04_setup_vault01.sh
```


> on shell 2 

```shell
$ . ./05_setup_vault02.sh

```



#### This vault version seals every 30 mins. To unseal use ./06_unseal_all_vaults.sh to unseal



# Once setup is done head over to [Disaster Recovery Replication Setup](https://learn.hashicorp.com/tutorials/vault/disaster-recovery?in=vault/enterprise)  
