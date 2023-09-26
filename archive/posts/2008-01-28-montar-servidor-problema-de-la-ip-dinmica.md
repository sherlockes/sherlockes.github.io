---
title: Montar servidor. Problema de la IP dinámica.
author: Sherlockes
type: post
date: 2008-01-28T18:16:43+00:00
url: /?p=16
categories:
  - Servidor
tags:
  - dinamica
  - ip
  - servidor

---
La mayoría de las conexiones a internet se dan bajo la condición de IP dinámica, pero ¿Que significa esto?  Cada vez que tu modem o router se conecta al servidor de internet este le asigna una dirección IP para poder encaminar el tráfico entre ambos. Esta IP no es más que un número del tipo a "81.36.171.37", si quieres saber cual es el tuyo puedes entrar en <a HREF="http://www.ip-adress.com/" TARGET="_blank">ip-adress.com</a>.  Cuando se contrata una conexión a internet, el precio depende básicamente de tres factores, por un lado el proveedor, por otro la velocidad o ancho de banda y finalmente del tipo de IP que se asigna al cliente que puede ser estática (cara) o dinámica (barata).  La diferencia entre estos tipos de IP es que en la estática el proveedor asigna siempre el mismo número de IP mientras que en la estática cada vez que se produce una conexión al proveedor este asigna un número distinto.

La finalidad de montar un servidor reside en que este pueda pueda prestar algún tipo de servicio a una serie de clientes pero de nada valdrá si estos clientes no son capaces de encontrarlo.  Si cada vez que se pierde la conexión a la red del servidor a este se le asigna una nueva IP será muy complicado que los clientes le asignen un lugar en la red.  Pero todo tiene solución.

Hay varios lugares donde dan la solución a este problema pero me voy a ceñir a <a HREF="https://www.dyndns.com" TARGET="_blank">DynDNS</a> ya que hasta ahora me ha funcionado muy bien.  Aunque tienen servicios de pago, lo que ahora necesitamos es completamente gratis y sólo hará falta un poco de inglés para los trámites.  Te creas una cuenta y luego dentro del apartado "My Services" añades un nuevo host desde "Add Host Services", escoges el nombre que desees con la extensión que más te guste de las existentes, no cambias el tipo de servicio y en la dirección IP pones la del link inferior.

Si has realizado el proceso correctamente deberás ver una pantalla similar a esta:

<p ALIGN="center">
  <img STYLE="border-top-width: 0px; border-left-width: 0px; border-bottom-width: 0px; border-right-width: 0px" HEIGHT="194" ALT="dyndns" SRC="http://sherver.homeip.net/blog/wp-content/uploads/2008/01/windowslivewritermontarservidor.problemadelaipdinmica-10f18dyndns-thumb.jpg" WIDTH="300" BORDER="0" />
</p>

Ahora lo que hace falta es automatizar el proceso de actualización de IP.  Para un entorno windows está el programa <a HREF="https://www.dyndns.com/support/clients/windows.html" TARGET="_blank">DynDNS Updater</a> y para linux <a HREF="https://www.dyndns.com/support/clients/unix.html" TARGET="_blank">Ddclient</a>, ambos son muy sencillos e intuitivos de instalar y configurar.  Un consejo, no es recomendable poner muy alta la frecuencia de refresco de la IP ya que no es más que un consumo inutil de ancho de banda.

Con esto no está todo lo necesario para que desde cualquier máquina escriba <a HREF="http://sherver.homeip.net">http://sherver.homeip.net</a> y acceda a mi servidor ya que todavía queda la barrera de configuración del router.  Antes de acabar una pequeña aclaración sin la cual puedes llevar un profundo dolor de cabeza durante unos días.  Si desde un ordenador de la red local o desde el mismo servidor intentas acceder a la dirección en cuestión lo unico que verás será la página de configuración del router.  Para evitar esto será necesario editar el archivo "c:\WINDOWS\system32\drivers\etc\hosts" con el bloc de notas e introducir al final una nueva línea que ponga "192.168.1.33 sherver.homeip.net" con la dirección IP local del servidor y la dirección que has redireccionado.