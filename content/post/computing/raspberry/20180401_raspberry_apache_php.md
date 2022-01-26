---
title: "Raspberry apache y php"
date: "2018-04-03"
description: "Instalando en la Raspberry los servicios Apache y Php"
thumbnail: "images/raspberry_logo.png"
disable_comments: true
authorbox: false
toc: false
mathjax: false
categories:
  - "Raspberry"
tags:
  - "Desarrollo"
draft: false
weight: 13
---
### Instalando PhP y Apache

```
sudo apt-get install php7.0 libapache2-mod-php7.0 php7.0-mysql -y
```

Para comprobar la correcta instalación de php borraremos el archivo "index.html", crearemos un archivo "index.php" en el que escribiremos un mensaje "hola mundo" y reiniciaremos el servidor.

```
cd /var/www/html
sudo rm index.html
sudo nano index.php

   <?php echo "hola mundo"; ?>
   Pulsar control-x
   Pulsar y
   Pulsar intro

sudo service apache2 restart
```

Ahora al acceder desde el navegador a la ip de nuestra raspberry se debería mostrar el mensaje "hola mundo".  Antes de seguir adelante, modificaremos el archivo de configuración de php para que nos permita subir al servidor archivos de hasta 8Mb.

```
sudo nano /etc/php/7.0/apache2/php.ini
```

Buscamos el tamaño máximo de subida de los archivos

```
Pulsamos control-w
upload_max_filesize
Cambiamos 2M por algo más adecuado

upload_max_filesize = 8M
```

Guardamos los cambios, salimos de nano y reiniciamos de nuevo apache

```
sudo service apache2 restart
```
