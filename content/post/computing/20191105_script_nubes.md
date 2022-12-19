---
title: "Menú para montar nubes en Bash"
date: "2020-05-01"
creation: "2019-11-05"
description: "Cuando las tareas, por sencillas que sean, son repetitivas lo mejor es automatizarlas."
thumbnail: "images/20191105_script_nubes_00.jpg"
disable_comments: true
authorbox: false
toc: true
mathjax: false
categories:
  - "computing"
tags:
  - "bash"
  - "rclone"
draft: false
weight: 5
---
**Actualización: Parámetro de rclone ["allow-other"]({{<ref "#allow-other" >}}).** Ya hace un tiempo que vengo utilizando la terminal para montar las distintas nubes de las que hago uso a diario en mi terminal con [Linux Mint]. Ahora he creado un pequeño script en bash que me ahorra tiempo en esta operación y con el que he conseguido aprender abundantes conceptos en bas que a continuación paso a desgranar.
<!--more-->
Puesto que este script va a estar en una continua modificación y mejora no lo voy a dejar aquí expuesto, si quieres descargarlo tan sólo tienes que acudir a mi repositorio en Github y descargar [Sherlomenu].

## Declaración de variables
Por cada nube o carpeta remota que vaya a a montar como una unidad en mi unidad local voy a utilizar dos variables, una con la ruta donde voy a montar la unidad y otra con el comando necesario para montarla.

Por ejemplo, para el caso de [Mega.nz] utilizo estas dos variables

```
Mega_dir=~/Mega
Mega_cmd='rclone mount Sherlockes_Mega: $Mega_dir --daemon'
```

Es importante que no se esté utilizando ya la ruta a la carpeta que se ha definido, ya que el script la borrará para asegurar un correcto montaje

## Allow-other
Entre las muchas [opciones] que tiene el comando "mount" de Rclone nos encontramos con --allow-other que se utiliza en caso de que varios usuarios puedan acceder a la unidad montada. Esta opción la uso en caso de montar la biblioteca multimedia pero me muestra el siguiente error

```
mount helper error: fusermount: option allow_other only allowed if 'user_allow_other' is set in /etc/fuse.conf
Fatal error: failed to mount FUSE fs: fusermount: exit status 1
```

Esto me ha resultado un profundo dolor de cabeza durante unas horas ya que si montamos la unidad como servicio usando combinadas las opciones "Allow-other" y "Daemon" entonces la unidad no se monta pero tampoco muestra ningún error por lo que es dificil detectarlo.

```
rclone mount Sherloflix_en: $HOME/Sherloflix --allow-other --daemon
```
La solución, tal y como se muestra en el eror de arriba es bastante sencilla y basta con editar el archivo "/etc/fuse.conf" y quitar el comentario de la línea "use_allow_other" para que no sólo el usuario root tenga acceso a este parámetro de configuración.

## Comprobación de montaje
Esta es una función que se encarga de comprobar si la nube que le pasemos como argumento está o no ya montada. Tiene dos funciones

* Indicar si el script tiene que montar o desmontar la nube
* Modificar el texto del menú en función del estado actual

La función es la siguiente:

``` sh
montado (){
    local carpeta="$1_dir"
    if test -d ${!carpeta};
    then
	if mountpoint -q ${!carpeta}; then
	    return 0
	else
	    rm -rf ${!carpeta}
	    return 1
	fi
    else
	return 1
    fi
}
```

Podemos ver como en un primer momento se declara la variable local "carpeta" y se le asigna la unión del primer argumento de la función y "_dir". De esta forma, al lamar a `montado "Mega"` tendremos como valor de la variable "carpeta" a "Mega_dir" de la que a continuación haremos uso a través de las variables indirectas.

> Gracias al uso de variables indirectas es posible obtener el valor de una variable a partir de otra cuyo valor es el nombre de la primera.

