---
title: "Cuando una App deja KO a Android"
date: "2018-11-29"
description: "Una de esas veces que piensas que el teléfono lo tienes perdido y lo consigues recuperar de una forma rápida y sencilla."
thumbnail: "images/20181129_android_error_mac_00.jpg"
disable_comments: true
authorbox: false
toc: false
mathjax: false
categories:
  - "android"
draft: false
weight: 5
---
No se si es un problema de tener un teléfono android, de que este tenga casi cuatro años, de que sobre el corra Lineage OS en lugar de la distribución del fabricante, de que esté rooteado o simplemente ha sido un bug en una aplicación que durante varias horas me ha provocado un fuerte dolor de cabeza.

Todo empieza al intentar instalar el pack de router y satélite Orbi de Netgear que requiere la [App][11] del propio fabricante

![Image Netgear App][01]

Llega un punto de la configuración dentro de la app en el que el teléfono se queda completamente bloqueado y la única forma de salir de este bloqueo es mediante un “Soft Reset” que en mi terminal, un BQ Aquaris E5 HD, se consigue manteniendo pulsado el botón de encendido durante varios segundos.  Después del reinicio el teléfono funciona pero no detecta ninguna red wifi y la única forma de que no se vuelva a quedar bloqueado es desactivando el Wifi.

![lineage][02]

Por mi cabeza pasa lo peor y es que no me apetece nada restaurar el terminal a los valores de fábrica y tener que volver a realizar toda la configuración así que sigo buscando una solución menos dolorosa.

Después de varios intentos y reinicio fallidos me doy cuenta de la MAC asignada a la tarjeta wifi es un poco “rara” y es que un valor de “02:00:00:00:00:00” no es nada habitual.

![Wifi][03]

Ahora ya tengo algo más de información para seguir buscando y no tardo con dar lo que podría ser una solución que pasa por “Resetear las conexiones de red”, sólo resta encontrar la forma de hacerlo en [Lineage OS][12].  No tardo mucho tiempo en encontrar el menú dentro de "Ajustes"-"Conexiones inalámbricas y redes"-"Mas..." donde aparece la opción "Restablecer ajustes de red"

![ajustes][04]

Un simple clic, aceptas las consecuencias y ya está¡¡¡

Milagrosamente el wifi vuelve a la vida con la única consecuencia de que has perdido las claves wifi de todas las conexiones que tenías guardadas así como los emapejamientos bluetooth, un mal menor.

[01]: /images/20181129_android_error_mac_01.jpg
[02]: /images/20181129_android_error_mac_02.jpg
[03]: /images/20181129_android_error_mac_03.jpg
[04]: /images/20181129_android_error_mac_04.jpg

[11]: https://play.google.com/store/apps/details?id=com.dragonflow.android.orbi&hl=es
[12]: https://lineageos.org/