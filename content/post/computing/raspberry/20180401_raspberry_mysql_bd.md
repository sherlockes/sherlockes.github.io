---
title: "Raspberry mysql y DB"
date: "2018-04-04"
creation: "2018-04-04"
description: "Instalando mysql como motor debase de datos y creando una base de datos para WordPress."
thumbnail: "images/raspberry_logo.png"
disable_comments: true
authorbox: false
toc: false
mathjax: false
categories:
  - "Raspberry"
tags:
  - "desarrollo"
draft: false
weight: 14
---
### Instalando Mysql

El motor de WordPress es una base de datos por lo que es necesario un motor que la gestione, usaré MySql y se instala de la siguente forma:

<code>
sudo apt-get install mysql-server mysql-client -y
</code>
Al terminar la instalación nos pedirá una contraseña para el usuario "root".  Es muy importante que no se quede en blanco para dar seguridad a la base de datos.  Introducimos la que nos apetezca.  Además para securizar más la instalación ejecutamos el siguiente comando
<code>
sudo mysql_secure_installation
</code>
Respondiendo a las preguntas de la siguiente forma.
  * Change the root password? [Y/n] n
  * Remove anonymous users? [Y/n] y
  * Disallow root login remotely? [Y/n] y
  * Remove test database and access to it? [Y/n] y
  * Reload privilege tables now? [Y/n] y

Accedemos a la consola de MySql con el siguiente comando tras el cual se nos solicitará la contraseña correspondiente al usuario "root"

`sudo mysql -u root -p`

Ya estamos listos para crear la base de datos, el usuario que la manejará y asignación al segundo todos los privilegios sobre la primera.

```
CREATE DATABASE dbwordpress;
CREATE USER wpuser@localhost IDENTIFIED BY 'wpP455w0rd';
GRANT ALL PRIVILEGES ON dbwordpress.* TO wpuser@localhost;
FLUSH PRIVILEGES;
exit;
```
