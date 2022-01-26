---
title: "Deshabilitar cache en chrome"
date: "2017-04-11"
description: "Como deshabilitar la caché en Google Chrome para comprobar cambios en el servidor"
thumbnail: "images/20170411_cache_00.jpg"
disable_comments: true
authorbox: false
toc: false
mathjax: false
categories:
  - "productividad"
tags:
  - "google chrome"
draft: false
weight: 5
---
Segun un artículo de [Acceso Directo][2], la cache del navegador se entiende como "un lugar de almacenamiento temporal que se encuentra en la computadora y que guarda archivos que han sido descargados por el navegador para mostrar sitios. Dentro de estos archivos se encuentran aquellos documentos necesarios para la visualización de un sitio como archivos html, hojas de estilo de CSS, sripts de JavaScript, gráficos, imágenes y contenido multimedia en general".

Sin duda ganamos velocidad y reducimos el tráfico de datos pero puede llegar a ser un profundo dolor de cabeza cuando estamos desarrollando una web ya que una simple recarga de la página puede llegar a no mostrarnos los cambios que estamos realizando. En Chrome podemos evitar esta cache mientras estamos modificando la web de una forma muy sencilla con solo tres pasos.

1.- Abrimos en una pestaña la web que queremos visualizar sin cache

2.- Pulsamos "Ctrl+May+I" para acceder al modo de desarrollador.

3.- Pulsamos "F1" para acceder a los ajustes.

4.- En el apartado "Network" marcamos la opción "Disable cache (while DevTools is open)"

![cache][1]

A partir de aquí, el navegador no tendrá en cuenta la caché almacenada de una web mientras tengamos abierto el modo de desarrollador.

[1]: /images/20170411_cache_01.jpg
[2]: http://acceso-directo.com/todo-lo-que-necesitas-saber-sobre-el-cache-del-navegador/