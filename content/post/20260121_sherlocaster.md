---
title: "Sherlocaster"
date: "2026-04-08"
creation: "2026-01-21"
description: "Un podcst a partir de audios desdargados de Youtube y Twitch"
thumbnail: "images/20260121_sherlocaster_00.jpg"
disable_comments: true
authorbox: false
toc: false
mathjax: false
categories:
- "computing"
tags:
- "python"
draft: true
weight: 5
---
Resumen de introducción es...
<!--more-->
# 🛠️ Cómo funciona Sherlocaster por dentro: anatomía de una utilidad que convierte canales de vídeo en podcasts

Cuando creé **Sherlocaster**, mi objetivo fue resolver un problema que cada vez es más común: **seguir contenido audiovisual como si fuera audio**, sin necesidad de depender de pantallas ni interfaces pesadas. El truco está en automatizar **la extracción, conversión y publicación de audio** a partir de vídeos de YouTube o Twitch.

Aunque Sherlocaster todavía está en fases iniciales y sin integraciones complejas, su **estructura modular** y su base tecnológica permiten una comprensión bastante clara de cómo puede funcionar este tipo de herramienta y qué componentes intervienen en el proceso.

---

## 📁 Arquitectura del proyecto: visión general

En su forma más básica, Sherlocaster está organizado en los siguientes elementos principales:

- `config.yaml` — Configuración del usuario
- `app/` — Lógica de aplicación
- `data/` — Datos auxiliares o temporales
- `Dockerfile` y `docker-compose.yaml` — Despliegue
- `requirements.txt` — Dependencias

Esta separación ya nos da pistas sobre el diseño: una herramienta pensada para ser modular, adaptable y fácil de implementar en cualquier entorno —desde tu máquina personal hasta un servidor doméstico o la nube.

---

## 🎯 1. Configuración: cerebro de la personalización

El archivo `config.yaml` es vital porque define la **lista de canales** y cómo deben procesarse. Aquí se puede definir:

- URLs o identificadores de canales
- Formatos preferidos de audio
- Frecuencia de actualización
- Opciones de conversión

Este enfoque es excelente porque permite extender la herramienta sin tocar código, únicamente editando la configuración, lo cual evita errores y facilita automatizar instalaciones.

---

## 2. Lógica de la aplicación: cómo se transforma cada canal

El corazón de Sherlocaster vive en la carpeta `app/`, donde está la lógica de procesamiento.

Aunque los detalles técnicos pueden evolucionar, el flujo típico es:

### 🟡 Paso 1: Lectura de configuración

Sherlocaster arranca leyendo `config.yaml` y construyendo una lista de canales a procesar. Aquí se valida que todos los enlaces pertenezcan a plataformas soportadas.

### 🟡 Paso 2: Extracción de metadatos

Antes de convertir vídeo en audio, la app necesita obtener datos como:

- Fecha de publicación
- Duración
- Título y descripción
- URL del vídeo

Esto se hace usando APIs oficiales o extracción auxiliar (por ejemplo, con `yt-dlp`).

### 🟡 Paso 3: Generación de enlaces de audio

En lugar de descargar el vídeo completo, la herramienta puede extraer solo el audio o generar un enlace directo al flujo de audio cuando la plataforma lo permite.

Esto reduce:

- Consumo de ancho de banda
- Coste de almacenamiento
- Tiempo de procesamiento

### 🟡 Paso 4: Construcción del feed de podcast

Este es el núcleo de cualquier solución de este tipo: generar un feed RSS en formato compatible con aplicaciones de podcast.

El feed RSS contiene episodios con metadatos como:

- `<title>`
- `<enclosure>` (enlace al audio)
- `<pubDate>`
- `<description>`

Al final, lo que el usuario ve no es “vídeo convertido”, sino **un podcast más en su aplicación favorita**.

---

## 📡 3. Docker y despliegue: listo para producción

Sherlocaster incluye soporte para contenedores mediante:

- `Dockerfile`
- `docker-compose.yaml`

Esto ofrece ventajas como:

✔ Entornos reproducibles  
✔ Aislamiento completo  
✔ Sin dependencias locales  
✔ Despliegue fácil en:

- Raspberry Pi
- VPS
- NAS
- Nube

Si has trabajado con self-hosting, esto es un regalo: basta un `docker-compose up -d` para tener el servicio funcionando.

---

## 🕒 4. Actualización y refresco de episodios

Para que el podcast esté siempre actualizado, la herramienta puede ejecutarse en modo:

### 🔹 Manual

Ejecutando el script cuando se quiera actualizar.

### 🔹 Programado (cron)

Muy común en servidores caseros o VPS:



![image-01]

### Enlaces de interés
- [enlace](www.sherblog.pro)

[link]: https://www.google.es

[image-01]: /images/20260121_sherlocaster_01.jpg