El primer condicional comienza comprobando la esistencia de "carpeta" como una ruta existente mediante el comando `test`. Si la carpeta existe, comprueba si esta está montada y si es así devuelve "0", si no está montada la borra y devuelve "1". Si la carpeta no existe directamente devuelve "1"

## Mostrar el menú
Simplemente una serie de "echos" anidados que nos mostrará en unas pocas líneas las opciones de las que disponemos.

``` sh
show_menus() {
    clear
    echo "------------------------------------"	
    echo "--------  www.sherblog.pro  --------"
    echo "------------------------------------"
    montado "Sherloflix" && echo "-- 1. Sherloflix (Desmontar)      --" || echo "-- 1. Sherloflix                  --"
    montado "Mega" && echo "-- 2. Mega (Desmontar)            --" || echo "-- 2. Mega                        --"
    montado "VideoNas" && echo "-- 3. Videos en Nas (Desmontar)   --" || echo "-- 3. Videos en Ds216+ II         --"
    echo "-- 4. Backup de Google Photos     --"
    echo "-- 5. Salir                       --"
    echo "------------------------------------"
}
```
En un primer momento borra la pantalla para posteriormente escribir nuevamente el menú. En el caso de las nubes se ha usado una estructura de condicional en una sola linea para comprobar en estado de la nube y así mostrar la descripción de lo que hará el comando en caso de seleccionarlo, es decir, aparecerá "Desmontar" en caso de que la nube ya esté montada.

> Las condicionales en uns sólo línea se basan en la siguiente estructura:
> condicion && si_se_cumple || si_no_se_cumple

## Montar y desmontar las unidades
En la mayoría de los casos que hasta ahora utilizo el montaje de la unidad es tan sencillo como crear la carpeta y ejecutar un comando , la operación inversa pasa por el desmontaje de la carpeta y una posterior eliminación de la misma. Según esto, he creado una función que de forma genérica realiza estas funciones para los distintos casos en función de los argumentos que se le pasen.

``` sh
des_montar(){
    local carpeta="$1_dir"
    local comando="$1_cmd"
    
    if montado $1;
    then
        echo "Desmontando $1..."
        fusermount -u ${!carpeta}
        echo "Se va a eliminar la carpeta contenedora..."
        rm -rf ${!carpeta}
    else
        echo "Montando $1..."
        mkdir ${!carpeta}
        eval ${!comando}
    fi
}
```

El condicional comprueba si el argmento que le pasamos a la función está ya montado. Si está montado procede a desmontar la unidad y borrar la carpeta. Si no lo está, crea la carpeta y ejecuta el comando personalizado.

> Gracias al uso de variables indirectas y del comando "eval" podemos guardar dentro de una variable externa a la función un comando y ejecuarlo posteriormente

## Captando la decisión del usuario
El script deba captar lo que el usuario quiere hacer, para ello se hace uso de la variable "choice" y del comando "read" que combinados nos permiten realizar una función distinta para las distintas posibilidades.

``` sh
read_options(){
    local choice
    read -p "Selecciona una opción [ 1 - 5] " choice
    case $choice in
		1) des_montar "Sherloflix" ;;
		2) des_montar "Mega" ;;
        3) des_montar "VideoNas" ;;
        4) Google_Photos ;;      
	5) exit 0;;
	*) echo -e "...Error..." && sleep 2
    esac
}
```
Hay una opción para casa nube, una opción para salir y un error que mostrar en caso de que selecciones alguna opción distinta a las previstas.

## El bucle principal
Un simple "while true" que se ejecuta indefinidamente.

``` sh
while true
do
    sleep 2
    show_menus
    read_options
done

```

[Mega.nz]: https://mega.nz
[Linux Mint]: https://linuxmint.com/
[Sherlomenu]: https://github.com/sherlockes/SherloScripts/blob/master/sherlomenu
[opciones] : https://rclone.org/commands/rclone_mount/
