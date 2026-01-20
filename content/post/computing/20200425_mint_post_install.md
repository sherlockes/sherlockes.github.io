---
title: "Mi Post-instalación de Linux Mint"
date: "2026-01-20"
creation: "2020-04-25"
description: "Aquí están todos los pasos que doy después de la instalación de Linux Mint, perfectamente documentado para que no se me olvide..."
thumbnail: "images/20200425_mint_post_install_00.jpg"
disable_comments: true
authorbox: false
toc: true
mathjax: false
categories:
  - "linux"
tags:
  - "linux mint"
draft: false
weight: 5
---
Hay cientos de artículos sobre post-instalaciones de sistemas operativos. Este sólo pretendo que me sirva de guía para mi en las futuras instalaciones de linux Mint, aunque si le puede ayudar a alguien...
<!--more-->

## Vivaldi (Navegador web)
Después de la polémica creada sobre el navegador Brave, he cambiado a [Vivaldi] por la privacidad y todas las funciones que tiene. Rápido, sencillo y potente...

## Insync (Sincronizador de archivos)
Antes de nada me logeo en google ya que la mayor parte de los archivos con los que trabajo a diario están en [Google Drive]. La forma más sencilla que conozco para trabajar con estos archivos es mediante el uso de [Insync].

Es importante que las carpetas sincronizadas de Google Drive se ubiquen dentro de la ruta "/home/sherlockes/Google_Drive/" para que el resto de aplicaciones puedan acceder a los archivos de configuración

## Enlaces simbólicos y alias
Para que todo vaya funcionando, hay que crear unos enlaces simbólicos. Por un lado a la carpeta "dotfiles" que hemos sincronizado con Insync para que esta sea accesible desde la raiz del usuario. Otro para los alias que ya tengo creados.

``` bash
ln -s ~/Google_Drive/dotfiles ~/dotfiles
ln -s ~/dotfiles/bash/.bash_aliases ~/.bash_aliases
source ~/.bashrc
```

## Keeweb (Gestor de contraseñas)
Descargamos el paquete .deb desde la web de [Keeweb] y lo instalamos manualmente. Con esto ya puedo acceder a todos los nombres de usuario y contraseñas que tengo guardadas en una archivo de [Google Drive]. En las últimas versiones de Linux Mint está dando problemas esta aplicación por lo que hago uso de KeepassXC que se puede instalar directamente desde los repositorios de Linux Mint.

### Telegram Desktop (Mensajería instantanea y...)
Mis usos de Telegram los puedes ver en este post [Whatsapp Vs Telegram] y la instalación es tan simple como descargar [Telegram], descomprimir el archivo y ejecutar la aplicación desde la carpeta descomprimida (Tambien es posible instalarlo desde el "Gestor de software" de Linux Mint. Es posible fijar la aplicación a la barra de inicio o crear un lanzador en el escritorio si no eres de los de abrir las aplicaciones desde el teclado... 

### Github
Para trabajar con mis repositorios voy a necesitar conectarme por [ssh a Github] así que se debe generar una llave y copiarla en [Github]. Tambien hay que instalar git.

```

# Instalamos git
apt install git

# Generamos la llave
ssh-keygen -t ed25519 -C "your_email@example.com"

# Probamos la conexión con Github
ssh -T git@github.com
```

## Emacs (Editor de texto)
Desde el repositorio de paquetes de Linux Mint aunque no sea la última versión.
Antes de seguir adelante deberemos comprobar que están las librerías de sqlite que nos serán necesaria para org-roam. Lo haremos mediante el siguiente comando:
``` bash
sudo apt install sqlite3 libsqlite3-dev
```

El archivo de configuración de Emacs llamado ".emacs" se creará en "/home/usuario/" y tendrá el siguiente contenido.
```
(setq user-init-file "/home/sherlockes/Google_Drive/SherloScripts/emacs/.emacs")
(setq user-emacs-directory "/home/sherlockes/Google_Drive/SherloScripts/emacs/.emacs.d/")
(setq default-directory "/home/sherlockes/")
(setenv "HOME" "/home/sherlockes/")
(load user-init-file)
```

## Touchpad Indicator (Gestor táctil portatil)
Para los que somos un poco manazas es fácil que se nos vaya algún pulgar al táctil del portatil mientras escribimos, de forma que nos mueve el puntero a otro punto del documento de forma que, como agaches un momento la cabeza... ya no estás escribiendo en el punto que lo estabas haciendo.

Gracias a [Atareao] por haber creado y mantenido [Touchpad Indicator], una sencilla utilidad para linux con la que gestionar el panel táctil de los portátiles con múltiples funciones.

La instalación es tan sencilla como añadir el repositorio, actualizarlo e instalar la aplicación.
```
sudo add-apt-repository ppa:atareao/atareao
sudo apt-get update
sudo apt-get install touchpad-indicator
```

### Inkscape (Diseño vectorial)
Desde que empece a trabajar con el, apenas abro Gimp y me he acostumbrado a crear imágenes vectoriales mucho más ligeras y fáciles de redimensionar sin perder calidad.

En el momento de escribir esto, es posible instalar la versión 0.92 de [Inkscape] desde el "Gestor de Software" de Linux Mint o Instalar la versión 1 desde la web del creador en formato AppImage o FlatPak. Personalmente, no me importa renunciar a las últimas novedades en favor de la integración, tamaño y ligereza de la versión mediante repositorios.


### Rclone (Sincronizar nubes desde terminal)
Hasta ahora he escrito varios [artículos sobre Rclone] en los que explico algunos de mis usos de esta fantástica utilidad para conectar con casi cualquiera de las nubes públicas desde nuestra tarminal. Tal y como podemos comprobar en la web de [Rclone] la instalación es tan simple como una línea de terminal.
```
curl https://rclone.org/install.sh | sudo bash
```
La configuración completa de todas mis nubes la realizo copiando el archivo de respaldo "rclone.conf" al directorio "usuario/.config/rclone/rclone.conf"

### Zerotier (Virtual VPN)
La instalación es tan sencilla como `curl -s https://install.zerotier.com | sudo bash` y añadimos el cliente a la red que tengamos creada en [Zerotier] mediante el comando `sudo zerotier-cli join 78898a1265hfg34b`

{{< borrador >}}
### ImageMagick

```
sudo apt install imagemagick
```

{{< / borrador >}}

Y por ahora esto es todo lo que tengo instalado en mi ordenador, poco a poco iré actualizando este post con todas las utilidades y configuraciones que vaya necesitando.


[artículos sobre Rclone]: https://sherblog.pro/tags/rclone/
[Atareao]: https://www.atareao.es
[Vivaldi]: https://vivaldi.com
[Google Drive]: https://drive.google.com/
[Inkscape]: https://inkscape.org/es/release/
[Insync]: https://www.insynchq.com/downloads?start=true
[Keeweb]: https://keeweb.info
[Rclone]: https://rclone.org/downloads/
[ssh a Github]: https://docs.github.com/es/authentication/connecting-to-github-with-ssh
[Telegram]: https://telegram.org/dl/desktop/linux
[Touchpad Indicator]: https://www.atareao.es/aplicacion/touchpad-indicator-para-ubuntu/#
[Whatsapp Vs Telegram]: https://sherblog.pro/telegram-vs-whatsapp/
[Zerotier]: https://www.zerotier.com/download/
