---
title: "Migrando a Hugo en la Raspberry"
date: "2018-11-07"
creation: "2018-06-27"
description: "Si te encuentras con que los enlaces"
thumbnail: "images/hugo_logo.jpg"
disable_comments: true
authorbox: false
toc: false
mathjax: false
categories:
  - "Hugo"
  - "Raspberry"
draft: false
weight: 5
---
Ya hace unos días que le he cogido la medida al uso de Hugo como plataforma de1 creación de contenido para mi web y ahora, con cierta perspectiva voy a intentar explicar los tres conceptos fundamentales sobre Hugo a modo de introducción, que es, que hace y como funciona.

### Que es Hugo?
Atendiendo a la prensa definición que podemos encontrar en su web oficial, Hugo es un entorno de desarrollo para la creación de páginas web estáticas, sin base de datos ni php.

La misión de Hugo es realmente sencilla, a partir de unos archivos escritos en Markdown (uno para cada entrada o post de la web) , de una carpeta con las imágenes y archivos para documentar las correspondientes entradas y de un archivo de configuración, el entorno de desarrollo genera una carpeta de salida con los archivos que deberemos colocar en un servidor web para crear nuestra página web.

A priori es un concepto realmente sencillo.  En un primer momento creas una web en un directorio para el que tengas todos los permisos, añades contenido mediante archivos de texto plano cada uno con su correspondiente encabezado y para terminar generas la web resultante.

El concepto de tan sencillo que es se hace difícil de entender. No hay que pensar en Hugo como si fuera una aplicación dentro de la cual vamos a generar una web sino como un comando de sistema que lo podemos ejecutar en cualquier carpeta.

### Instalando Hugo
Empezamos desde cero con la Raspberry para configurar Hugo.  Hay poco documentación para el uso de Hugo sobre Raspberry por lo que me parece que esta va a ser una aventura "divertida".

Parto de una Raspberry Pi 3 model B con únicamente [Raspbian Stretch lite][11] instalado y la ip configurada a modo estático con la dirección 192.168.1.203.  Obviamente necesitamos además otro terminal desde el que conectarnos a la Raspberry para realizar la configuración necesaria y en el que visualizar los resultados obtenidos.  en mi caso utilizo un viejo portatil con Linux Mint y Firefox como navegador.

 * Instalar el control de versiones git si no está instalado previamente
 * Descargar la ultima versión de hugo para arm desde [GitHub][12]
 * Instalar mediante "dpkg" el archivo instalado

```
sudo apt-get update
sudo apt-get install git
wget “https://github.com/gohugoio/hugo/releases/download/v0.49/hugo_0.49_Linux-ARM.deb”
sudo dpkg -i hugo_0.49_Linux-ARM.deb
```

> En la web que muestra la instalación de [Hugo][13] nos muestra como métodos de referencia el uso de paquetería snap o el clásico "apt-get install hugo".  No tengo claro si existe un paquete snap de hugo para Raspberry Pi y la versión que instala Apt-get es muy antigua.  Por esto opto por instalar directamente el archivo .deb descargado.

Para actualizar hugo, antes de descargar e instalar la nueva versión deberemos desisntalar el paquete existente mediante el comando:

```
dpkg -r hugo
```
He adaptado un pequeño script de [aquí][16] para una actualzación automática de hugo que desinstala la existente y vuelve a instalar la versión más reciente.
```
sudo dpkg -P hugo
curl -s https://api.github.com/repos/gohugoio/hugo/releases/latest \
| grep "browser_download_url.*hugo_[^extended].*_Linux-ARM\.deb" \
| cut -d ":" -f 2,3 \
| tr -d \" \
| wget -qi -
installer="$(find . -name "*Linux-ARM.deb")"
sudo dpkg -i $installer
rm $installer
```

### Creando la web
#### Creación de la raiz
Empezaremos creando un nuevo site para nuestra web en la carpeta home/pi
```
hugo new site sherblog_dev
cd sherblog_dev
```
#### Instalando un tema
Sería un poco presuntuosos empezar a crear un tema para la web desde cero por lo que de momento instalaremos uno ya existente de los que podemos encontrar en el [repositorio][14] oficial.  Yo estoy usando el tema [Mainroad][15] para mi blog y para instalarlo ejecutaremos el siguiente comando desde la carpeta "themes"

```
git clone https://github.com/vimux/mainroad
```

Ahora que tenemos el tema descargado, para activarlo hay que introducir en el archivo "config.toml" ubicado en la raiz de la web la siguiente línea

```
theme = "mainroad"
```

De esta forma el archivo "config.toml" quedará algo parecido a lo siguiente

```
baseURL = "http://example.org/"
languageCode = "en-us"
title = "My New Hugo Site"
theme = "mainroad"
```

Con esto podríamos empezar a funcionar pero para aprovechar todo el potencial del tema vamos a sobreescribir el archivo "config.toml" con el específico del tema ubicado en "\themes\mainroad\exampleSite\config.toml" de modo que quedará así:

```
baseurl = "/"
title = "Mainroad"
languageCode = "en-us"
paginate = "10" # Number of posts per page
theme = "mainroad"
disqusShortname = "" # Enable comments by entering your Disqus shortname
googleAnalytics = "" # Enable Google Analytics by entering your tracking id

[Author]
  name = "John Doe"
  bio = "John Doe's true identity is unknown. Maybe he is a successful blogger or writer. Nobody knows it."
  avatar = "img/avatar.png"

[Params]
  subtitle = "Just another site" # Subtitle of your site
  description = "John Doe's Personal blog about everything" # Description of your site
  opengraph = true
  twitter_cards = false
  readmore = false # Show "Read more" button in list if true
  authorbox = true
  post_navigation = true
  postSections = ["post"]

[Params.sidebar]
  home = "right"   # Configure layout for home page
  list = "right"   # Configure layout for list pages
  single = "right" # Configure layout for single pages
  # Enable widgets in given order
  widgets = ["search", "recent", "categories", "taglist"]

[Params.widgets]
  recent_num = 5 # Set the number of articles in the "Recent articles" widget
  tags_counter = false # Enable counter for each tag in "Tags" widget (disabled by default)
```

### Viendo los resultados - Hugo Server
Hugo cuenta con un servidor integrado que nos permite ver los resultados de la compilación de la web de una forma rápida en tiempo real y con auto-refresco del navegador para lo cual ejecutaremos el siguiente comando desde el directorio raiz de la web
```
hugo server -D -b "http://www.sherblog.pro" --bind "0.0.0.0" --disableFastRender
```
* -D - incluye los borradores
* -b "http://www.sherblog.pro" - Define la ruta raiz (Prescindible)
* --bind "0.0.0.0" - Impresindible para que el servidor ubicado en la Raspberry escuche al equipo desde el que accedemos
* --disableFastRender - Obliga a una renderización completa de la web con cada modificación

Acceder desde el navegador a http://192.168.1.203:1313/


[11]: https://downloads.raspberrypi.org/raspbian_lite_latest
[12]: https://github.com/gohugoio/hugo/releases
[13]: https://gohugo.io/getting-started/installing
[14]: https://themes.gohugo.io/
[15]: https://themes.gohugo.io/mainroad/
[16]: https://gist.github.com/steinwaywhw/a4cd19cda655b8249d908261a62687f8
