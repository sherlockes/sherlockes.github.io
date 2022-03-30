---
title: "Bash rss 2 twitter"
date: "2022-03-26"
creation: "2022-03-26"
description: "Bash rss 2 twitter"
thumbnail: "images/20220326_bash_rss_2_twitter_00.jpg"
disable_comments: true
authorbox: false
toc: false
mathjax: false
categories:
- "computing"
tags:
- "bash"
draft: true
weight: 5
---
Una buena forma de dar algo de visibilidad a los post en el blog es publicándolos en [Twitter]. Aunque no es muy laborioso, resulta más cómodo que se realice de forma automática y aquí dejo como he creado mi propio script para hacerlo.
<!--more-->
Hasta ahora he estado utilizando [IFTTT] como medio para publicar el enlace a mis post en [Twitter]. Cuando empecé con a usar este servicio era posible crear todas las "recetas" que se quisiera de forma completamente gratuita. Hace unos años lo limitaron a 3 por cuenta y ahora veo que lo han subido a 5 pero, ¿Que impide que pongan el servicio completamente de pago y haya que subirse al carro o buscar una alternativa?

![image-01]

Ahora me dispongo a sacar de [IFTTT] el servicio de publicación automática de los post del blog en Twitter para crear el mio propio.

Básicamente, el reto pasa por dos aspectos fundamentales:
- Crear y leer el rss del Blog
- Crear el Tweet con el enlace

La primera duda que me surge es si desarrollarlo en Bash o Python ya que son los dos lenguajes con los que me apaño mejor y lo que me ha hecho decantarme por Bash es que ha sido para el que encontrado una solución más rápida y sencilla en lo que se refiere a la creación del Tweet. Para los aspectos fundamentales citados anteriormente, las soluciones que voy a implemen tar en el script son:

- Hugo para la creación del rss
- [Xmllint] para la lectura del rss (Requiere también el conversor [nkf])
- [tweet.sh] para la publicación del tweet


Para la instalación de todo lo anterior ejecutaremos el siguiente código aunque realmente no es necesario, ya que el propio script va a ser capaz de detectar si algo no está instalado y hacerlo automáticamente.

``` bash
sudo apt update
sudo apt install libxml2-utils
sudo apt install nkf
curl --fail --silent --show-error "https://raw.githubusercontent.com/piroor/tweet.sh/trunk/tweet.sh" --output tweet.sh
chmod +x tweet.sh
```

![image-01]

### Enlaces de interés
- [Atareao - Tratar xml en bash](https://atareao.es/como/xml-en-bash/)

[tweet.sh]: https://github.com/piroor/tweet.sh
[Developer Portal]: https://developer.twitter.com
[Hugo]: https://gohugo.io
[IFTTT]: https://ifttt.com
[nkf]: https://github.com/dmc/nkf
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
