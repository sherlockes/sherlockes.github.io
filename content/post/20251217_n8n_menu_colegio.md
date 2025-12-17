---
title: "Automatizando el menú escolar con n8n"
date: "2025-12-17"
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
draft: true
weight: 5
---
En muchos colegios el menú mensual se publica en un PDF que acaba olvidado en una web, en un correo o en el grupo de WhatsApp de las familias. Consultarlo cada mañana es poco práctico, y automatizarlo no es trivial. De esta forma he conseguido convertirlo en una notificación diaria a Telegram
<!--more-->

En este artículo explico cómo he construido un **flujo completo en n8n** que resuelve este problema de principio a fin:

- Recibe el **PDF mensual del menú**
- Extrae la información usando **visión artificial**
- La guarda de forma estructurada en **Google Sheets**
- Y **envía cada día automáticamente el menú por Telegram**

Todo ello con un único workflow bien organizado.

---

## El problema: PDFs no estructurados
El menú del colegio llega como un PDF mensual. Aunque visualmente es claro para una persona, para una automatización tiene varios problemas:

- No sigue un formato de tabla estándar
- Mezcla texto, días, festivos y notas
- No se puede parsear de forma fiable con expresiones regulares

Tras probar soluciones clásicas como `pdftotext`, quedó claro que el parseo iba a ser frágil. La solución fue **tratar el PDF como una imagen** y delegar la interpretación a un modelo de inteligencia artificial con capacidades de visión.

## Arquitectura general del flujo
El workflow se divide en **dos grandes ramas**, cada una con su propio disparador:

1. **Importación mensual (Webhook)**
2. **Envío diario automático (Cron + Arranque)**

Ambas ramas comparten el mismo almacenamiento: una hoja de cálculo en Google Sheets llamada `menu_colegio`.

## Parte 1: Importación mensual del menú

### 1. Recepción del PDF por Webhook
El flujo comienza con un **Webhook** que recibe el archivo PDF. Para evitar errores, se valida que el nombre siga el patrón `YYYYMM.pdf`. De este nombre se extraen directamente el **año y el mes**, que luego se usarán para contextualizar el análisis.

Esto permite subir simplemente archivos del tipo 202512.pdf sin necesidad de más metadatos.

### 2. Conversión del PDF a imagen

El PDF se guarda temporalmente en disco y se convierte a PNG usando `pdftoppm`. Este paso es clave: los modelos de visión trabajan mucho mejor con imágenes que con texto mal estructurado. Se genera la primera página del menú como imagen, que suele contener toda la información relevante.

### 3. Análisis del menú con IA (Vision)

La imagen se envía a **OpenRouter**, utilizando el modelo `gpt-4o-mini`, junto con un prompt muy estricto:

- El modelo debe devolver **únicamente JSON**
- Cada elemento debe contener:
  - `date` en formato `YYYY-MM-DD`
  - `menu` como texto plano
- Festivos y vacaciones deben indicarse explícitamente

El resultado es un bloque JSON encapsulado en Markdown, que se limpia y parsea en un nodo de código.

El flujo transforma así un PDF visual en **datos estructurados y fiables**.

### 4. Guardado en Google Sheets

Cada día del mes se guarda como una fila en Google Sheets con dos columnas principales:

- `Fecha`
- `Menu`

Si una fecha ya existe, se actualiza; si no, se inserta. De esta forma, subir de nuevo el PDF no rompe nada y el sistema es idempotente.

## Parte 2: Envío diario automático por Telegram

Una vez los datos están estructurados, el problema se reduce a algo mucho más sencillo.

### 1. Disparadores: Cron y Arranque

El envío diario se activa de dos formas:

- Un **Schedule Trigger** todos los días a las 8:00
- Un **Trigger de Arranque**, por si el servidor no estaba encendido a esa hora

Ambos disparadores confluyen en el mismo flujo.

### 2. Cálculo de la fecha actual

Un nodo `Set` genera la variable `hoy` con la fecha actual en formato `YYYY-MM-DD`. Este formato coincide exactamente con el almacenado en Google Sheets, evitando conversiones innecesarias.

### 3. Búsqueda del menú del día

Se consulta Google Sheets filtrando únicamente por la fecha de hoy. Esto devuelve, como máximo, una fila.

A partir de aquí, toda la lógica se hace **dentro de n8n**, no en el filtro de Google Sheets, lo que evita problemas con celdas vacías.

### 4. Evitar envíos duplicados

Para garantizar que el mensaje se envía **una sola vez al día**, se añadió una tercera columna en la hoja:

- `Enviado`

Un nodo IF comprueba:

- Que exista una fila para hoy
- Que la columna `Enviado` esté vacía

Solo en ese caso se continúa.

Tras enviar el mensaje por Telegram, la fila se actualiza marcando `Enviado` con la fecha, lo que hace el sistema **completamente robusto frente a reinicios**.

### 5. Envío del mensaje por Telegram

El mensaje enviado es simple y directo:

``` txt
Menú en el colegio para hoy:
<contenido del menú>
```

Este paso podría ampliarse fácilmente con emojis, formatos distintos para festivos o incluso botones interactivos.

## Ventajas de este enfoque

Este diseño tiene varias ventajas claras:
- No depende de servicios externos adicionales
- Es fácil de depurar (todo queda visible en Sheets)
- No requiere estado interno complejo
- Funciona igual en pruebas y en producción
- Tolera reinicios del servidor sin duplicar mensajes

Además, el uso de visión artificial evita uno de los problemas clásicos de la automatización: **intentar forzar a los PDFs a ser algo que no son**.

## Conclusión

Este workflow demuestra cómo n8n puede actuar como **pegamento entre IA, automatización y herramientas cotidianas**. Con unas pocas decisiones bien pensadas, un documento pensado para humanos se convierte en un sistema automático, fiable y mantenible.

Y lo mejor: una vez montado, **nadie tiene que volver a preguntarse qué comen hoy los niños en el cole**. 🍽️




![image-01]

### Enlaces de interés
- [enlace](www.sherblog.es)

[link]: https://www.google.es

[image-01]: /images/20251217_n8n_menu_colegio_01.jpg



