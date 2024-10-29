---
title: "Marcos de imágenes en WordPress"
date: "2015-07-29"
creation: "2015-07-29"
description: "Como tratar los marcos de las imágenes en WordPress, un método sencillo para ponerlos o quitarlos"
thumbnail: "images/20150729_wordpress_frame.jpg.jpg"
disable_comments: true
authorbox: false
toc: false
mathjax: false
categories:
  - "WordPress"
draft: false
weight: 5
---
Escribiendo hoy un post he encontrado la solución a un problema que ya se me había planteado anteriormente y hasta ahora no había sido capaz de encontrar de una forma sencilla como esta. Se trata de los marcos alrededor de las imágenes en WordPress.

Por defecto, si insertamos en la entrada una imagen desde la galería en una entrada de WordPress el código que se genera es el siguiente

```
<img src="sherblog/wp-content/uploads/Homer.jpg" alt="Image" class="aligncenter size-full wp-image-556" />
```

Resultando la imagen con un bonito marco que no siempre queremos que aparezca

Pues bien, si modificamos el código anterior para dejarlo como aparece a continuación podremos ver como el marco desaparece quedando así la imagen mucho más integrada con el fondo de la página.

```
  <img src="sherblog/wp-content/uploads/Homer.jpg" alt="Image" />
```

Sinceramente, no se si esta solución ha funcionado con versiones anteriores, lo que está claro es que con la 4.2.3 funciona.