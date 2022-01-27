---
title: 'Montar servidor. Configuraci&oacute;n del router.'
author: Sherlockes
type: post
date: 2008-01-29T17:13:27+00:00
url: /?p=20
mytory_md_visits_count:
  - 1
categories:
  - Servidor
tags:
  - router
  - servidor

---
Con todo lo explicado en el post anterior sobre el [direccionamiento din&#225;mico][1] todav&#237;a no es posible acceder desde cualquier cliente de internet a nuestro servidor ya que falta salvar la barrera del router.&#160; El concepto es bastante simple, aunque la pr&#225;ctica se puede complicar un poco.&#160; B&#225;sicamente, la soluci&#243;n pasa por redireccionar el tr&#225;fico entrante al router a trav&#233;s del puerto 80 a nuestro servidor.&#160; Para ello es necesario saber la IP local de la m&#225;quina donde est&#225; montado el servidor.&#160; En un entorno windows abriendo el estado de la red de &#225;rea local veremos la siguiente pantalla.

<p align="center">
  <img style="border-top-width: 0px; border-left-width: 0px; border-bottom-width: 0px; border-right-width: 0px" height="239" alt="estado_red" src="http://sherver.homeip.net/blog/wp-content/uploads/2008/01/windowslivewritermontarservidor.configuracindelrouter-10045estado-red-thumb.jpg" width="304" border="0" />
</p>

<p align="justify">
  Es indispensable que el tipo de direcci&#243;n est&#233; configurado manualmente, ya que de lo contrario cada vez que el servidor se conecte al router este le asignar&#225; una direcci&#243;n distinta y ser&#225; imposible el acceso a este.&#160; Para configurarla manualmente acceder a Inicio &#8211;> Configuraci&#243;n &#8211;> Conexiones de red &#8211;> Conexi&#243;n de area local &#8211;> Propiedades &#8211;> Protocolo TCP-IP &#8211;> Propiedades&#160; y deseleccionar la obtenci&#243;n autom&#225;tica de IP.
</p>

<!--more-->

<p align="justify">
  Quien haya sido capaz de <a href="http://sherver.homeip.net/blog/?p=8">instalar debian</a> en la m&#225;quina no creo que tenga ning&#250;n problema con la asignaci&#243;n manual de la IP al servidor.
</p>

<p align="justify">
  La puerta de enlace corresponde a la direcci&#243;n IP local del router.&#160; Ahora s&#243;lo resta la tan temida por algunos apertura de puertos, para ello hay que acceder a la configuraci&#243;n del router introduciento la IP del mismo en la barra de direcciones del navegador, en nuestro caso <a href="http://192.168.1.1">http://192.168.1.1</a> e introducir el nombre de usuario y contrase&#241;a correspondiente.&#160; A partir de aqu&#237; el asunto var&#237;a bastante en funci&#243;n del router con el que estemos trabajando, en&#160; <a href="http://www.adslzone.net/emule_id.html" target="_blank">ADSLZone</a> tienen explicado el m&#233;todo para los m&#225;s comunes.&#160; Resumiendo, en nuestro caso deberemos abrir el puerto 80 para la direcci&#243;n 192.168.1.33.&#160; En mi caso, con el router Amper Xavi x7768r Wireless de telef&#243;nica el resultado es el siguiente.
</p>

<p align="center">
  <a href="http://sherver.homeip.net/blog/wp-content/uploads/2008/01/windowslivewritermontarservidor.configuracindelrouter-10045puertos-2.jpg"><img style="border-right: 0px; border-top: 0px; border-left: 0px; border-bottom: 0px" height="266" alt="puertos" src="http://sherver.homeip.net/blog/wp-content/uploads/2008/01/windowslivewritermontarservidor.configuracindelrouter-10045puertos-thumb.jpg" width="354" border="0" /></a>
</p>

<p align="justify">
  Para que los cambio en el router surtan efecto es indispensable guardarlos y reiniciar el dispositivo.
</p>

 [1]: http://sherver.homeip.net/blog/?p=16