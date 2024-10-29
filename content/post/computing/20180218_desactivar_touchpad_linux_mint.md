---
title: "Desactivar el TouchPad en Linux Mint"
date: "2018-02-18"
creation: "2018-02-18"
description: "Como desactivar el touchpad en un portatil con Linux Mint"
thumbnail: "images/20180127_touchpad_0.jpg"
disable_comments: true
authorbox: false
toc: false
mathjax: false
categories:
  - "linux"
tags:
  - "linux mint"
draft: false
weight: 5
---
### El problema, mis dedos&#8230;

En mi vuelta a linux, llevo unos días trabajando en un portátil y todavía no estoy muy acostumbrado a trabajar sobre el teclado con las manos tan juntas. Uno de los problemas con los que me encuentro es que los dedos gordos hay momentos en los que me rozan con el TouchPad y llegan a mover el cursor de posición, pudiendo cambiar el punto de inserción de texto o incluso borrar parte de lo ya escrito. No es un gran problema, pero hay veces que llega a ser molesto por la pérdida de tiempo o incluso información.

<!--more-->

He probado varias soluciones a este problema y voy a exponerlas aquí. Antes de nada, lo que a continuación escribo ten claro que lo he efectuado sobre la versión 18.3 de Linux Mint no garantizo su funcionamiento en otras versiones, distribuciones o plataformas.

### Solución 1 &#8211; Desactivar el panel mientras se escribe

![Desactivar panel LMint][1]

La primera solución que se me pone delante es la deshabilitación temporal del TouchPad mientras se esté escribiendo. El tiempo de deshabilitación es personalizable tal y como se puede ver en la imagen superior. He probado con un tiempo de 2 segundos y la verdad es que el resultado es bastante bueno y creo que esta es la mejor solución para mantener activo el panel pero sin que moleste mientras se escribe.

### Solución 2 &#8211; Desactivar el panel y trabajar con ratón.

Personalmente, prefiero trabajar con el ratón que con el panel táctil, me parece más cómodo y preciso aunque tiene el problema de que tienes que cargar con un aparato más. Por esto he probado con esta segunda alternativa que pasa por desactivar el TouchPad desde el menú &#8220;Ratón y panel táctil&#8221;

![Desactivar panel LMint][2]

La solución es perfectamente válida, pero presenta un pequeño problema y es que si no conectas el ratón el panel sigue deshabilitado y no hay forma de mover el cursor. Aunque es posible reactivar el panel mediante el uso del teclado, es un poco incómodo si te ocurre a menudo.

### Solución 3 &#8211; Touchpad Indicator

Esta tercera, y de momento última solución pasa por instalar [&#8220;Touchpad Indicator&#8221;][3]. Este software ya advierte el autor de que lleva tiempo sin actualizarse, pero a día de hoy es perfectamente válido y funcional, con apenas tres líneas de código y menos de 2mb podemos instalarlo.

    sudo add-apt-repository ppa:atareao/atareao
    sudo apt-get update
    sudo apt-get install touchpad-indicator
    

y al mismo tiempo dar un repaso al blog de [El atareao][4] donde puedes encontrar infinidad de soluciones para linux. Cuando esté instalado, lo arrancamos y aparecerá junto a los iconos de la barra de inicio. Click y abrimos las preferencias.

![Preferencias Touchpad Indicator][5]

No voy a explicar todas las características de esta aplicación, ya que su autor las expone perfectamente en el enlace anterior. Solo reseñar la que para el problema de hoy me ha resultado útil y es que al conectar un ratón al ordenador se deshabilita el panel táctil.

De momento me quedo con esta tercera solución pero no se si será la definitiva. Si tienes alguna otra no dudes en dejar un comentario.

 [1]: /images/20180127_touchpad_1.jpg
 [2]: /images/20180127_touchpad_2.jpg
 [3]: https://www.atareao.es/aplicacion/touchpad-indicator-para-ubuntu/
 [4]: https://www.atareao.es/
 [5]: /images/20180127_touchpad_3.jpg