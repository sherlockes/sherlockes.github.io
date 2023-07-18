---
title: "Instalando Windows 7"
date: "2018-04-19"
description: "Atrás han quedado los tiempos de la piratería, colaboremos todos con Microsoft."
thumbnail: "images/20180419_win7.jpg"
disable_comments: true # Optional, disable Disqus comments if true
authorbox: false # Optional, enable authorbox for specific post
toc: false # Optional, enable Table of Contents for specific post
mathjax: false # Optional, enable MathJax for specific post
tags:
  - "windows"
draft: false
weight: 5
---
### El problema, un sistema lento

Varios años después necesito instalar Windows en un pc, ya me he cansado de tener que esperar diez minutos hasta que arranque el sistema después de casi siete años de que la instalación de Windows 7 home Premium este acumulando kilos y kilos de basura informática.

### Windows 7 Vs Windows 10

Hoy por hoy Windows 7 me ofrece todo lo que necesito y el pc en el que voy a instalarlo no es precisamente de última generación por lo que no siquiera valoro la instalación de Windows 10. Seguro que me estoy perdiendo cientos de buenas características pero ya he dejado atrás los tiempos en los que el sistema operativo era una experiencia, ahora sólo lo considero una herramienta.

### Restauración o instalación limpia

El pc con el que estoy luchando es un Packard Bell de sobremesa con un i3 al que después del primer arranque le cree unos Cd's (o puede que fuera dvd) de restauración para los casos de emergencia como este pero, sinceramente, después de tantos años y varias mudanzas no tengo ni idea de donde están estas copias de seguridad. Según lo anterior parece obvio que voy a tener que realizar una instalación del sistema desde cero.

### Software original o pirata

Ya han quedado atrás los años del pirateo y de probar software que no necesito. Ahora siempre que puedo uso software libre o gratuito y si la aplicación lo merece y el precio es razonable no me importa pagar ya que todos merecemos ver recompensado nuestro esfuerzo.

### Que versión de Windows 7 instalar

Starter Edition, Home Basic, Home Premium, Pro, Enterprise, Ultimate... Son varias las alternativas y, aunque creo con con cualquiera de ellas me puedo apañar, después de haber funcionado durante estos años con la versión Home Premium la intención es dar un paso hacia delante (Si el precio no se dispara) y pasar a la versión Pro ya que según lo que he podido leer y entender las versiones Enterprise y Ultimate ofrecen características que son mucho más útiles en un entorno empresarial.

### Cuanto dinero cuesta Windows 7 Pro

Aquí va la parte más divertida del problema que hoy se nos presenta. ¿Donde compro una instalación de Windows 7 Pro? ¿Cuanto cuesta? El primer sitio donde busco es Amazon y resulta curioso como, a partir de 30€, hay una increíble disparidad de precios para un mismo producto, unos discos de instalación con una licencia válida.

![Win7Pro][1] ![Win7Pro][2]

Está claro, 200€ no voy a pagar por una instalación de windows que dentro de dos años ya no recibirá actualizaciones pero 27€ parece un precio razonable que no descarto aunque hay que seguir con el estudio de mercado previo a la compra. Acto seguido busco en ebay y... increíble!!! Hay licencias de Windows 7 Pro a partir de poco más de dos euros.

![Win7Pro][3]

Unos días atrás he oido a [Converso72][4] hablar de estas licencias de Windows originales que se venden por Ebay. Al parece provienen de fabricantes de Pc's que compran a Microsoft miles de licencias OEM para sus productos y les quedan muchas sin utilizar. Converso ha comprado una pero no ha dicho todavía cual ha sido el resultado de la compra aunque por este precio, me tiro a la piscina. Busco un vendedor de más confianza y que haya vendido bastantes y al final me decanto por esta de poco menos de 6€.

![Win7Pro][5]

[Aquí][6] el enlace por si a alguien os interesa.

### He pagado, y ahora que?

Poco tiempo dura la espera, así como recibo el correo del pago de PayPal recibo tambien un correo del vendedor con el número de licencia y un enlace para descargar la iso de la instalación.

![Win7Pro][7]

Bueno, por lo menos ha mandado algo y además muy rápido, esto empieza bien. Puesto que no me fio del contenido que haya en el enlace de Mega que me ha mandado el vendedor, cojo el número de serie que acabo de comprar y voy a la web de descargas de [Windows 7 de Microsoft][8]. Al verificar el número de serie recibido me encuentro con lo siguiente.

![Win7Pro][9]

Upsss¡¡¡ Problemas? Espero que no me hayan timado y que este error sólo sea debido a que este servicio de descargas de Microsoft no es válido para licencias OEM con las que los fabricantes dotan de Windows a los ordenadores que venden. Con esto, el siguiente paso es ir al enlade de Mega que he recivido en el correo electrónico y descargar la ISO.

### Tengo la ISO, pero no tengo Cd's

Hace una década, raro era el día que no tenía en casa más de cincuenta cd's o dvd's "vírgenes" para grabar contenido, pero ahora... todo ha cambiado y hace mucho tiempo que ni compro ni utilizo estos soportes físicos. Una vez más toca utilizar [Rufus][10] para crear un Usb de arranque donde grabaré la imagen de Windows 7 Pro que he descargado.

![Win7Pro][11]

### Ya está Windows instalado

El proceso de instalación es coser y cantar, selecciono el usb como primer sistema de arranque, introduzco el número de serie y sólo resta tener un poco de paciencia con las actualizaciones. Como resultado, un pc de casi ocho años que, gracias a un disco ssd y la instalación limpia de windows 7 es capaz de arrancar el sistema en apenas 20 segundos. Se acabó la pereza por encender el ordenador.

 [1]: /images/20180419_win7_amazon_01.jpg
 [2]: /images/20180419_win7_amazon_02.jpg
 [3]: /images/20180419_win7_ebay_01.jpg
 [4]: http://www.vidasenred.com/
 [5]: /images/20180419_win7_ebay_02.jpg
 [6]: https://www.ebay.es/itm/Microsoft-Windows-7-Professional-32-64-ESD-Multilanguage-Original-License-Key/263335278671?hash=item3d5001784f:g:~y4AAOSwXrdaEzgJ
 [7]: /images/20180419_win7_correo_01.jpg
 [8]: https://www.microsoft.com/es-es/software-download/windows7
 [9]: /images/20180419_win7_error_01.jpg
 [10]: https://rufus.akeo.ie/?locale
 [11]: /images/20180419_win7_rufus_01.jpg
