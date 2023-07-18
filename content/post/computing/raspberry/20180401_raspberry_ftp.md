---
title: "Raspberry Servidor ftp"
date: "2018-04-06"
description: "Instalando un servidor ftp a nuestra Raspberry Pi."
thumbnail: "images/20180406_raspberry_vsftpd.jpg"
disable_comments: true
authorbox: false
toc: false
mathjax: false
categories:
  - "Raspberry"
tags:
  - "desarrollo"
draft: false
weight: 15
---
### Instalando VSftpD
Aunque no es imprescindible para la instalación y funcionamiento de WordPress, el servidor ftp nos resulta muy util para la instalación automática de plugins, actualizaciones, importaciones... Por lo que lo incluimos también dentro de la pequeña Raspberry.

<code>
cd ~
sudo apt-get update
sudo apt-get install vsftpd -y
sudo nano /etc/vsftpd.conf
</code>

Instalamos "vsftp" y editamos el archivo de configuración asegurándonos de que están como aparecen a continuación los siguientes paramétros.

<code>
local_enable=YES
write_enable=YES
</code>


*** Actualización ***
//Para que los archivos subidos mediante el cliente ftp (logeado con el usuario "pi") al servidor en la raspberry puedan ser leidos y ejecutados por el usuario "www-data" deberemos modificar tambien el parámetro umask de forma que quede local_umask=022//

Guardamos los cambios y reiniciamos el servidor para que tengan efecto.

<code>
sudo service vsftpd restart
</code>
