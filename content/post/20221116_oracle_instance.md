---
title: "Crear y configurar una instancia gratuita en Oracle"
date: "2022-11-16"
creation: "2022-11-16"
description: "Descripción"
thumbnail: "images/20221116_oracle_instance_00.jpg"
disable_comments: true
authorbox: false
toc: true
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
El proceso de la creación de la cuenta en [Oracle Cloud] puede llegar a ser desesperante por la lentitud del entorno. A la hora de crear una nueva instancia 

### Acceder a la máquina remota

ssh -i ssh.key ubuntu@ip


### Asignar DNS dinámico
https://www.noip.com

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

### Añadir un usuario

- Acceder a la máquina remota mediante `ssh -i ssh_pub.key ubuntu@loquesea.ddns.net` donde "ssh_pub.key" es el archivo correspondiente a la llave pública que se genera al crear la instancia.
- Cambiar al usuario "root" con el comando `sudo su`
- Crear el nuevo usuario (Con el mismo nombre que tenemos en la terminal desde la que estamos accediendo a la mátuina remota) con `useradd nuevo_usuario`
- Crear el directorio ".ssh" para guardar las llaves con `mkdir -p /home/nuevo_usuario/.ssh`
- Copiar el contenido de la llave pública del usuario en el terminal desde el que está accediendo a la máquina remota. La ubicación por defecto de la llave es "/home/usuario/.ssh/id_rsa.pub". En caso de que no se haya generado la llave anteriormente la generaremos mediante `ssh-keygen -t rsa`
- Copiamos la llave pública al archivo "/home/nuevo_usuario/.ssh/authorized_keys" a través del comando `echo "contenido" > /home/new_user/.ssh/authorized_keys`
- Añadimos a nuevo usuario a la lista de usuarios permitidos editando el archivo "/etc/ssh/sshd_config" de la instancia. esta edición la podemos ejecutar mediante `nano /etc/ssh/sshd_config`. En mi caso, con el usuario "ubuntu" creado por defecto, añado al final del archivo la línea "AllowUsers ubuntu nuevo_usuario"
- Cambiamos el propietario del directorio creado anteriormente al nuevo usuario `chown -R nuevo_usuario /home/nuevo_usuario`
- Reiniciamos el servicio ssh mediante `/sbin/service sshd restart`
- Añadimos al nuevo usuario a los grupos "admin" y "sudo" a través de `usermod -a -G admin,sudo nuevo_usuario`
- Creamos una contraseña para el nuevo usuario con `passwd nuevo_usuario`

Con esto ya nos podremos conectar a la máquina remota desde la que hemos copiado la llave mediante
```bash
ssh nuevo_usuario@loquesea.ddns.net
```

![image-01]

### Enlaces de interés
- [Oracle - Add ssh user](https://docs.oracle.com/en/cloud/cloud-at-customer/occ-get-started/add-ssh-enabled-user.html)

[Oracle Cloud]: https://cloud.oracle.com

[image-01]: /images/20221116_oracle_instance_01.jpg



