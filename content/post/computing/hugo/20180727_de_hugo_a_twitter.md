---
title: "Insertar en Twitter enlaces a Hugo con imagen"
date: "2021-01-27"
creation: "2018-07-27"
description: "Creación de tarjetas en Twitter como enlaces a la web generada en Hugo. Dos soluciones a un problema."
thumbnail: "images/20180726_hugo_twitter_card_00.jpg"
disable_comments: true
authorbox: false
toc: false
mathjax: false
categories:
  - "hugo"
  - "sherver"
draft: false
weight: 5
---
**Actualización:** Hace un tiempo ya me encontré con este mismo problema, ahora me ocurre que, tras actualizar el tema ([Mainroad]) en la web desarrollada en [Hugo] no aparece la imagen de la tarjeta que [Twitter] genera al enlazar un post de la web en un Tweet.

<!--more-->

### El problema
Ya tenemos nuestra web en [Hugo] y resulta que cuando queremos compartir un enlace al mismo en [Twitter] este aparece como un miserable hipervínculo, ni imagen, ni resumen, ni título, ni na¡¡¡.  No se si el problema es común para todos los temas u ocurre simplemente con el que yo he utilizado.

No tardo mucho en encontrar información para darme cuenta de que todo pasa por el uso de metadatos por parte de [Twitter] para generar las tarjetas (Cards) tal y como se comenta en su sección de [desarrolladores][2] donde puedes invertir varias horas para documentarte o seguir leyendo durante unos minutos para solucionar tu problema.

Es decir, [Twitter] necesita unos metadatos que [Hugo] no está enviando.

### La solución (Plan A)
Con la actualización del tema [Mainroad] que uso en la web ha aparecido una nueva forma de generar las tarjetas de [Twitter] gracias a las [Internal Templates] de [Hugo]. Esto se gernera gracias a una línea en el archivo "layouts/partials/default/baseof.html"

```
{{ if .Site.Params.twitter_cards }}{{ template "_internal/twitter_cards.html" . }}{{ end }}
```
Con esto ya queda generada la tarjeta pero me he encontrado con que no se incluye la imagen que tengo registrada como cabecera del post (thumbnail) para lo cual me veo obligado a incluir un nuevo campo de parámetros con la imagen a mostrar.

```
images: ["portada_del_post.jpg"]
```

Esto presenta dos problemas:
- Hay que incluir una nueva línea en el archivo *.md de todos los post con la imagen de portada
- No funciona la ruta relativa a la imagen y me veo obligado a incluir la ruta completa

El segundo problema me ha sido fácil de arreglar sin más que poner en en parámetro "baseurl" del archivo de configuración de la web (config.toml) la ruta y el nombre del host (http://www.sherblog.pro/).

El primer problema no he sido capaz de salvarlo por lo que voy a buscar una solución mas limpia que no me obligue a modificar todos los artículos con la inclusión de un nuevo parámetro.


### La otra solución (Plan B)

En todos los encabezados de los artículos tengo, entre otros, insertados los siguiente campos

```
title: "Enlaces con imagen en Twitter a Hugo"
description: "Te interesa leer si los links que compartes o comparten en Twitter de tu web en Hugo Salen sin imagen"
thumbnail: "images/20180712_wordpress_hugo.jpg"
```

Pues bien, el reto pasa por aprovechar estos campos para generar los metadatos que [Twitter] está buscando para generar su tarjeta de enlace.  Hay varias opciones, pero la más práctica que he encontrado es hacer una copia del archivo "baseof.html" dentro de la carpeta "layouts/_default/" para que quede duplicado fuera de la carpeta del tema e incluir en el "head" a continuación de los metas de [Hugo] estas líneas:

```
<meta name="twitter:card" content="summary_large_image"/>
{{ if (.Params.thumbnail) }}<meta name="twitter:image" content="http://www.sherblog.pro{{ .Params.thumbnail }}" />{{else}}<meta name="twitter:image" content="http://www.sherblog.pro/images/logo.png" />{{end}}
<meta name="twitter:title" content="{{ .Params.title }}"/>
<meta name="twitter:description" content="{{ .Params.description }}"/>
<meta name="twitter:creator" content="@sherblogpro">
<meta name="twitter:site" content="sherblog.pro" />
```

Bastante sencillo ya que cada metadato corresponde a un parámetro de nuestro archivo con una particularidad para el caso de las imágenes y es que hace distinción para el caso en que no encuentre el parámetro "thumbnail" que utilice en su lugar una imagen fija.

### Comprobando la solución

Podrías dedicarte a enviar y borrar tweets para comprobar que funciona la solución que hemos adoptado pero [Twitter] nos proporciona una herramienta más sencilla mediante su [validador de tarjetas][4].

![CardsGen][5]

Esta es una web en la que pegas el enlace que quieres comprobar y te muestra la tarjeta generada y los posibles problemas que encuentra en su generación.  Tras las modificaciones en el "baseof.html" la tarjeta generada aparece así.

![CardsGen][6]

[Twitter]: https://twitter.com
[2]: https://developer.twitter.com/en/docs/tweets/optimize-with-cards/guides/getting-started.html
[Hugo]: https://gohugo.io/
[Internal Templates]: https://gohugo.io/templates/internal/#twitter-cards
[Mainroad]: https://themes.gohugo.io/mainroad/
[4]: https://cards-dev.twitter.com/validator
[5]: /images/20180726_hugo_twitter_card_01.jpg
[6]: /images/20180726_hugo_twitter_card_02.jpg
