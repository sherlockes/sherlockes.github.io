---
title: "Raspberry Descargando Wordpress"
date: "2018-04-05"
description: "Descargando la última versión de WordPress a nuestra Raspberry Pi."
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
weight: 15
---
### Descargando WordPress

En primer lugar descargamos la ultima versión de WordPress a el directorio "home" del usuario Pi.  Si la descargamos en inglés lo haremos mediante el archivo "latest.tar.gz" pero si la queremos en castellano habrá en entrar en [[http://es.wordpress.org]] y comprobar cual es la versión actual para descargar un archivo del tipo "wordpress-4.8.2-es_ES.tar.gz"

<code>
sudo mkdir /var/www/html/sherblog/
cd ~
wget http://wordpress.org/latest.tar.gz
tar -xzvf latest.tar.gz
sudo mv wordpress/* /var/www/html/sherblog
sudo rm latest.tar.gz
sudo rm -rf wordpress
</code>

Las líneas de arriba realizan la siguiente secuencia:
  * Crea un directorio en la raiz de apache para instalar WordPress
  * Iniciarse en el directorio "home" de Pi
  * Descargar la última versión de WordPress (En inglés)
  * Descomprime el archivo descargado
  * Mueve el contenido de la carpeta extraida a "/var/www/html/sherblog"
  * Borra el archivo descargado
  * Borra la carpeta vacía

Con esto ya están listos los archivos de WordPress, ahora modificaremos el archivo "wp-config" con la información de la conexión a la base de datos que hemos creado anteriormente.

<code>
cd /var/www/html/sherblog
sudo cp wp-config-sample.php wp-config.php
sudo nano wp-config.php
</code>

define('DB_NAME', 'dbwordpress');\\
define('DB_USER', 'wpuser');\\
define('DB_PASSWORD', 'wpP455w0rd');\\

<code>
sudo chown -R pi:pi /var/www/html/sherblog
sudo mkdir /var/www/html/sherblog/wp-content/uploads
sudo chown -R www-data:www-data /var/www/html/sherblog/wp-content/uploads
sudo nano /etc/apache2/sites-available/000-default.conf
sudo service apache2 restart
sudo touch /var/www/html/sherblog/.htaccess
sudo chown www-data:www-data /var/www/html/sherblog/.htaccess
sudo find /var/www/html/ -type d -exec chmod 755 {} \;
sudo find /var/www/html/ -type f -exec chmod 644 {} \;
sudo restart
</code>

  * Cambiamos a Pi como propietario de la carpeta "sherblog"
  * Creamos la carpeta "uploads"
  * Cambiamos a apache2 como propietario de la carpeta "uploads"
  * Editamos el archivo "virtual host" de apache2 y añadimos "AllowOverride All" para la carpeta /var/www/html/sherblog, añdimos el siguiente párafo y guardamos los cambios.

<code>
<Directory /var/www/html/sherblog>
    AllowOverride All
</Directory>
</code>

* Reiniciamos Apache
* Creamos el archivo .htaccess
* Cambiamos el propietario del archivo a apache2
* Cambiamos los premisos para los directorio y archivos de WordPress
* Reiniciamos la Raspberry y el servidor web ya está listo.


** Actualización **
> Para poder gestionar a través del FTP me he visto obligado a Poner las carpetas con permisos 775 y a los archivos 664 ya que el usuario con con el que me conecto no es el propietario de las carpetas y archivos aunque si pertenece al mismo grupo.
