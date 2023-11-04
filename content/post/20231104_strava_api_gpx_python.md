---
title: "Descarga y edición de actividades de Strava en Python"
date: "2023-11-04"
creation: "2023-11-04"
description: "Como he gestionado la descarga automatizada de las actividades de Strava y posterior edición para mostrar en un mapa mediante python."
thumbnail: "images/20231104_strava_api_gpx_python_00.jpg"
disable_comments: true
authorbox: false
toc: false
mathjax: false
categories:
- "computing"
tags:
- "strava"
- "python"
draft: true
weight: 5
---
Descargar las actividades anuales de [Strava] para la creación de un mapa con mis rutas de forma automatizada es un proyecto detrás del cual llevaba mucho tiempo. Al fin lo he afrontado.
<!--more-->
Voy a intentar contarlo poco a poco para que cualquiera lo pueda seguir con sólo tener unos conocimientos muy básicos de [Python] como son los míos. Será necesario tener en cuanta que las indicaciones que aquí quedan son para un trabajo sobre [Linux Mint] y Python3, cualquier otro sistema requerirá una adaptación.

### Preparación previa
Es probable que el repositorio de paquetes [Pip] ya lo tengas instalado en tu sistema linux, también será necesaria la herramienta de creación de entornos virtuales [virtualenv]. Ambas herramientas las instalaremos desde la consola con los siguientes comandos.

``` bash
sudo apt update
sudo apt install python3-pip
pip install virtualenv
```

> El uso de entornos virtuales nos permite crear un sistema aislado donde instalar las librerías de no interfieran con las propias del sistema operativo y se puedan eliminar de una forma sencilla al terminar o descartar el proyecto.

El siguiente paso es la creación y activación del entorno virtual para lo que, desde la terminal nos situaremos en la carpeta donde queremos nuestro proyecto y ejecutaremos los siguientes comandos:

``` bash
virtualenv mientorno
source mientorno/bin/activate
```
Ahora ya tenemos la carpeta "mientorno" creada para almacenar nuestro proyecto y activado el entorno virtual para aislarlo del sistema. El prompt de la terminal habrá cambiado y ahora tendremos algo como lo siguiente.

``` bash
(mientorno) user@host:~$ 
```

> Para desactivar el entorno virtual usaremos directamente el comando `deactivate`.
![image-01]

### Enlaces de interés
- [enlace](www.sherblog.pro)

[Linux Mint]: https://linuxmint.com
[Python]: https://www.python.org
[Strava]: https://www.strava.com
[virtualenv]: https://pypi.org/project/virtualenv/

[image-01]: /images/20231104_strava_api_gpx_python_01.jpg



