---
title: "Hugo is deprecated"
date: "2019-04-30"
creation: "2019-04-30"
description: "Te tiemblan las piernas cuando no eres un programador avanzado y sale una advertencia de compilación"
thumbnail: "images/20190430_hugo_deprecated_00.jpg"
disable_comments: true
authorbox: false
toc: false
mathjax: false
categories:
  - "hugo"
draft: false
weight: 5
---
Cuando no eres un programador avanzado cualquier advertencia o fallo en el momento de la compilación en la fase de producción puede ser un fuerte dolor de cabeza, la función ".Hugo" parece que va a caer en desuso, a ver como puedo apañarlo...
<!--more-->
Habitualmente, este blog se compila de forma automática mediante uns sincronización con Google drive tal y como he comentado en algún post anterior por lo que me doy cuente de los errores al ver la publicación pero no me percato de las advertencias del compilador de Hugo.  Hoy he compilado la web de orma manual y me he encontrado con esta advertencia.

'Building sites … WARN 2019/04/09 11:16:17 Page's .Hugo is deprecated and will be removed in a future release. Use the global hugo function.'

Desde mis vago conocimientos de programación, parece que el método ".Hugo" va a caer en desuso en próximas versiones del compilador y se nos invita a usar la función global "hugo".  En este punto puedo dejarlo pasar y ya lo arreglaré (si puedo) cuando deje de funcionar o puedo afrontar ahora el problema para evitar que en futuro se magnifique y no me acuerde de la raiz del mismo.

![imagen_01]

Una busqueda por la web me lleva hasta un post de [discourse.gohugo.io] donde me dan la solución a esta advertencia de compilación.  Tan sencillo como cambiar todos los métodos del tipo ".Page.Hugo.loquesea" por "hugo.loquesea".

Dentro de Visual Studio Code realizo una búsqueda en los distintos archivos del proyecto de mi web ("edit-find in files") del texto ".Hugo" y para mi sorpresa sólo me encuentra una coincidencia en el archivo header.html dentro de la carpeta "layouts".

![imagen_02]

Toca cambiar la línea "{{ .Hugo.Generator }}" por "{{ hugo.generator }}" guardar los cambios y parece que será suficiente.  Realizo una compilación de prueba y veo que la advertencia ha desaparecido.

[discourse.gohugo.io]: https://discourse.gohugo.io/t/pages-hugo-is-deprecated-as-of-0-55-0/17991

[imagen_01]: /images/20190430_hugo_deprecated_01.jpg
[imagen_02]: /images/20190430_hugo_deprecated_02.jpg
