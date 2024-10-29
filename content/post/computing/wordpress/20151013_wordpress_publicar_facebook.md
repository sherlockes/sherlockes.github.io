---
title: "Publicar automáticamente en Facebook al hacerlo en WordPress"
date: "2015-10-13"
creation: "2015-10-13"
description: "De las muchas formas que hay para publicar en Facebook las entradas de Wordpress, aquí pongo la que yo utilizo."
thumbnail: "images/20151013_wordpress_facebook.jpg"
disable_comments: true
authorbox: false
toc: false
mathjax: false
categories:
  - "WordPress"
tags:
  - "Facebook"
draft: false
weight: 5
---
Que algo sencillo se convierta en un dolor de cabeza es una de las cosas que más frustra. He estado mucho tiempo buscando una forma rápida y sencilla de que mis publicaciones en el blog se conviertan también en entradas de mi página en Facebook para que al menos mis "amigos" tengan la oportunidad de enterarse de los artículos que escribo y los lean en caso de que les interese.

Mis conocimientos en programación para WordPress y respecto a la Api de Facebook no me permiten ni de lejos escribir por mi mismo el código necesario para conseguir esta publicación encadenada. Por esto me veo obligado a buscar ayuda en la red. Tras buscar sin éxito algún que otro plugin gratuito capaz de realizar esta publicación automática en Facebook encontré de casualidad una web que a muchos os puede resultar de utilidad.

Se trata de [www.ifttt.com][11] y aunque el nombre de la web no da ninguna información de la misma, pretende ser un nexo de unión entre las distintas aplicaciones que a diario usamos en la red.

![imagen][1]

Hacerse una cuenta es rápido y gratuito. El siguiente paso es empezar a crear nuestras propias recetas o utilizar alguna de las que otros usuarios han creado. Crear una nueva receta es tan fácil como buscar una condición y añadir una consecuencia, en mi caso la condición será el que haya una nueva publicación en el blog y la consecuencia publicarla en mi página de Facebook.

![imagen][2]

En un primer momento tuve problemas con esta estrategia así que la modifiqué un poco y en lugar de tener como condición la publicación de una nueva entrada en el blog opté por que lo sea la modificación del RSS que genera el blog. A efectos prácticos es casi lo mismo pero con una pequeña salvedad y es que, usando esta segunda opción, para que IFTTT se de cuenta de que se ha modificado el RSS la fecha de publicación de la entrada tiene que ser más reciente que la última que había detectado. Es decir, si he publicado en el blog una entrada en Septiembre, otra que publique posteriormente pero con fecha de Agosto no pasará a ser publicada automáticamente en mi página de Facebook.

Con esto la receta alternativa quedaría como la siguiente.

![imagen][3]

La web permite muchísimas opciones tanto para condiciones como para consecuencias, os invito a todos a navegar por la misma y seguro que encontráis alguna receta que puede seros de utilidad.

Deja un comentario si tienes alguna duda o has encontrado interesante alguna de las recetas que ofrece esta web.

[1]: /images/20151013_ifttt.jpg
[2]: /images/20151013_recipe_01.jpg
[3]: /images/20151013_recipe_02.jpg

[11]: https://ifttt.com/recipes