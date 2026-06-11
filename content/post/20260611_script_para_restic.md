---
title: "Script para Restic"
date: "2026-06-11"
creation: "2026-06-11"
description: "He creado Script para Restic para compartir mis opiniones y conocimientos."
thumbnail: "images/20260611_script_para_restic_00.jpg"
disable_comments: true
authorbox: false
toc: false
mathjax: false
categories:
- "computing"
- "sherver"
tags:
- "rclone"
- "restic"
- "bash"
draft: true
weight: 5
---

Hace unos meses escribí un artículo para realizar la copia de seguridad de mis contenedores con [Restic]. Ahora retomo el tema dándole una vuelta de tuerca al script inicial para añadirle una cuantas mejoras:

<!--more-->

Aquí dejo el [script] que he mejorado con la ayuda de la IA.

### Modularidad y Soporte Multi-configuración

__Antes__: El script original tenía las rutas (~/dockers), los repositorios y las contraseñas escritas directamente "a fuego" (hardcoded) en el código. Si querías respaldar otra carpeta u otra nube, tenías que duplicar el script entero.

__Ahora__: El script actúa como una plantilla genérica. Acepta un archivo de configuración externo como argumento ($1). Si no se le pasa ninguno, usa uno por defecto gracias a la línea:

`CONFIG_FILE="${1:-$HOME/.restic-backup}"`

>Esta característica te permite gestionar infinitas copias de seguridad distintas utilizando un único script ejecutable sin más que apuntar a un archivo de configuración distinto.

---

### Seguridad Mejorada (Adiós a los archivos de clave secundarios)
**Antes:** El script original requería gestionar dos archivos externos: el script en sí y un archivo `.restic-password` que contenía la contraseña en texto plano, obligando a Restic a leer el disco con el argumento `--password-file`.

**Ahora:** Toda la configuración se centraliza en un único lugar. La contraseña se almacena como una variable dentro del archivo `.restic-backup` y se inyecta directamente en la memoria del sistema mediante el uso nativo de la variable de entorno de Restic:

```bash
export RESTIC_PASSWORD="$RESTIC_PASSWORD"
```

----

### Portabilidad Total con la variable $HOME
**Antes:** El script original utilizaba rutas absolutas estáticas que apuntaban explícitamente a /home/sherlockes/. Si clonabas el script en otro servidor con un usuario diferente, el script fallaba de inmediato.

**Ahora:** Al implementar $HOME, el script se adapta automáticamente al directorio del usuario que lo esté ejecutando, facilitando enormemente que los lectores de tu blog puedan descargar tu script y usarlo en sus sistemas sin editar una sola línea de código.

---

### Red de Seguridad: Inicialización Automática

**Antes:** Si el repositorio remoto en la nube de Mega no estaba inicializado previamente con el comando manual init, el script original fallaba catastróficamente lanzando un error y deteniendo el proceso.

**Ahora:** El script incluye una rutina de comprobación inteligente en segundo plano:

``` bash
sudo -E restic -r "$REPO_REMOTE" snapshots > /dev/null 2>&1
```

Si detecta que el repositorio en la nube no existe o no es accesible, **lo inicializa de forma automática**, asegurando que la tarea no falle.

---

### Sistema de Alertas y Notificaciones

**Antes:** El script original era completamente "silencioso". Si el backup fallaba por falta de espacio, caída de red o errores de permisos, no te enterabas a menos que leyeses manualmente el archivo `backup.log`.

**Ahora:** Se integra una función nativa de telemetría por **Telegram** que envía alertas críticas inmediatas si ocurre un error en el backup o en las políticas de retención, así como un mensaje de confirmación verde (`🟢`) cuando todo concluye con éxito.

---

### Estrategia de Backup Híbrida (Local + Remoto)

**Antes:** El script original únicamente realizaba la copia de seguridad hacia el almacenamiento remoto en la nube de Mega.

**Ahora:** Aplica la regla de respaldo profesional (3-2-1), realizando primero la validación y copia en un repositorio **Local** (para recuperaciones instantáneas a gran velocidad) y posteriormente replicando el proceso hacia el repositorio **Remoto** en Mega (protección ante desastres físicos en el servidor).

---

### El problema del sudo

No he sido capaz de eliminar la necesidad de root para llamar al comando restic así que tenemos que seguir añadiendo una línea en `sudo visudo` que será la siguiente:

``` bash
sherlockes ALL=(ALL) NOPASSWD:SETENV: /usr/bin/restic
```
### Script completo
{{< texto_remoto "https://raw.githubusercontent.com/sherlockes/SherloScripts/refs/heads/master/bash/restic-backup.sh" >}}


[Restic]: https://restic.net
[script]: https://github.com/sherlockes/SherloScripts/blob/master/bash/restic-backup.sh

