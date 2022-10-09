---
title: "Script de instalación de Hugo en linux"
date: "2022-10-04"
creation: "2022-10-04"
description: "La forma automatizada que utilizo para comprobar la existencia de Hugo en un computador y si este está actualizado a la última versión"
thumbnail: "images/20221004_hugo_install_script_00.jpg"
disable_comments: true
authorbox: false
toc: false
mathjax: false
categories:
- "computing"
tags:
- "bash"
- "hugo"
draft: true
weight: 5
---
Cierto es que la [instalación de Hugo] no lleva más allá de unos pocos minutos, pero es gratificante no tener que gastar este tiempo cada vez que se actualiza a una nueva versión. Este script es la forma con la que consigo ahorrar este valioso tiempo en mis terminales con linux a partir de la fuente.
<!--more-->

### Arquitectura del equipo
El primer problema con el que nos encontramos es determinar el tipo de arquitectura que tiene el equipo sobre el que vamos a instalar [Hugo]. En mi caso tengo que diferenciar entre la [Raspberry] con arquitectura arm de 32bit (Raspbian) y los equipos de sobremesa y portátil, ambos con arquitectura x86 de 64bit (Linux Mint). Para determinar la longitud de bit con la que trabaja el equipo uso el comando `getconf LONG_BIT` con este sencillo script:

```bash
bits=$(getconf LONG_BIT)
if [ $bits == '64' ]
then
    bits='64bit'
else
    bits='arm'
fi
```
> En caso de tratar con mayor variedad de equipos seguramente fuera más adecuado usar el comando `uname -m` para determinar la arquitectura de los mismos.

### Ruta de descarga
Conociendo la arquitectura del equipo, descargar el instalador adecuado desde la página en [Github de Hugo] no tiene ninguna complicación si lo realizamos manualmente. Para automatizar la tarea creo la variable "hugo_latest_path" que contendrá la ruta completa al ultimo instalador disponible gracias al acceso a la api de [Github].

```bash
hugo_latest_path=$(curl -s https://api.github.com/repos/gohugoio/hugo/releases/latest \
	| grep "browser_download_url" \
	| grep "[Ll]inux" \
	| grep "${bits}" \
	| grep -v "hugo_extended" \
	| grep -v "arm64" \
	| grep "\.tar\.gz" \
	| cut -d ":" -f 2,3 \
	| tr -d \")
```
Este comando realiza los siguientes pasos:
- Descarga de la página con las ultimas versiones de [Hugo]
- Filtra por las líneas que contienen "Browser_download_url"
- Filtra por la líneas que contienen "Linux" o "linux"
- Filtra por el tiempo de architectura (64bit o arm)
- Desprecia las líneas con la versión extendida de [Hugo]
- Desprecia las líneas para "arm64"
- Se queda sólo con los instaladores ".tar.gz"
- Se queda con el contenido del campo y no el encabezado
- Elimina las comillas

El resultado del comando completo será una ruta de descarga para la última versión de [Hugo]
"https://github.com/gohugoio/hugo/releases/download/v0.104.3/hugo_0.104.3_linux-arm.tar.gz"


### Determinar la ultima versión disponible
A partir de la variable "hugo_latest_path" generaremos la variable "hugo_latest_ver"

```bash
if [[ $hugo_latest_path =~ ^$hugo_download_path[v](.*)[/].*\.tar\.gz$ ]]; then
    	hugo_latest_ver=${BASH_REMATCH[1]}
    	echo "La última versión disponible es $hugo_latest_ver"
    fi
```
{{< texto_remoto "https://raw.githubusercontent.com/sherlockes/SherloScripts/master/bash/hugo.sh" >}}

![image-01]

### Enlaces de interés
- [Fabian Lee - Capture groups from regex](https://fabianlee.org/2020/01/29/bash-using-bash_rematch-to-pull-capture-groups-from-a-regex/)
- [How to Geek - Check if file exists](https://www.howtogeek.com/815684/bash-check-if-file-exists/)
- [Linuxxize - Regex in grep](https://linuxize.com/post/regular-expressions-in-grep/)
- [Stackoverflow - Turn off tar output](https://stackoverflow.com/questions/13341702/how-do-i-turn-off-the-output-from-tar-commands-on-unix)
- [StackOverFlow - Grep regex without string](https://stackoverflow.com/questions/10411616/grep-regex-not-containing-a-string)


[instalación de Hugo]: https://gohugo.io/getting-started/installing/#source
[Github]: https://github.com
[Github de Hugo]: https://github.com/gohugoio/hugo/releases
[Hugo]: https://gohugo.io
[Raspberry]: https://www.raspberrypi.org

[image-01]: /images/20221004_hugo_install_script_01.jpg



