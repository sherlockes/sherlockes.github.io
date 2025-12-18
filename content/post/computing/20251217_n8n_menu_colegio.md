---
title: "Automatizando el menú escolar con n8n"
date: "2025-12-18"
creation: "2025-12-17"
description: "Como he pasado de un pdf a una notificación diaria en Telegram para saber el menú de los niños en el colegio."
thumbnail: "images/20251217_n8n_menu_colegio_00.jpg"
disable_comments: true
authorbox: false
toc: true
mathjax: false
categories:
- "computing"
tags:
- "google sheets"
- "n8n"
- "telegram"
draft: false
weight: 5
---
En muchos colegios el menú mensual se publica en un PDF que acaba olvidado en una web, en un correo o en el grupo de WhatsApp de las familias. Consultarlo cada mañana es poco práctico, y automatizarlo no es trivial. De esta forma he conseguido convertirlo en una notificación diaria a Telegram
<!--more-->

En este artículo explico cómo he construido un **flujo completo en n8n** que resuelve este problema de principio a fin:

Una de esas pequeñas automatizaciones que, sin ser especialmente complejas, terminan teniendo un impacto real en el día a día. En este caso, el objetivo es sencillo: **tener el menú del colegio disponible y recibir cada mañana un aviso automático con lo que toca comer**.

## Qué hace este flujo

El flujo cubre todo el ciclo de vida del menú mensual:

- Detecta la llegada de un nuevo PDF con el menú.
- Extrae la información diaria usando IA.
- Guarda los menús en una hoja de Google Sheets.
- Cada mañana, comprueba si hay menú para hoy.
- Si lo hay y no es festivo, envía un mensaje por Telegram.
- Marca el menú como enviado para no repetir avisos.

Todo esto sin intervención manual una vez configurado.

{{< n8n_workflow src="/workflows/menu_miraflores" >}}

## Entrada del menú: PDF y automatización

El flujo admite dos formas de entrada del PDF del menú:

1. **Webhook** al que se puede subir el archivo manualmente.
2. **Google Drive Trigger**, que vigila una carpeta concreta y se activa cuando aparece un nuevo PDF.

El nombre del archivo no es casual: sigue el formato `YYYYMM.pdf`, lo que permite extraer automáticamente el año y el mes. Si el nombre no cumple el patrón esperado, el flujo simplemente no continúa.

Este pequeño detalle evita muchos errores aguas abajo.

## De PDF a imagen (porque la IA ve mejor así)

Una vez recibido el PDF, se guarda temporalmente y se convierte en imagen usando `pdftoppm`.  
El menú suele estar en una sola página, así que se trabaja directamente con la primera imagen generada.

¿Por qué imagen y no texto? Porque el siguiente paso es clave.

## Interpretando el menú con IA

Aquí entra en juego un modelo de lenguaje con capacidad multimodal. Se le pasa:

- El mes y año deducidos del nombre del archivo.
- La imagen del menú.
- Una instrucción muy concreta: devolver **exclusivamente un array JSON**, con una entrada por día lectivo y el menú estructurado en tres líneas (primero, segundo y postre).

Los días marcados como festivos o vacaciones directamente se ignoran.

El resultado se parsea y se transforma para que n8n trabaje con una fila por día.

## Persistencia: Google Sheets como base de datos

Cada día del menú se guarda (o actualiza) en una hoja de cálculo de Google Sheets usando la fecha como clave única.

Esto tiene varias ventajas:

- Es fácil de revisar manualmente.
- Permite correcciones rápidas si algo falla.
- Sirve como histórico del menú.

Además, se añade una columna para marcar si el menú diario ya ha sido enviado por Telegram.

## El envío diario: lógica antes de notificar

Cada mañana a las 8:00 el flujo se activa automáticamente y sigue varios pasos antes de enviar nada:

1. Comprueba qué día es hoy.
2. Verifica que sea día lectivo (lunes a viernes).
3. Consulta un calendario de Google con los festivos escolares.
4. Busca el menú correspondiente en la hoja de cálculo.
5. Comprueba que no se haya enviado ya.

Solo si todas esas condiciones se cumplen, se envía el mensaje.

Si no hay menú cargado para ese día, se manda un aviso alternativo indicando que falta el menú mensual.

## Telegram como canal de salida

El mensaje final es simple y directo:

> Menú en el colegio para hoy:  
> (contenido del menú)

Sin formatos raros ni florituras. Lo importante es que llegue rápido y sea legible desde el móvil.

Una vez enviado, el menú se marca como “enviado” en Google Sheets, cerrando el ciclo.

## Conclusión

No es una automatización compleja ni especialmente original, pero sí muy representativa de lo que me gusta hacer con n8n:

- Resolver problemas cotidianos.
- Eliminar tareas repetitivas.
- Aprovechar la IA donde realmente aporta valor.
- Usar herramientas simples (Sheets, Telegram) como piezas clave del sistema.

Y, sobre todo, **olvidarme del problema una vez montado**. Que al final de eso va todo esto.


