---
title: "Añadir una red social a Hugo con el tema Mainroad"
date: "2020-02-26"
creation: "2020-02-26"
description: "Como he conseguido añadir nuevas redes sociales a mi blog creado con Hugo y el tema Mainroad."
thumbnail: "images/20200226_hugo_custom_social_00.jpg"
disable_comments: true
authorbox: false
toc: false
mathjax: false
categories:
  - "hugo"
draft: false
weight: 5
---
Por defecto, el tema [Mainroad] que utilizo para la creación de este blog tiene la capacidad de mostrar varias redes sociales del autor. Aquí muestro la forma que yo he utilizado para añadir nuevas redes al margen de las preestablecidas.
<!--more-->
El la página web de [Mainroad] viene claramente descrito como crear nuevas redes sociales personalizadas pero he sido completamente incapaz de conseguirlo por lo que he tenido que buscar un método un poco más "artesano".

#### Crear la imagen del logo
- Es necesario un archivo vectorial en formato *.svg para incluir juto al texto de la imagen. Te ahorrará mucho esfuerzo en tratar con una imagen en un solo color y lo más simple posible. En mi caso he utilizado este [logo] de [Strava] que directamente desde el editor de iconos online he podido descargar en formato *.svg

- [Mainroad] trabaja con imágenes de 24x24 píxeles por lo que el siguiente paso es redimensionar el archivo descargado. La forma más simple que he encontrado es mediante [iloveimg.com] y descargas la imagen modificada.

- A partir de aquí toca trabajar la imagen *.svg con el editor de textos. Abriremos la imagen y editaremos el texto borrando lo siguiente

![imagen_01]

1. Las letras "pt" del ancho y el alto 
2. La primera línea de declaración del xml `<?xml version="1.0" encoding="UTF-8"?>`
3. El estilo del path `style=" stroke:none;fill-rule:nonzero;fill:rgb(0%,0%,0%);fill-opacity:1;"`
	
- Añadiremos al svg una nueva clase en la primera línea `class="{{ with .class }}{{ . }} {{ end }}icon icon-strava"` y el archivo quedará como lo siguiente.

![imagen_02]

- Con la imagen *.svg modificada, la guardaremos en la carpeta /layouts/partial/svg/ en la raiz del proyecto (No dentro de la carpeta del tema)

#### Editar el "social.html"
- Copiar el archivo themes/mainroad/layouts/partials/widgets/social.html a /layouts/partials/widgets
- Editar el archivo /layouts/partials/widgets/social.html añadiendo otro bloque a continuación de los ya existentes para cada una de las redes sociales preestablecidas.

``` 
  {{- with .Site.Params.widgets.social.strava }}
		<div class="widget-social__item widget__item">
			<a class="widget-social__link widget__link btn" title="Strava" rel="noopener noreferrer" href="https://www.strava.com/athletes/{{ . }}" target="_blank">
				{{ partial "svg/strava.svg" (dict "class" "widget-social__link-icon") }}
				<span>Strava</span>
			</a>
		</div>
		{{- end }}
```

#### Configurar el "config.toml"
- Buscar el identificador de la red y añadirlo en [Params.widget.social] dentro del archivo "config.toml" de la raiz de nuestro proyecto de forma que quede algo parecido a lo siguiente.

```
[Params.widgets.social]
  # Enable parts of social widget
  twitter = "sherblogpro"
  telegram = "sherlockes"
  github = "sherlockes"
  youtube = "UCkx4Zgs1ujSuVsxcOFuGCoQ"
  strava = "11156844"
```

- Regenerar la web

[iloveimg.com]: https://www.iloveimg.com/resize-image
[logo]: https://www.iconfinder.com/editor/?id=4375352&hash=64879c7dfb1acae84ea80b286d2e9b0090c1c8a768376aca0b216d1e
[Mainroad]: https://themes.gohugo.io/mainroad/
[Strava]: https://www.strava.com/

[imagen_01]: /images/20200226_hugo_custom_social_01.jpg
[imagen_02]: /images/20200226_hugo_custom_social_02.jpg
