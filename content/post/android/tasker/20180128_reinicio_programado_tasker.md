---
title: "Reinicio programado con Tasker en Android"
date: "20180128"
creation: "20180128"
description: "No está de más reiniciar Android de vez en cuando y si es de forma programada mejor..."
thumbnail: "images/20180117_tasker_reinicio.jpg"
disable_comments: true
authorbox: false
toc: false
mathjax: false
categories:
  - "Tasker"
draft: false
weight: 5
---
### El Problema
Si eres de los que no apaga nunca el smartphone esta pequeña receta te va a interesar. Aunque soy un completo desconocedor de los motivos específicos, es fácil comprobar como si nunca apagas del teléfono, con el paso de los días empiezan a aparecer consumos de batería anómalos y ciertas inestabilidades en el sistema.  


### La solución
Para evitarlo me he creado una pequeña receta en Tasker según la cual se produce un reinicio automático del terminal los lunes, miércoles y viernes a las dos de la madrugada.

Software necesario:

  * Tasker (2.99E) disponible en la [Play Store][1]

En primer lugar creamos una nueva tarea, le asignamos el nombre de "reiniciar", añadimos una acción y desde el menú "Sistema" elegimos la opción "Reiniciar" y dejamos el tipo como "Normal", atrás y tendremos lo siguiente:

![tarea reiniciar][2]

Desde la pestaña "Perfiles" creamos un nuevo perfil al que le incluiremos dos condiciones, una condición de "dia" para que se ejecute los lunes, miércoles y viernes, y otra condición de "hora" para que se ejecute a las 2:00 AM. Ya solo resta asignarle que ejecute la acción "reiniciar" cuando se cumplan las condiciones y quedará como el siguiente.

![perfil reiniciar][3]

_Un consejo: Para añadir dos condiciones a un perfil deberemos mantener pulsado sobre la primera condición para asignar una nueva._

Y ya está, puedes descargar desde aquí la

 [1]: https://play.google.com/store/apps/details?id=net.dinglisch.android.taskerm&hl=es
 [2]: /images/20180116_tasker_reiniciar_01.jpg
 [3]: /images/20180116_tasker_reiniciar_02.jpg