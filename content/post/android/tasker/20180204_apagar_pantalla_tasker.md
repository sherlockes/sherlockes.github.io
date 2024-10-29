---
title: "Apagar la pantalla con Tasker en Android"
date: "2018-02-04"
creation: "2018-02-04"
description: "Apagar la pantalla con Tasker en Android"
thumbnail: "images/20180109_tasker_pantalla.jpg"
disable_comments: true
authorbox: false
toc: false
mathjax: false
categories:
  - "Tasker"
draft: false
weight: 5
---
La receta que mas utilizo en Tasker es al mismo tiempo una de las más sencillas. Está claro que si quieres prolongar la duración de la batería de tu teléfono la solución más sencilla pasa por tener la pantalla apagada el mayor tiempo posible. Además, cuando te metes el dispositivo móvil al bolsillo es muy interesante que este tenga la pantalla bloqueada para evitar pulsaciones fantasma. Muchos terminales ofrecen la posibilidad del bloqueo y desbloqueo con un doble toque. Es una opción realmente útil que yo usaba mientras tuve instalado el firmware oficial del fabricante pero que perdí al mudarme a Lineage de forma que ahora solo funciona de forma nativa bien para encender la pantalla o bien para apagarla desde la pantalla de bloqueo. Para combatir esta carencia he creado una pequeña tarea dentro de Tasker basada en el plugin [Secure Settings][1].

Software necesario:

  * Tasker (2.99E) disponible en la [Play Store][2]
  * Plugin Secure Settings (gratis) disponible en la [Play Store][3]

Pasos a seguir:

  * Crear una nueva tarea 
  * Añadir una nueva acción
  * Seleccionar Plugin
  * Seleccionar Secure Settings
  * En el menú &#8220;Configuración&#8221; pulsar sobre el lápiz
  * En el menú &#8220;Dev Admin Actions&#8221; seleccionar &#8220;Lock Device&#8221;
  * Marcar la opción &#8220;Device Admin Enabled&#8221;
  * Guardar los cambios y volver atrás

Desde el botón central de la barra inferior podemos asignar una imagen a la tarea y ya la tenemos terminada. Debería quedar algo así.

![pantalla tasker][4]

Ahora solo resta agregar un widget con un acceso directo a esta tarea en la pantalla que deseemos de nuestro launcher y cuando lo pulsemos se apagará la pantalla.

![boton apagar][5]

Simple, rápido y efectivo. Si quieres puedes descargar desde [aquí][6] la tarea para importarla en tu aplicación Tasker.

 [1]: https://play.google.com/store/apps/details?id=com.intangibleobject.securesettings.plugin
 [2]: https://play.google.com/store/apps/details?id=net.dinglisch.android.taskerm&hl=es
 [3]: https://play.google.com/store/apps/details?id=com.intangibleobject.securesettings.plugin&hl=es
 [4]: /images/20180109_tasker_pantalla_01.jpg
 [5]: /images/20180109_tasker_pantalla_02.jpg
 [6]: /files/tasker_apagar_pantalla.tsk.xml