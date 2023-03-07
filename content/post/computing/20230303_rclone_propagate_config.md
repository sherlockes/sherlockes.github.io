---
title: "Configuración de Rclone mediante Dotfiles"
date: "2023-03-07"
creation: "2023-03-03"
description: "Mi solución al problema de la propagación de la configuración de Rclone mediante Dotfiles."
thumbnail: "images/20230303_rclone_propagate_config_00.jpg"
disable_comments: true
authorbox: false
toc: false
mathjax: false
categories:
- "computing"
tags:
- "bash"
- "rclone"
draft: false
weight: 5
---
[Rclone] presenta un problema si pretendemos trabajar a través de un enlace simbólico como archivo de configuración ya que al actualizarla elimina el enlace y genera un nuevo archivo "rclone.conf". De esta forma le he conseguido dar solución.
<!--more-->
Aunque es posible que el archivo de configuración de [Rclone] apunta a cualquier ubicación, para salir del valor por defecto hay que pasarlo como parámetro al comando de forma `rclone --config "$HOME/.config/ubicación/rclone.conf"` lo cual resulta un poco latoso. Por defecto se guarda el archivo de configuración en "/home/usuario/.config/rclone/rclone.conf" tal y como podemos obtener mediante el comando `rclone config file`, es posible cambiar este archivo por un enlace simbólico a la ubicación donde queramos tener el archivo de configuración.

Tal y como dejé escrito en [este]({{<relref"20210416_dotfiles.md">}}) artículo, mis archivos de configuración se guardan en una nube pública sincronizados con el nas. Al menos una vez al día, cada uno de mis equipos descarga estos archivos de configuración y los coloca en la carpeta "~/dotfiles/" de mi usuario. El siguiente paso es crear un enlace simbólico con estos archivos como destino para cada uno de los archivos de configuración que utilizo.

El comportamiento de [Rclone] es un poco particular ya que si modifico la configuración no se modifica el archivo de destino del enlace simbólico sino que se genera un nuevo archivo de configuración en la ubicación original que necesito propagar al resto de mis equipos y restituir el enlace simbólico para que surjan efecto modificaciones desde otros equipos.

Para esto utilizo el siguiente script en bash

``` bash
rclone_config(){

    # Ubicaciones de archivos de configuración local, remoto y copia de seguridad
    LOCAL_CON=$(rclone config file | tail -1)
    REMOTE_CON="Sherlockes_GD:dotfiles/rclone/rclone.conf"
    BKP_CON="Sherlockes_GD:dotfiles/rclone/rclone($(date '+%Y%m%d')bkp).conf"

    # Comprueba si el archivo de configuración es un enlace simbólico
    if [ -h $LOCAL_CON ]; then
	echo "-- La configuración no ha sido modificada."
	sleep 2
	return
    fi

    # Calcula las antigüedades de los archivos
    echo 'Calculando antigüedades de los archivos...'
    DATE_LOCAL_CON=`echo $(rclone lsl $LOCAL_CON) | cut -d ' ' -f 2,3 | xargs -i date -d {} "+%s"`
    DATE_REMOTE_CON=`echo $(rclone lsl $REMOTE_CON) | cut -d ' ' -f 2,3 | xargs -i date -d {} "+%s"`
    
    if (( $DATE_REMOTE_CON > $DATE_LOCAL_CON )); then
	echo "-- Config remota más reciente, no se va a propagar."
    else
	read -p "El archivo local es más reciente, quieres propaparlo? (si/no) " yn

	case $yn in 
	    si ) rclone_config_propagate ;;
	    * )  exit;;
	esac
    fi

    # Si existe la carpeta "Dotfiles" cambia el archivo por un enlace simbólico
    if [ -d ~/dotfiles/rclone/ ]; then
	echo "-- Actualizando Dotfiles locales..."
	cp $LOCAL_CON ~/dotfiles/rclone/rclone.conf
	echo "-- Creando el enlace con los Dotfiles"
	ln -sf ~/dotfiles/rclone/rclone.conf $LOCAL_CON
    fi
}

rclone_config_propagate(){
    echo "-- Guardando backup remoto y actualizando..."
    rclone copyto $REMOTE_CON $BKP_CON
    rclone copyto $LOCAL_CON $REMOTE_CON
}
```
Para su ejecución sigue los siguientes pasos:
- Comprueba si la ruta de configuración es un enlace simbólico, en caso de que lo sea significa que la configuración no ha sido modificada y que no necesita ser propagada al resto de archivos.
- Calcula la fecha de modificación del archivo de configuración local con el guardado en la nube para descartar el archivo más antiguo.
- En caso de que la configuración local sea más actual pregunta al usuario si desea propagar esta configuración al resto de equipos.
- Guarda una copia de la última configuración de la nube y la reemplaza por la local.
- Guarda otra copia en la carpeta de "Dotfiles" del equipo y genera un enlace simbólico del archivo de configuración de [Rclone] a la misma.


Esta función la tengo dentro de mi script de funciones para [Rclone], puedes encontrarlo junto con todos mis scripts en mi [repositorio] de [Github].

### Enlaces de interés
- [LinuxConfig - Yes/No prompt](https://linuxconfig.org/bash-script-yes-no-prompt-example)
- [LinuxDigest - Using Cut command](https://linuxdigest.com/howto/using-the-cut-command-in-bash/)
- [Rclone - Check modification time](https://rclone.org/commands/rclone_lsl/)
- [StackOverflow - Check if file is link](https://stackoverflow.com/questions/706421/check-if-file-is-a-link-on-linux)
- [StackOverflow - Convert date to string](https://stackoverflow.com/questions/15870480/how-to-convert-a-date-time-string-to-an-integer-in-bash-shell)
- [StackOverflow - Exit function in bash](https://stackoverflow.com/questions/18042279/how-to-exit-a-function-in-bash)
- [StackOverflow - Pass date through pipe](https://stackoverflow.com/questions/20560172/pass-parameter-to-date-command-through-pipe)
- [UnixStackExchange - Assign pipe to variable](https://unix.stackexchange.com/questions/338000/bash-assign-output-of-pipe-to-a-variable)

[Github]: https://github.com
[Rclone]: https://rclone.org
[repositorio]: https://github.com/sherlockes/SherloScripts

[image-01]: /images/20230303_rclone_propagate_config_01.jpg



