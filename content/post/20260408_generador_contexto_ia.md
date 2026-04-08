---
title: "Generador de contexto para IA"
date: "2026-04-08"
creation: "2026-04-08"
description: "Si usas la IA para programar, es imprescindible el uso de un generador de contexto. Este es el mío."
thumbnail: "images/20260408_generador_contexto_ia_00.jpg"
disable_comments: true
authorbox: false
toc: false
mathjax: false
categories:
- "computing"
tags: 
- "bash"
- "linux"
draft: true
weight: 5
---
El "vibe coding" se trata de mantener el flujo creativo y dejar que la IA se encargue de la carpintería pesada. Podemos definir este `context-engine.sh` como un "acelerador de partículas" para ese flujo.
<!--more-->

Aquí tienes cinco razones para utilizar mi generador de contexto para IA.

 1. Establece una "Personalidad de Élite" al instante. El script no solo lanza código; inyecta un System Prompt profesional al principio del archivo. Al definir a la IA como un "Experto desarrollador Full Stack y arquitecto de software", te aseguras de que las respuestas tengan el nivel técnico que esperas, ahorrándote el tiempo de redactar esas instrucciones manualmente en cada sesión.
 
 2. Filtro de "Ruido" InteligenteEn el vibe coding, saturar el contexto con basura es el enemigo número uno. Tu generador es quirúrgico:Excluye automáticamente carpetas pesadas como node_modules o .git. Detecta y omite archivos binarios (imágenes, ejecutables) mediante el tipo MIME.Esto garantiza que cada token que pagas (o consumes de tu cuota) sea puro valor informativo.
 
 3. El "Mapa antes que el Territorio" Gracias a la integración del comando tree (o find como respaldo), la IA recibe primero la estructura completa del proyecto. Esto es vital para que el modelo comprenda la jerarquía de carpetas y las dependencias antes de leer una sola línea de lógica, evitando que sugiera soluciones que rompan tu arquitectura actual.
 
 4. Gestión de Archivos Gigantes. Nada rompe más el "vibe" que un error de límite de tokens. El script incluye un mecanismo de seguridad que detecta archivos de más de 100KB y los trunca a las primeras 100 líneas. Esto te permite incluir logs o archivos de datos grandes sin miedo a que "ceguen" a la IA o bloqueen el procesamiento.
 
 5. Fricción Cero con el PortapapelesLa verdadera magia del flujo de trabajo está al final del script: la detección automática del sistema operativo (macOS, Linux o Windows/WSL) para copiar el resultado directamente al portapapeles.Terminas de escribir una función $\rightarrow$ Ejecutas el script $\rightarrow$ Ctrl+V en la IA.Sin abrir archivos intermedios, sin seleccionar texto manualmente. Es velocidad pura.

![image-01]

### Enlaces de interés
- [enlace](www.sherblog.es)

[link]: https://www.google.es

[image-01]: /images/20260408_generador_contexto_ia_01.jpg


