---
title: "Pidiendo ayuda Auto +"
date: "2026-10-28"
creation: "2026-10-28"
description: "He creado Pidiendo ayuda Auto + para compartir mis opiniones y conocimientos."
thumbnail: "images/20261028_pidiendo_ayuda_auto_00.jpg"
disable_comments: true
authorbox: false
toc: false
mathjax: false
categories:
- "computing"
tags:
- "google drive"
draft: true
weight: 5
---

En el concesionario donde me compré el nuevo coche me pidieron 185€ para gestionar la solicitud de la ayuda Auto +. Motivo más que suficiente para intentarlo por mis propios médios.

<!--more-->

Lo primero que intento es pedir ayuda a [Gemini] pero el fracaso es absoluto ya que me remite a planes antiguos de ayudas que ya se han cerrado. Mediante la búsqueda tradicional doy con el programa de ayudas [Auto +] dentro del portal de ayudas del gobierno de españa.

Había oído que para solicitar la ayuda se podía hacer mediante el uso de la Cl@ve Pin de igual forma que la declaración de la renta pero al intentar acceder al procedimiento veo que es necesario un certificado digital. Si lo intentas sin uno el resultado es el siguiente.

![image-01]

Por supuesto no tengo el certificado digital así que me veo en la tesitura de tener que solicitarlo. Hay varias alternativas, pero la más sencilla parece mediante la app de la [FNMT] para la obtención de certificados digitales.

![image-02]

Con la app descargada, pongo el dni encima de la mesa, le paso con cuidado el teléfono con el nfc activado suavemente por encima, lo detecta y.... me dice que los certificados están caducados y que es necesario renovarlos.

Por suerte, tengo una comisaria cerca y para renovar los certificados no es necesario pedir cita ya que se puede hacer desde la máquina kiosko que tienen fuera.

![image-03]

Es rápido y sencillo, pones el DNI, pones el dedo y le das a renovar los certificados.

> Si no te acuerdas del PIN (Mas que probable por que el que te dan con la expedición es complicado de recordar) te tocará antes de renovar los certificados cambiar la contraseña.

En cinco minutos está listo y puedes aprovechar para poner dentro del dni tú número de teléfono para poder activar la app miDNI y poder dejar el documento en casa.

Con los certificados del DNI válidos podemos volver a la App de la [FNMT] y crear un certificado válido.

> La aplicación no ofrece la posibilidad de exportarlo pero si instalas el certificado en el teléfono se guarda una copia del mismo en la carpeta descargas del teléfono. De ahí lo coges y te lo llevas al pc.

En el navegador del pc (Yo uso Vivaldi en Linux Mint) tienes que importar los certificados en la url [chrome://settings/certificates]

![image-04]

Y desde aquí al apartado "Tus certificados" e importar. Seleccionamos el archivo del certificado, introducimos la contraseña que hayamos puesto en la app de la [FNMT] y ya nos aparece el certificado instalado.

![image-05]

Parece que esta va a ser la buena. Ya podemos entrar en la solicitud de ayuda y rellenar toda la info que se requiere.

Pero no es oro todo lo que reluce, después de rellenar toda la solicitud y adjuntar los documentos necesarios le das a enviar y te da un error de autofirma. En ningún sitio te dice, o yo no lo he visto, que es eso de autofirma así que toca volver a buscar más información.

> [AutoFirma] es una aplicación de escritorio desarrollada por el Ministerio de Asuntos Económicos y Transformación Digital (a través de la Secretaría de Estado de Digitalización e Inteligencia Artificial) del Gobierno de España. Su función principal es permitir la firma electrónica de documentos (PDF, XML, etc.) de manera local en tu ordenador durante la realización de trámites administrativos con la Administración Pública a través de internet.

Con esto no resulta muy difícil dar con el sitio para [descargarla] y además estamos de suerte ya que tiene versión para linux.

Instalamos [Autofirma] y cual es mi sorpresa al ver que tengo que volver a rellenar toda la solicitud y adjuntar los documentos pero esta vez va a ser la definitiva ya que con esto la solicitud se ha procesado correctamente.

Veremos si llega la pasta...

[link]: https://www.google.es
[Gemini]: https://gemini.google.com
[Auto +]: https://www.mintur.gob.es/portalayudas/programa-auto/Paginas/Index.aspx
[FNMT]: https://play.google.com/store/apps/details?id=es.fnmtrcm.ceres.certificadoDigitalFNMT&hl=es-419
[chrome://settings/certificates]: https://chrome://settings/certificates
[descargarla]: https://firmaelectronica.gob.es/descargas
[Autofirma]: https://sede.serviciosmin.gob.es/ES-ES/FIRMAELECTRONICA/Paginas/AutoFirma.aspx

[image-01]: /images/20261028_pidiendo_ayuda_auto_01.jpg
[image-02]: /images/20261028_pidiendo_ayuda_auto_02.jpg
[image-03]: /images/20261028_pidiendo_ayuda_auto_03.jpg
[image-04]: /images/20261028_pidiendo_ayuda_auto_04.jpg
[image-05]: /images/20261028_pidiendo_ayuda_auto_05.jpg
