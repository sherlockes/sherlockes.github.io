---
title: "Los servidores de Emule caídos"
date: "2009-01-09"
creation: "2009-01-09"
description: "Los servidores de Emule caídos"
#thumbnail: "images/titulo_00.jpg" # 300x200px
disable_comments: true
authorbox: false
toc: false
mathjax: false
categories:
  - "productividad"
tags:
  - "emule"
draft: false
weight: 5
---
Son malos tiempos para el tema de los servidores de Emule. Es fácil que un buen día te encuentres con que no puedes conectar a ninguno de tu eterna lista de servidores ED2K pero tranquil@, lo principal es mantener la calma.

Como primera medida (Si no la habías tomado anteriormente) es activar la Red Kademlia. El asunto es tan simple como ir al menú Preferencias-Conexión y en el apartado "Red" activar la casilla correspondiente a la red Kad.
  
![image][11]
  
Después desde la pestaña Kad debes realizar un autoarranque de clientes conocidos. Si no eres capaz de arrancar la red Kad pásate por este [foro][1]. Aquí están contempladas casi todas las posibilidades ante un fallo de conexión a la red Kad. Pero vamos al tema de los servidores.

En el menú Personalizar-Servidor, activa sólo las opciones de Auto-actualizar la lista de servidores al iniciar y el control inteligente de Id baja al conectar. Después pincha en el botón "Editar&#8230;" para acceder a las direcciones de las que queremos actualizar la lista de servidores.
  
![image][12]
  
Se abrirá una ventana del bloc de notas y en esta ponemos estas dos direcciones

```
http://peerates.net/servers.php
http://www.gruk.org/server.met
```
  
Tras esto, cerramos y guardamos los cambios. Ahora sólo resta borrar todos los servidores que tengamos en nuestra lista y reiniciar Emule para que se conecte a las direcciones que le hemos incluido de forma que tendremos una lista actualizada con los servidores "fiables"

Como pequeño consejo, lo más práctico es ordenar la lista de servidores por el número de archivos que tiene cada una y conectarse al servidor con un número mayor.

[1]: http://forum.emule-project.net/index.php?showtopic=129187

[11]: /images/20090109_red_kad_1.jpg
[12]: /images/20090109_servidores_emule.jpg