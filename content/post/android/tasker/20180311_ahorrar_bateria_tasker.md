---
title: "Como ahorrar batería en el trabajo con Tasker"
date: "2018-03-11"
creation: "2018-03-11"
description: "Mi forma de ahorrar batería en Android cuando no uso el teléfono en el trabajo..."
thumbnail: "images/20180210_ahorrar_bateria_tajo_02.jpg"
disable_comments: true # Optional, disable Disqus comments if true
authorbox: false # Optional, enable authorbox for specific post
toc: false # Optional, enable Table of Contents for specific post
mathjax: false # Optional, enable MathJax for specific post
categories:
  - "Tasker"
draft: false
weight: 5
---
### El problema

Desde hace mucho tiempo tengo la suerte o desgracia de no llevar el móvil encima mientras estoy en el trabajo, se queda en la taquilla del vestuario y la mayoría de los días allí permanece sin tocarlo esperando a que se acabe la jornada.

Pero esto no quiere decir que no me de ningún quebradero de cabeza, uno de los problemas que se me plantea es el gasto de batería ya que la taquilla es una perfecta jaula de faraday y el teléfono invierte mucho esfuerzo en buscar conectividad móvil.

Desactivar los datos es una buena forma de minimizar el gasto de batería, pero es muy latoso tener que estar activando y desactivando esta opción de forma manual. Por esto he creado en Tasker un perfil que lo automatiza.

### La solución

Usando Tasker, para saber cuando estoy en el trabajo sin tener que yo hacer nada hay varias posibilidades, usando la localización GPS, mediante las antenas de telefonía cercanas o mediante las redes wifi cercanas.

> Tasker dispone de un plugin de pago [Autolocation][1] que todavía no he probado y que, con un coste de 2€, puede ser útil si utilizas varias ubicaciones para gestionar Tasker.

La primera implica un gran gasto de batería que es lo que queremos evitar y la segunda solo es precisa cuando te encuentras en una zona con mucha densidad de antenas (Que no es mi caso). Descartadas las dos primeras, me quedo con la detección de ubicación basándome en las redes wifi cercanas (No hace falta que se efectúe la conexión a ninguna de ellas, solo detectar que está cerca)

Software necesario:

  * Tasker (2.99E) disponible en la [Play Store][2]

Con todo lo anterior, tal y como se puede ver en la imagen posterior tengo creados dos perfiles

  * En el trabajo -> Cuando detecta próxima la wifi del trabajo se activa este perfil, su tarea de entrada la empleo para otros menesteres.
  * Ahorrar bateria en el trabajo -> Tiene dos condiciones de activación, que el perfil "En el trabajo" esté activo y que la pantalla del móvil esté apagada. cuando se cumplan estas condiciones se desactivarán los datos móviles del teléfono.

uno que me detecta cuando estoy en el trabajo En Tasker, crearemos un perfil con dos condiciones de activación. \* Detectar cerca la red wifi del trabajo \* Tener la pantalla del móvil apagada La tarea de entrada apagará los datos y la de salida los encenderá.

![Perfiles de ahorro][3]

Así de simple, de esta forma mientras estoy en el trabajo los datos móviles solo se activan cuando tengo la pantalla encendida.

 [1]: https://play.google.com/store/apps/details?id=com.joaomgcd.autolocation
 [2]: https://play.google.com/store/apps/details?id=net.dinglisch.android.taskerm&hl=es
 [3]: /images/20180210_ahorrar_bateria_tajo_01.jpg
