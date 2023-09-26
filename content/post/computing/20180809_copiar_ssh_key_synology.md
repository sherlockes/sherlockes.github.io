---
title: "Trabajar con ssh-key en Synology"
date: "2021-04-11"
creation: "2018-08-09"
description: "Como copiar las ssh key desde un nas synology a otro equipo o aceder desde el NAS a otro equipo"
thumbnail: "images/20180809_ssh_key_synology.jpg"
disable_comments: true
authorbox: false
toc: false
mathjax: false
categories:
  - "Sherver"
tags:
  - "synology" 
draft: false
weight: 5
---
El acceso mediante llave público-privada es la forma más sencilla de acceder mediante ssh a nuestro NAS o desde este a oto equipo de forma autónoma y sin pedir contraseña, por la red hay cientos de tutoriales de como hay que hacerlo. Esta es sólo la forma que a mi me ha funcionado sin problemas.
<!--more-->

Antes de empezar, es necesario ajustar la siguiente configuración en el NAS de Synology

1. Habilitar el servicio ssh (Panel de control - Terminal y SNMP)
1. Habilitar el servicio de inicio de usuario (Panel de control - usuario - avanzado)
1. Añadir el repositorio de [SynoCommunity] (Paquetes - Configuración - Orígenes del paquete - Agregar)
1. Instalar el paquete "SynoCli File Tools" para diponer de nano y otras utilidades de consola

### Acceso desde el NAS a otro equipo
Generar la llave ssh (ssh-key) de un usuario dentro del NAS es tan sencillo como acceder al mismo a través de ssh y crear la llave.

```
ssh usuario@ip_del_nas
ssh-keygen
```
Esta llave se guardará dentro de la carpeta del usuario en el directorio ".ssh" de modo en entre otros archivos se genera un "id_rsa.pub" que es el que deberemos copiar al equipo que queremos acceder.

>Para el caso del usuario root dentro de Synology es tan sencillo como después de haber accedido via terminal con la cuenta de un administrador introducir el comando `sudo -i` con la misma contraseña del administrador.

La copia de las llaves ssh de un equipo a otro es un procedimiento que , aunque en un perfecto ingles, está documentado en la web oficial de [ssh] pero en el momento que intentamos llevarlo a cabo nos encontramos con que el comando "ssh-copy-id" no está accesible en la terminal de Synology (Al menos en DSM 6.2)

De momento no cunde el pánico pues parece sencillo instalar esta utilidad mediante el comando `sudo apt-get install ssh-copy-id` pero la cosa se complica cuando me doy cuenta de que en Synology no es posible instalar paquetes mediante apt-get o aptitude.

Tras una breve navegación por la web he encontrado una solución usando el comando "cat" utilizado para concatenar archivos y mostrarlos como salida según se muestra en el siguiente código.  Tan solo hay que introducir el nombre de usuario e ip del equipo al que queremos copiar las llaves.

```
cat ~/.ssh/id_rsa.pub | ssh <usuario>@<ip_equipo> 'cat >> .ssh/authorized_keys && echo "Llave copiada"'
```

Y ya está, ahora nuestro nas Synology deberá poder acceder al equipo remoto via ssh sin tener que introducir la contraseña.

### Acceso al NAS desde otro equipo
El acceso mediante llave público-privada es la forma más sencilla de acceder mediante ssh a nuestro NAS, por la red hay cientos de tutoriales de como hay que hacerlo. Esta es sólo la forma que a mi me ha funcionado sin problemas.

1. Acceder al NAS mediante consola "ssh usuario@ip_del_nas"
1. Editar el archivo de configuración ssh `sudo nano /etc/ssh/sshd_config`
   1. Borrar la "#" de la línea "PubkeyAuthentication"
   2. Borrar la "#" de la línea "AuthorizedKeysFile"
1. Deshabilitar y volver a habilitar el servicio ssh (Panel de control - Terminal y SNMP)
1. Desde consola de la máquina desde la que queremos acceder al nas creamos la llave ssh `ssh-keygen -t rsa`
1. Copiamos la llave al NAS `ssh-copy-id usuario@ip_del_nas`
1. Nos conectamos al NAS mediante shh y cambiamos los permisos de las siguientes carpetas
```
chmod 700 ~
chmod 700 ~/.ssh
chmod 600 ~/.ssh/authorized_keys
```


*Links de referencia*
https://www.spacerex.co/use-ssh-keys-with-synology-nas/
https://brendonmatheson.com/2020/02/23/ssh-on-synology-with-key-pairs.html
https://www.youtube.com/watch?v=XN9SuzV08Ew
https://blog.aaronlenoir.com/2018/05/06/ssh-into-synology-nas-with-ssh-key/


[ssh]: https://www.ssh.com/ssh/copy-id
[SynoCommunity]: https://synocommunity.com




