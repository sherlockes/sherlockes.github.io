---
title: "Crear y configurar una instancia gratuita en Oracle"
date: "2023-10-25"
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
draft: false
weight: 5
---
Tener un pequeño servidor privado virtual a modo de laboratorio en el que hacer nuestras pruebas es gratis gracias a [Oracle Cloud], aquí dejo la forma de conseguirlo y las pruebas que con el he realizado.

Actualización: Simular que trabaja
<!--more-->
El proceso de la creación de la cuenta en [Oracle Cloud] puede llegar a ser desesperante por la lentitud del entorno. A la hora de crear una nueva instancia el asunto resulta bastante sencillo e intuitivo. Lo más importante a tener en cuenta es descargar las llaves ssh para poder tener acceso a la máquina remota que hemos creado o bien subir a la instancia creada la llave pública de nuestro equipo.

![image-01]

> A tener en cuenta que he tenido problemas para crear la instancia desde la página internacional de [Oracle Cloud], finalmente ha sido posible desde la versión española.


### Acceder a la máquina remota
Ya tenemos creada nuestra instancia a la que se le ha asignado una ip pública xxx.xxx.xxx.xxx y también disponemos de una llave privada de acceso ssh a la misma del tipo "ssh-key-2022-11-17.key". Con esto el acceso a la máquina remota se realizara mediante:

```bash
ssh -i ssh-key-2022-11-17.key ubuntu@xxx.xxx.xxx.xxx
```

