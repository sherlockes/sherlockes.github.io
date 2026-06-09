---
title: "Sincronizar configuración SSH en linux"
date: "2026-06-09"
creation: "2026-06-09"
description: "He creado Sincronizar configuración SSH en linux para compartir mis opiniones y conocimientos."
thumbnail: "images/20260609_sincronizar_configuracion_ssh_en_linux_00.jpg"
disable_comments: true
authorbox: false
toc: false
mathjax: false
categories:
- "computing"
tags:
- "linux"
- "ssh"
- "github"
- "bash"
draft: true
weight: 5
---

Sincronizando configuración de ssh en linux gracias a un repositorio privado de github.

<!--more-->

Tengo un repo privado en [GitHub] en el que tengo guardado al archivo de configuración de ssh de linux "~/.ssh/config" con todos los host de mi red para de esta forma poder sincronizarlo entre todos los equipos.

El principal problema es como realizar los push al repo una vez que este se haya modificado en alguna máquina

¿Y si el propio sistema se encargara de revisar el estado del repositorio, guardar tus cambios locales de forma automática y decidir si toca descargar o subir información? 

El Desafío: Actualizar el repo local o remoto


## La Herramienta: El Script [gitsync.sh]

Este script acepta la ruta del repositorio como argumento (usando el directorio actual por defecto) y maneja toda la lógica de forma segura, incluyendo una comprobación previa de la conexión SSH con GitHub.

``` bash
#!/bin/bash

# Configuración por defecto de Git
REMOTE_NAME="origin"
BRANCH_NAME="main"

# 1. Capturar la ruta del repositorio
REPO_DIR="${1:-.}"
REPO_DIR=$(cd "$REPO_DIR" 2>/dev/null && pwd)

if [ -z "$REPO_DIR" ]; then
    echo "❌ Error: El directorio especificado no existe."
    exit 1
fi

cd "$REPO_DIR" || exit 1
echo "📂 Trabajando en el repositorio: $REPO_DIR"

# 2. Comprobar si realmente es un repositorio de Git
if ! git rev-parse --is-inside-work-tree > /dev/null 2>&1; then
    echo "❌ Error: '$REPO_DIR' no es un repositorio de Git válido."
    exit 1
fi

# 3. AUTO-COMMIT: ¿Hay cambios locales en los archivos?
if [ -n "$(git status --porcelain)" ]; then
    echo "📝 Se han detectado cambios locales sin commitear. Creando commit automático..."
    git add -A
    git commit -m "Update"
else
    echo "✨ No hay cambios locales pendientes de commit."
fi

# 4. Verificar la conexión SSH con GitHub
echo "🔄 Comprobando conexión SSH con GitHub..."
ssh -T git@github.com -o ConnectTimeout=5 > /dev/null 2>&1
if [ $? -eq 255 ]; then
    echo "❌ Error: No se pudo establecer conexión SSH con GitHub."
    exit 1
fi

# 5. Traer las últimas referencias del remoto
echo "🔄 Descargando últimas referencias de '$REMOTE_NAME'..."
git fetch $REMOTE_NAME 2>/dev/null

# 6. Obtener los hashes de los commits para la comparación
LOCAL=$(git rev-parse @ 2>/dev/null)
REMOTE=$(git rev-parse "$REMOTE_NAME/$BRANCH_NAME" 2>/dev/null)
BASE=$(git merge-base @ "$REMOTE_NAME/$BRANCH_NAME" 2>/dev/null)

if [ -z "$REMOTE" ]; then
    echo "❌ Error: No se pudo encontrar la rama '$BRANCH_NAME' en el remoto '$REMOTE_NAME'."
    exit 1
fi

echo "---"
echo "💻 Local:  ${LOCAL:0:7}"
echo "🌐 Remoto: ${REMOTE:0:7}"
echo "---"

# 7. Lógica de comparación de historial y acción
if [ "$LOCAL" = "$REMOTE" ]; then
    echo "✅ Todo actualizado. Sin cambios pendientes."
    
elif [ "$LOCAL" = "$BASE" ]; then
    echo "⬇️ El remoto tiene cambios nuevos. Haciendo PULL..."
    git pull $REMOTE_NAME $BRANCH_NAME

elif [ "$REMOTE" = "$BASE" ]; then
    echo "⬆️ Tienes cambios locales nuevos. Haciendo PUSH..."
    git push $REMOTE_NAME $BRANCH_NAME

else
    echo "⚠️ ¡Alerta! Las ramas han divergido de forma manual."
    echo "Revisa el estado con 'git status'."
    exit 1
fi
```

## Despliegue global mediante Enlaces Simbólicos

Para poder usar este script desde cualquier lugar del sistema sin duplicar el código, lo ideal es mantener el archivo original centralizado (por ejemplo, en una carpeta de herramientas personales) y crear un enlace simbólico en el `$PATH` del sistema:

``` bash
sudo ln -s "$PWD/git-sync.sh" /usr/local/bin/gitsync
```

A partir de este momento, el comando `gitsync` está disponible globalmente en la terminal.

---

## El Toque Final: Automatización Invisible con Cron

Tener el comando simplificado está bien, pero el objetivo real es olvidarse de él. Queremos que se ejecute **en cada arranque del sistema** y **cada dos horas**. Para ello recurrimos al `crontab` de Linux (`crontab -e`).

Aquí es donde la mayoría de los intentos de automatización de Git fallan. `cron` ejecuta las tareas en un entorno ultra-restringido; no carga tu entorno gráfico, ni tu terminal habitual, por lo que **no tiene acceso a tus llaves SSH**. Si lanzas el script a secas, la conexión con GitHub fallará por falta de autenticación.

Para solucionarlo, forzamos a `cron` a cargar el entorno del usuario (`.bashrc`) antes de ejecutar el comando, y redirigimos el resultado a un archivo de registro que se sobrescribirá en cada ejecución para controlar el espacio en disco:

```cron
@reboot . $HOME/.bashrc; /usr/local/bin/gitsync $HOME/dotfiles > $HOME/.gitsync.log 2>&1
0 */2 * * * . $HOME/.bashrc; /usr/local/bin/gitsync $HOME/dotfiles > $HOME/.gitsync.log 2>&1
```

### Desglose de la configuración:
* **`@reboot` y `0 */2 * * *`**: Aseguran la ejecución al encender el equipo y exactamente cada dos horas (12:00, 14:00...).
* **`. $HOME/.bashrc;`**: Carga el agente SSH y las variables necesarias para que la llave privada funcione de manera transparente.
* **`>` y `2>&1`**: El operador `>` limpia el archivo `~/.gitsync.log` y guarda únicamente la salida de la última ejecución (tanto los mensajes normales como los errores), evitando que el disco se llene con logs infinitos.



### Enlaces de interés
- [enlace](www.sherblog.es)

[GitHub]: https://github.com/sherlockes
[gitsync.sh]: https://github.com/sherlockes/SherloScripts/blob/master/bash/gitsync.sh
