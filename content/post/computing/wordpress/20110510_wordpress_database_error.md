---
title: "Error en WordPress (Elegir la base de datos)"
date: "2011-05-10"
description: "Error en WordPress (Elegir la base de datos)"
thumbnail: "images/20110510_wordpress_phpmyadmin.jpg"
disable_comments: true
authorbox: false
toc: false
mathjax: false
categories:
  - "wordpress"
draft: false
weight: 5
---
Un buen día, intentas acceder a tu blog y te encuentras un mensaje como el siguiente.
  
```
\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
# _Error establishing a database connection_
\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
```

Aunque la cosa no pinta bien, intentas que no cunda el pánico y accedes directamente a las páginas de administración del blog pero la cosa se pone fea cuando ves un cartel con la siguiente información.

```
\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
# No se pudo elegir base de datos

Hemos podido conectar con el servidor de la bases de datos (lo que significa que tu nombre de usuario y la contraseña están correctos) pero no se pudo elegir la base de datos `olivas_blog`.

  * ¿Estás seguro que existe?
  * ¿El usuario _loquesea_ tiene permiso para utilizar la base de datos?
  * En algunos sistemas el nombre de la base de datos es el prefijo con el nombre de usuario, que sería como _username_loquesea_. ¿Podría ser ésto el problema?

Si no sabes cómo configurar una base de datos debes ponerte en contacto con el **administrador de su hosting**. Si todo lo demás falla puedes encontrar ayuda en los Foros de Soporte de WordPress].
\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
```

Rápidamente pones a trabajar a San Google y la primera solución que aparece es un fallo de la versión en castellano de WordPress. Bueno, la reparación parece fácil, se descarga la última versión en inglés, se sube al servidor, se descomprime y... El asunto sigue igual (Ya me veo reinstalando toda la web desde cero y empieza a ponerse la situación un poco tensa). Como parece que el fallo viene de la base de datos, intento restaurar una copia de seguridad de la misma pero este segundo intento tampoco trae consigo ningún resultado positivo.

Compruebo que el usuario de WordPress tiene privilegios sobre la base de datos y al ver que si es así se me ocurre la "feliz idea" de desvincular el usuario a la base de datos y volverlo a vincular posteriormente. No se por que pero el blog después de esta operación vuelve a la vida. Una solución que cuesta realizarla menos de un minuto y que me podía haber hecho perder varias horas.

Un poco de suerte siempre es de agradecer.