>Antes de poder usar la llave hay que cambiarle los permisos al archivo mediante el comando `chmod 400 ssh-key-2022-11-17.key` tal y como se explica en la [instrucciones de conexión](https://docs.oracle.com/en-us/iaas/Content/Compute/Tasks/accessinginstance.htm).

y ya estamos dentro sin necesidad de introducir ninguna contraseña.

En caso de que hayamos optado por subir la llave pública de nuestro equipo en lugar de descargas las llaves de la instancia el acceso a la misma será mucho más sencillo mediante:

```bash
ssh ubuntu@xxx.xxx.xxx.xxx
```

### Asignar DNS dinámico
Acordarse o tener que consultar la ip de la instancia remota creada cada vez que nos queremos conectar a la misma no es práctico. Por esto yo uso el servicio [NoIp] que en su modo gratuito permite hasta 3 dns dinámicos. Para que la ip se actualice automáticamente a través del servicio de [Noip] cuando esta cambie es necesario instalar el cliente [DUC] en nuestra instancia remota.

Para poder seguir según las instrucciones la compilación e instalación del cliente antes deberemos instalar "make" y "gcc" en la instancia

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

>El proceso de instalación detallado lo puedes encontrar [aquí](https://www.noip.com/support/knowledgebase/installing-the-linux-dynamic-update-client/).

### Añadir un usuario

- Acceder a la máquina remota mediante `ssh -i ssh_pub.key ubuntu@loquesea.ddns.net` donde "ssh_pub.key" es el archivo correspondiente a la llave pública que se genera al crear la instancia.
- Cambiar al usuario "root" con el comando `sudo su`
- Crear el nuevo usuario (Con el mismo nombre que tenemos en la terminal desde la que estamos accediendo a la máquina remota) con `useradd nuevo_usuario`
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

### Prompt color y teclas en la consola de comandos
Al logearme en la instancia mediante ssh me encuentro con que no aparece ningún tipo de color, para el usuario no se muestra este y el nombre de la máquina en el prompt de la terminal sino que sólo aparece lo siguiente:

```bash
$ 
```
Tampoco funcionan las flechas de desplazamiento de cursor y de comando anterior/posterior.

La solución que he encontrado pasa por ejecutar el comando `/bin/bash` y editar el archivo "/etc/passwd" para comprobar que en la fila correspondiente al usuario creado aparece algo como lo siguiente

```bash
nombre_usuario:x:1002:1002:Nombre Usuario:/home/nombre_usuario:/bin/bash
```

El tema de los colores la solución también es sencilla y pasa por copiar el archivo de configuración de bash por defecto a la carpeta del usuario y quitar el comentario de la línea "force_color_prompt=yes" para ello ejecutamos los siguientes comandos:

```bash
cp /etc/skel/.bashrc ~/.bashrc
nano ~/.bashrc
### Quitamos el comentario
. ~/.bashrc
```

### Crear un servidor webdav mediante rclone
Tal y como utilicé en un [post]({{<relref"20220317_bash_python_download_twitch.md">}}) anterior, crear un servidor webdav a partir del contenido de una nube pública es cuestión de añadir al cron la ejecución del script de lanzamiento del servidor webdav de forma que así queda el cron

```bash
@reboot /home/sherlockes/webdav.sh > /home/sherlockes/webdav.log 2>&1
```

Y este es el script de lanzamiento del servidor webdav mediante [rclone] donde:
 - "nube_publica" es el nombre que hemos asignado a la unidad de [rclone]
 - "10.0.0.173" es la IP privada de la instancia de oracle creada
 - "5005" es el puerto sobre el que se va a mostrar el contenido
 - "usuario" es el nombre de usuario con el que accederemos al servidor
 - "contraseña" es la contraseña de acceso
 

```bash
#!/bin/bash

###################################################################
#Script Name: webdav.sh
#Description: Monta un servidor webdav con rclone
#Args: N/A
#Creation/Update: 20211217/20211217
#Author: www.sherblog.pro
#Email: sherlockes@gmail.com
###################################################################

sleep 30
rclone serve webdav nube_publica: --addr 10.0.0.173:5005 --read-only --user usuario --pass contraseña

```

> Tener en cuenta que se esperan 30 segundos antes de lanzar el comando del servidor para asegurar que la infraestructura de red está montada.

### Simular que trabaja

A los señores de Oracle no les gusta que la instancia esté sin hacer nada y te informa que de seguir así será parada. Todo esto en un perfecto inglés.

> Oracle Cloud Infrastructure (OCI) will be reclaiming idle Always Free compute resources from Always Free customers only. Reclaiming idle resources allows OCI to efficiently provide services to Always Free customers. Your account has been identified as having one or more compute instances that have been idle for the past 7 days. These idle instances will be stopped 7 days from now. If your idle Always Free compute instance is stopped, you can restart it as long as the associated compute shape is available in your region.

De momento no tengo claro el objetivo de producción de la instancia y supongo que si la paro voy a tener problemas para volverla a arrancar así que vamos a darle un poco de trabajo mediante la aplicación "NeverIdle"

``` bash
wget https://github.com/layou233/NeverIdle/releases/download/0.1/NeverIdle-linux-arm64 -O NeverIdle
chmod 777 NeverIdle
```

> Hay que tener en cuenta que en caso de servidores AMD el archivo es distinto y habrá que acudir a GitHub para descargarlo.

Ahora mediante el comando `crontab -e` editaremos el cron de usuario y añadimos la siguiente línea

``` bash
@reboot /home/sherlockes/NeverIdle -c 2h1m2s -m 2 -n 4h 
```

De esta forma cada vez que reinicie la instancia se ejecutará la aplicación "NeverIdle" y para forzar un reinicio diario ejecutamos `sudo crontab -e` y añadimos la siguiente línea para que la instancia se reinicie todos los días a las 4 de la mañana.

``` bash
0 4 * * * /sbin/reboot
```

A ver si con esto conseguimos que oracle no apague la instancia.


### Enlaces de interés
- [Ask Ubuntu - Keys not working in terminal](https://askubuntu.com/questions/163802/backspace-tab-del-and-arrow-keys-not-working-in-terminal-using-ssh)
- [Ask Ubuntu - Terminal colors not working](https://askubuntu.com/questions/39731/terminal-colors-not-working)
- [Blog 51 - Oracle idle compute](https://blog.51sec.org/2023/02/oracle-cloud-cleaning-up-idle-compute.html?expand_article=1)
- [Oracle - Add ssh user](https://docs.oracle.com/en/cloud/cloud-at-customer/occ-get-started/add-ssh-enabled-user.html)
- [Oracle - Conexión a una instancia](https://docs.oracle.com/es-ww/iaas/Content/Compute/Tasks/accessinginstance.htm)


[DUC]: https://my.noip.com/dynamic-dns/duc
[Noip]: https://www.noip.com
[Oracle Cloud]: https://cloud.oracle.com
[rclone]: https://rclone.org

[image-01]: /images/20221116_oracle_instance_01.jpg



