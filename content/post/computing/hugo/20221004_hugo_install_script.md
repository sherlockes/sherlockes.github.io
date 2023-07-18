---
title: "Script de instalación de Hugo en linux"
date: "2022-10-15"
creation: "2022-10-04"
description: "La forma automatizada que utilizo para comprobar la existencia de Hugo en un computador y si este está actualizado a la última versión"
thumbnail: "images/20221004_hugo_install_script_00.jpg"
disable_comments: true
authorbox: false
toc: false
mathjax: false
categories:
- "hugo"
tags:
- "bash"
- "regex"
draft: false
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
hugo_download_path="https://github.com/gohugoio/hugo/releases/download/"

if [[ $hugo_latest_path =~ ^$hugo_download_path[v](.*)[/].*\.tar\.gz$ ]]; then
    	hugo_latest_ver=${BASH_REMATCH[1]}
    	echo "La última versión disponible es $hugo_latest_ver"
    fi
```

Hacemos uso de la expresiones regulares en bash y el comando `BASH_REMATCH` para extraer el nº de versión como el conjunto de números y puntos detrás de "https://github.com/gohugoio/hugo/releases/download/v" y antes de la siguiente "/" en el path de la ultima versión para descargar.

“https://github.com/gohugoio/hugo/releases/download/v**0.104.3**/hugo_0.104.3_linux-arm.tar.gz"

### ¿Está Hugo ya instalado?
En caso de que [Hugo] esté instalado en el sistema comprobaremos si la versión coincide con la ultima versión disponible en la web, si son iguales no hacemos nada, en caso contrario borraremos la instalación de [Hugo] y realizaremos una nueva instalación. En caso de que [Hugo] no esté instalado directamente realizaremos la instalación de la última versión disponible.


```bash
if which hugo >/dev/null; then
	hugo_local_ver=$(hugo version | perl -pe '($_)=/([0-9]+([.][0-9]+)+)/')
	echo "Versión instalada $hugo_local_ver, última versión $hugo_latest_ver"
	
	if [ $hugo_local_ver == $hugo_web_ver ]
	then
	    echo "hugo instalado y actualizado..."
	else
	    echo 'actualizando a hugo '$hugo_latest_ver
	    
	    if [[ -f ~/.local/bin/hugo ]] 
	    then 
		rm ~/.local/bin/hugo
	    else 
		sudo dpkg -P hugo
	    fi
	    
	    hugo_install
	fi
	
    else
	echo 'Hugo no está instalado...'
	hugo_install
    fi
```

Para desinstalar [Hugo] borraremos el archivo "~/.local/bin/hugo" en caso de que este exista, en caso contrario eliminaremos el paquete mediante el comando `dpkg`.

### Instalación de Hugo
En la web viene claramente descrita la [instalación de hugo] para entornos linux a partir de una archivo "*.tar.gz", simplemente he adaptado estos pasos a mi script creando la función de instalación.

```bash
hugo_install(){
    cd ~

    echo 'Comprobando el directorio ~/.local/bin...'
    mkdir -p ~/.local/bin

    echo 'Descargando la última versión de Hugo...'
    wget -q $hugo_latest_path
    
    # Busca el archivo *.tar.gz descargado
    instalador="$(find . -maxdepth 1 -name "hugo_*.tar.gz")"

    if [[ -n $instalador ]]
    then
		echo 'Descomprimiendo el instalador...'
		# Extrae el archivo "Hugo" a "~/.local/bin"
		tar -xzf $instalador -C ~/.local/bin hugo

	# Borra el archivo descargado
		rm $instalador
    fi

    # Comprueba si la ruta esta en el PATH
    if [[ -n $(echo $PATH | grep "$HOME/.local/bin") ]]
    then
		echo "La ruta $HOME/.local/bin está en el PATH"
		else
		echo "La ruta no está en el Path, se añade"
		PATH=$PATH:~/.local/bin
    fi
}
```

Los pasos que realiza esta función son los siguientes:
- Crea el directorio "~/.local/bin/" en caso de que no exista
- Descarga la última versión disponible
- Descomprime el archivo "hugo" del instalador en "~/.local/bin"
- Borra el instalador
- Comprueba si la ruta esta en el PATH y si no lo está la añade

Y con esto ya está todo listo, puedes ver a continuación el script completo y encontrarlo otros que he escrito en mi [repositorio de GitHub].

{{< texto_remoto "https://raw.githubusercontent.com/sherlockes/SherloScripts/master/bash/hugo.sh" >}}

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
[repositorio de GitHub]: https://github.com/sherlockes/SherloScripts

[image-01]: /images/20221004_hugo_install_script_01.jpg



