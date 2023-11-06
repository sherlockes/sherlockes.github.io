---
title: "Descarga y edición de actividades de Strava en Python"
date: "2023-11-04"
creation: "2023-11-04"
description: "Como he gestionado la descarga automatizada de las actividades de Strava y posterior edición para mostrar en un mapa mediante python."
thumbnail: "images/20231104_strava_api_gpx_python_00.jpg"
disable_comments: true
authorbox: false
toc: True
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
Ahora ya tenemos la carpeta "mientorno" creada para almacenar nuestro proyecto y activado el entorno virtual para aislarlo del sistema. El "prompt" de la terminal habrá cambiado y ahora tendremos algo como lo siguiente.

``` bash
(mientorno) user@host:~$ 
```

> Para desactivar el entorno virtual usaremos directamente el comando `deactivate`.

Antes de empezar a programar necesitamos conocer el "id de cliente" y el "secreto de cliente" de nuestra cuenta. Ambos los podemos encontrar en los ajustes del [API de Strava].

![image-01]

Con esta información crearemos un archivo ".env" en la carpeta que se ha creado para nuestro entorno virtual y cuyo contenido será el siguiente con los correspondientes parámetros de [Strava]

``` txt
CLIENT_ID=123456
CLIENT_SECRET=d4cd6r8ec6uca55dhee5ef535b776g286f074576
```

Ya estamos listos para crear nuestro archivo "strava.py" en la carpeta donde hemos incluido anteriormente el ".env" y lo empezamos a dotar de funcionalidad.

### Carga de .env
Mediante la librería [python-dotenv] vamos a posibilitar que las variables almacenadas en el archivo de texto externo se carguen como variables de entorno en el entorno virtual que hemos creado sin más que hacer una llamada a la función.

``` bash
load_dotenv()
```

### Declaración de variables
Necesitamos unas cuantas variables para las llaves de [Strava], la identificación del cliente, el código y la url de autorización que pasamos a definir a continuación.

``` bash
client_id = os.getenv('CLIENT_ID')
client_secret = os.getenv('CLIENT_SECRET')
authorization_code = None
strava_authorization_url = "https://www.strava.com/oauth/authorize?" + \
    "client_id=" + client_id + "&" + \
    "redirect_uri=http://localhost:5000/authorization&" + \
    "response_type=code&scope=read,activity:read_all"
```

### Autorización
Esta es la parte más farragosa ya que el proceso de autentificación es completamente manual siguiendo los siguientes pasos.
- Abrir en el navegador la url de autorización
- Esperar a la redirección del explorador
- Copiar de la url de redirección el código de autorización

Este proceso, aunque no es complicado, es muy latoso ya que hay que realizarlo cada vez que ejecutemos el script. Para automatizarlo un poco vamos a "matar moscas a cañonazos" haciendo una visita automática a la url de autorización y corriendo en nuestra máquina un servidor que "escuche" la redirección para captar el código de autorización.

### Abrir url


### Librerías a instalar
 - [python-dotenv] - Lectura de variables desde texto externo
 - [requests] - Hacer peticiones http

### Enlaces de interés
- [enlace](www.sherblog.pro)

[API de Strava]: https://www.strava.com/settings/api
[Linux Mint]: https://linuxmint.com
[Python]: https://www.python.org
[python-dotenv]: https://pypi.org/project/python-dotenv/
[requests]: https://pypi.org/project/requests/
[Strava]: https://www.strava.com
[virtualenv]: https://pypi.org/project/virtualenv/

[image-01]: /images/20231104_strava_api_gpx_python_01.jpg



