---
title: "Del Blog a Twitter y Mastodon mediante rss y Bash"
date: "2022-12-19"
creation: "2022-03-26"
description: "Como publicar los nuevos artículos del blog en Twitter mediante un script en Bash"
thumbnail: "images/20220326_bash_rss_2_twitter_00.jpg"
disable_comments: true
authorbox: false
toc: true
mathjax: false
categories:
- "computing"
tags:
- "bash"
draft: false
weight: 5
---
Una buena forma de dar algo de visibilidad a los post en el blog es publicándolos en [Twitter] y [Mastodon]. Aunque no es muy laborioso, resulta más cómodo que se realice de forma automática y aquí dejo como he creado mi propio script para hacerlo.
<!--more-->
### Lo que había utilizado
Hasta ahora he estado utilizando [IFTTT] como medio para publicar el enlace a mis post en [Twitter]. Cuando empecé con a usar este servicio era posible crear todas las "recetas" que se quisiera de forma completamente gratuita. Hace unos años lo limitaron a 3 por cuenta y ahora veo que lo han subido a 5 pero, ¿Que impide que pongan el servicio completamente de pago y haya que subirse al carro o buscar una alternativa?

![image-01]

Ahora me dispongo a sacar de [IFTTT] el servicio de publicación automática de los post del blog en [Twitter] para crear el mio propio y utilizarlo también para publicar en [Mastodon].

Básicamente, el reto pasa por dos aspectos fundamentales:
- Crear y leer el rss del Blog
- Crear el Tweet con el enlace
- Crear la publicación en Mastodon

### Preparando el script
La primera duda que me surge es si desarrollarlo en Bash o Python ya que son los dos lenguajes con los que me apaño mejor y lo que me ha hecho decantarme por Bash es que ha sido para el que encontrado una solución más rápida y sencilla en lo que se refiere a la creación del Tweet. Para los aspectos fundamentales citados anteriormente, las soluciones que voy a implementar en el script son:

- [Hugo] para la creación del rss
- [Xmllint] para la lectura del rss (Requiere también el conversor [nkf])
- [tweet.sh] para la publicación del tweet
- [Curl] para la publicación del enlace en Mastodon

Para la instalación de todo lo anterior ejecutaremos el siguiente código aunque realmente no es necesario, ya que el propio script va a ser capaz de detectar si algo no está instalado y hacerlo automáticamente.


``` bash
sudo apt update
sudo apt install curl
sudo apt install libxml2-utils
sudo apt install nkf
curl --fail --silent --show-error "https://raw.githubusercontent.com/piroor/tweet.sh/trunk/tweet.sh" --output tweet.sh
chmod +x tweet.sh
```

### Leyendo el rss
La documentación de [Hugo] sobre [rss] es un poco ambigua, lo único que es necesario tener en cuenta para el caso que nos ocupa es que por defecto se crea el archivo "www.tudominio.com/index.xml" con la información que nos servirá de rss para el blog.

> Para simplificar un poco el archivo he incluido en el archivo "config.toml" el parámetro `rssLimit = "10"` para que el"index.xml" generado se limite a 10 post.

La siguiente necesidad que se nos plantea es la extracción de información desde el archivo xml. Para esto te recomiendo que leas el artículo de Atareao que hay en los enlaces de abajo. A partir de este artículo me he creado una función para obtener a partir de un xml cualquier parámetro de cualquier objeto.

``` bash
obtener_xml() {
    SALIDA="$(xmllint --xpath "//$2[$4]/$3" $1 | sed -E "s/<$3>([^<]*)\/<\/$3>/\1/g")"
    echo "$SALIDA"
}
```
Donde
- $1 es el archivo del que vamos a extraer la info
- $2 es el objeto que estamos buscando (Ahora "items" o posts)
- $3 es la propiedad dentro del objeto (Para este caso "link")
- $4 es la posición del objeto (1º, 2º, 3º, 4º...)

Gracias a la función "xmllint" obtenemos la línea correspondiente al enlace del último artículo y mediante un "sed" y un poco de expresiones regulares las aperturas y cierre html "<link>" y "</link>.

### Publicando en Twitter
Para publicar el enlace del artículo como tweet a tu cuenta de Twitter  he usado [tweet.sh] que sólo necesita tener acceso a las llaves de publicación en [Twitter] que guardaremos en el archivo "~/.tweet.client.key" y llamar al comando post mediante.

``` bash
tweet.sh post $LINK_ACTUAL
```

> Para acceder a las claves deberás crear una [App de Twitter] y darle permiso de lectura y escritura desde el menú "User authentication settings". Importante regenerar las claves después de cambiar los permisos.


### Publicando en Mastodon
La publicación en [Mastodon] es mucho más sencilla y con un simple comando [Curl] podemos realizarla.

```Bash
curl $INSTANCIA/api/v1/statuses -H "Authorization: Bearer $TOKENM" -F "status=Lo último de mi blog $LINK_ACTUAL"
```
Además de utilizar la variable "LINK_ACTUAL" con el enlace a la última publicación del blog, esta línea de comando también hace uso de la variable "INSTANCIA" (En mi caso la tengo definida como `INSTANCIA="https://emacs.ch"`) con la ruta raíz de la instancia donde tengas creada la cuenta de [Mastodon] y de la variable "TOKENM" con la información del token de acceso.

> El Token de acceso lo crearemos desde el menú de "preferencias" y la opción "desarrollo" creando una nueva aplicación.

### Script completo
Por supuesto, hay que comprobar si el ultimo artículo publicado ha cambiado para no repetir constantemente los tweets. Como he conseguido esto y el resto de necesidades lo puedes ver en el script completo.

{{< texto_remoto "https://raw.githubusercontent.com/sherlockes/SherloScripts/master/bash/rss2twitter.sh" >}}

### Enlaces de interés
- [Atareao - Tratar xml en bash](https://atareao.es/como/xml-en-bash/)

[App de Twitter]: https://apps.twitter.com/
[Curl]: https://curl.se
[tweet.sh]: https://github.com/piroor/tweet.sh
[Developer Portal]: https://developer.twitter.com
[Hugo]: https://gohugo.io
[IFTTT]: https://ifttt.com
[Mastodon]: https://joinmastodon.org/es
[nkf]: https://github.com/dmc/nkf
[rss]: https://gohugo.io/templates/rss/
[Twitter]: https://twitter.com/sherblogpro
[Xmllint]: https://gnome.pages.gitlab.gnome.org/libxml2/xmllint.html

[image-01]: /images/20220326_bash_rss_2_twitter_01.jpg
[image-02]: /images/20220326_bash_rss_2_twitter_02.jpg
[image-03]: /images/20220326_bash_rss_2_twitter_03.jpg
[image-04]: /images/20220326_bash_rss_2_twitter_04.jpg
[image-05]: /images/20220326_bash_rss_2_twitter_05.jpg
[image-06]: /images/20220326_bash_rss_2_twitter_06.jpg
[image-07]: /images/20220326_bash_rss_2_twitter_07.jpg
[image-08]: /images/20220326_bash_rss_2_twitter_08.jpg
[image-09]: /images/20220326_bash_rss_2_twitter_09.jpg
