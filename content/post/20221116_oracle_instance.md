---
title: "Crear y configurar una instancia gratuita en Oracle"
date: "2022-11-17"
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
El proceso de la creación de la cuenta en [Oracle Cloud] puede llegar a ser desesperante por la lentitud del entorno. A la hora de crear una nueva instancia el asunto resulta bastante sencillo e intuitivo. Lo más importante a tener en cuenta es descargar las llaves ssh para poder tener acceso a la máquina remota que hemos creado.

![image-01]

> A tener en cuenta que he tenido problemas para crear la instancia desde la página internacional de [Oracle Cloud], finalmente ha sido posible desde la versión española.


### Acceder a la máquina remota
Ya tenemos creada nuestra instancia a la que se le ha asignado una ip pública xxx.xxx.xxx.xxx y también disponemos de una llave privada de acceso ssh a la misma del tipo "ssh-key-2022-11-17.key". Con esto el acceso a la máquina remota se realizara mediante:

```bash
ssh -i ssh-key-2022-11-17.key ubuntu@xxx.xxx.xxx.xxx
```

y ya estamos dentro sin necesidad de introducir ninguna contraseña.


### Asignar DNS dinámico
Acordarse o tener que consultar la ip de la instancia remota creada cada vez que nos queremos conectar a la misma no es práctico. Por esto yo uso el servicio [NoIp] que en su modo gratuito permite hasta 3 dns dinámicos. Para que la ip se actualice automáticamente a través del servicio de [Noip] cuando esta cambie es necesario instalar el cliente [DUC] en nuestra instancia remota.

Para poder seguir según las intrucciones la compilación e instalación del cliente antes deberemos instalar "make" y "gcc" en la instancia

```bash
sudo apt install make
sudo apt install gcc
```

Con esto ya podemos descargar el cliente de [Noip]
```bash
wget https://www.noip.com/client/linux/noip-duc-linux.tar.gz
```

Si seguimos el proceso de instalación obtendremos finalmente se nos preguntará en nombre se usuario y contraseña de acceso a [Noip] así como el dominio de los que tengamos creados en los que queramos actualizar la ip con la de la instancia remota.

```bash
ubuntu@oracle-sherver:/usr/local/src/noip-2.1.9-1$ sudo make install
if [ ! -d /usr/local/bin ]; then mkdir -p /usr/local/bin;fi
if [ ! -d /usr/local/etc ]; then mkdir -p /usr/local/etc;fi
cp noip2 /usr/local/bin/noip2
/usr/local/bin/noip2 -C -c /tmp/no-ip2.conf

Auto configuration for Linux client of no-ip.com.

Please enter the login/email string for no-ip.com  correo@gmail.com
Please enter the password for user 'sherlockes@gmail.com'  ********************

3 hosts are registered to this account.
Do you wish to have them all updated?[N] (y/N)  N
Do you wish to have host [dominio1.ddns.net] updated?[N] (y/N)  N
Do you wish to have host [dominio2.ddns.net] updated?[N] (y/N)  N
Do you wish to have host [dominio3.ddns.net] updated?[N] (y/N)  y
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
> Aunque no lo he probado, este proceso se podía haber simplificado si hubiera subido la llave pública de mi terminal a la instancia remota en el momento de la creación de la misma en lugar de descargar las llaves privada y pública de esta última.


### Enlaces de interés
- [Oracle - Add ssh user](https://docs.oracle.com/en/cloud/cloud-at-customer/occ-get-started/add-ssh-enabled-user.html)
- [Oracle - Conexión a una instancia](https://docs.oracle.com/es-ww/iaas/Content/Compute/Tasks/accessinginstance.htm)

[DUC]: https://my.noip.com/dynamic-dns/duc
[Noip]: https://www.noip.com
[Oracle Cloud]: https://cloud.oracle.com

[image-01]: /images/20221116_oracle_instance_01.jpg



