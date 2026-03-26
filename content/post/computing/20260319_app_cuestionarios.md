---
title: "App de cuestionarios"
date: "2026-03-26"
creation: "2026-03-19"
description: "Como he utilizado un popurri de servicios gratuitos para la creacion de esta app de cuestionarios"
	thumbnail: "images/20260319_app_cuestionarios_00.jpg"
disable_comments: true
authorbox: false
toc: false
mathjax: false
categories:
- "computing"
tags:
- "notebooklm"
- "google sheets"
- "google scripts"
- "vercel"
draft: false
weight: 5
---
Esta es una prueba de concepto de como he utilizado una serie de servicios gratuitos para la creación de una app de cuestionarios. No pretendo explicar el funcionamiento, sólo en que me ha ayudado cada uno.
<!--more-->
- [google drive]: Todo empieza aquí, escanear un libro con la cámara del teléfono y guardarla en la nube es coser y cantar. Lo mas laborioso de escanear las 20 páginas de un tema es que le tienes que poner a mano el nombre del archivo.
- [notebooklm]: Esto es simplemente magia, le subes el archivo que hemos escaneado anteriormente y sólo hace falta un simple prompt para que te devuelva un cuestionario tipo test en formato json para alimentar nuestra aplicación.
- [github]: Que mejor sitio para alojar nuestro proyecto en forma de repositorio. Todo lo necesario para nuestra app estática.
- [gemini]: Este LLM me ha ayudado con la parte de la programación de la app web, todo el código html, css y js ha sido creado haciendo uso del Vibe Coding.
- [google sheets]: En este archivo de hoja de cálculo vamos a guardar una tabla con los datos para realizar la clasificación de las mejores nota.
- [google scripts]: El enlace del html estático con la hoja de calculo lo haremos con dos pequeñas funciones que van a cumplir las labores de API
- [vercel]: Desplegar una app web a partir de un repositorio es una labor de niños gracias a este servicio

El resultado de la fusión de todos estos servicios lo puedes ver en: https://miraquizs.vercel.app

![image-01]

### Enlaces de interés
- [enlace](www.sherblog.es)

[gemini]: https://gemini.google.com
[github]: https://github.com
[google drive]: https://drive.google.com
[google scripts]: https://workspace.google.com/intl/es/products/apps-script/
[google sheets]: https://docs.google.com/spreadsheets/
[notebooklm]: https://notebooklm.google.com
[vercel]: https://vercel.com

[image-01]: /images/20260319_app_cuestionarios_01.jpg



