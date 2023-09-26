---
title: "Sobreescribir el css de un tema en Hugo"
date: "2018-09-17"
description: "La batalla por corregir una fuga de agua en una cisterna Roca de doble pulsador."
thumbnail: "images/20180917_hugo_sobreescribir_css_00.jpg"
disable_comments: true
authorbox: false
toc: false
mathjax: false
categories:
  - "hugo"
tags:
  - "css"
draft: true
weight: 5
---
Uno de los problemas con los que me he encontrado recientemente en la edición de la web  es la modificación del css para reducir un poco el tamaño de la imagen de cabecera dentro de cada post (Thumbnail) para el tema [Mainroad][11]

La hoja de estilos del tema está ubicada en "/themes/mainroad/static/css/style.css" y en ella podemos encontrar la clase que hace referencia a esta imagen de cabecera del post.

```
.post__thumbnail img {
	display: block;
  margin-left: auto;
  margin-right: auto;
  width: 100%;
}
```
Editando la propiedad "width" podemos reducir directamente el tamaño de la imagen y aparentemente ya hemos conseguido el objetivo que buscábamos pero...

### El problema
Si actualizamos el tema se perderán todas las modificaciones que hayamos en este archivo "style.css" puesto que este se reescribirá con el que se descargue con la actualización

### Primer intento fallido
La primera prueba que hago es crear un nuevo archivo de hoja de estilo en la ruta "/static/css/style.css" en la que incluir solo la propiedad que pretendemos sobrescribir de forma que el contenido quedará así

```
.post__thumbnail img {
  width: 50%;
}
```

Guardamos los cambios, regeneramos la web y.... Fiasco¡¡¡¡ La web no carga la hoja de estilos ubicada en "/themes/mainroad/static/css/style.css" y sólo carga la que acabamos de crear.

### Segundo intento fallido
Puede que la solución pase por copiar el archivo "/themes/mainroad/static/css/style.css" en la carpeta "/static/css/" y en este segundo archivo creado realizar las modificaciones necesarias a nuestro gusto.  Lo pruebo y funciona correctamente pero este método presenta el problema de que si en un futuro se actualiza la hoja de estilos principal del tema estos cambios no se verán reflajados en la web.

### La solución
Vamos a crear la hoja de estilos "/static/css/custom.css" con únicamente el siguiente contenido

```
.post__thumbnail img {
  width: 50%;
}
```

A continuación copiaremos en archivo "/themes/mainroad/layouts/partials/header.html" en la carpeta "/layouts/partials" y lo editaremos


[11]: https://themes.gohugo.io/mainroad/