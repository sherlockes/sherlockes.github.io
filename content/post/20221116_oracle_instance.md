---
title: "Crear y configurar una instancia gratuita en Oracle"
date: "2022-11-16"
creation: "2022-11-16"
description: "Descripción"
thumbnail: "images/20221116_oracle_instance_00.jpg"
disable_comments: true
authorbox: false
toc: false
mathjax: false
categories:
- "computing"
tags:
- "bash"
draft: true
weight: 5
---
Resumen de introducción
<!--more-->

ssh -i ssh.key ubuntu@ip


https://my.noip.com/dynamic-dns/duc

sudo apt install make
sudo apt install gcc

```bash
ubuntu@oracle-sherver:/usr/local/src/noip-2.1.9-1$ sudo make install
if [ ! -d /usr/local/bin ]; then mkdir -p /usr/local/bin;fi
if [ ! -d /usr/local/etc ]; then mkdir -p /usr/local/etc;fi
cp noip2 /usr/local/bin/noip2
/usr/local/bin/noip2 -C -c /tmp/no-ip2.conf

Auto configuration for Linux client of no-ip.com.

Please enter the login/email string for no-ip.com  sherlockes@gmail.com
Please enter the password for user 'sherlockes@gmail.com'  ********************

3 hosts are registered to this account.
Do you wish to have them all updated?[N] (y/N)  N
Do you wish to have host [cincoolivas.ddns.net] updated?[N] (y/N)  N
Do you wish to have host [sherblog.ddns.net] updated?[N] (y/N)  N
Do you wish to have host [sherver.ddns.net] updated?[N] (y/N)  y
Please enter an update interval:[30]  
Do you wish to run something at successful update?[N] (y/N)  ^M

New configuration file '/tmp/no-ip2.conf' created.

mv /tmp/no-ip2.conf /usr/local/etc/no-ip2.conf
```

![image-01]

### Enlaces de interés
- [enlace](www.sherblog.pro)

[link]: https://www.google.es

[image-01]: /images/20221116_oracle_instance_01.jpg



