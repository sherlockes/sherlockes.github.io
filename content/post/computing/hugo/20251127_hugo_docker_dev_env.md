---
title: "Entorno de desarrollo de Hugo en Docker"
date: "2025-11-30"
creation: "2025-11-27"
description: "Un contenedor que he creado para que las pruebas que hago en Hugo no sean en el entorno de producción"
thumbnail: "images/20251127_hugo_docker_dev_env_00.jpg"
disable_comments: true
authorbox: false
toc: false
mathjax: false
categories:
- "hugo"
tags:
- "docker"
- "hugo"
- "emacs"
- "github"
draft: false
weight: 5
---
Hace años que tengo mi blog de Hugo desplegado desde GitHub usando GitHub Actions, pero todavía no tenía un entorno de desarrollo cómodo y aislado donde trastear sin miedo a romper nada. Aquí cuento cómo he montado un **entorno de desarrollo efímero con Docker** en mi servidor casero.
<!--more-->
Estas van a ser las características del entorno de desarrollo:
- Usa la **misma versión de Hugo Extended** que utilizo en GitHub Actions (en mi caso, `0.152.0`).
- Clona automáticamente el repositorio del blog desde GitHub al arrancar.
- Limpia el estado del repositorio cada vez que se levanta el contenedor (no guarda cambios locales).
- Me permite editar los archivos desde Emacs como si fuesen locales.
- No deja “basura” permanente en el contenedor: si algo se rompe, paro y vuelvo a arrancar.

## 1. Estructura del entorno en el servidor

En mi servidor he creado un directorio específico para este entorno de desarrollo junto con una carpeta para el contenido del blog:

```bash
mkdir -p ~/dockers/hugo-dev
cd ~/dockers/hugo-dev
mkdir -p repo
sudo chown -R $USER:$USER repo
```

> El propietario de la carpeta donde va a alojarse el contenido del blog es importante que sea nuestro usuario y no "root" para que podamos modificarlo y hacer pruebas.


Dentro de esa carpeta tengo cuatro piezas clave:

- `Dockerfile` – Imagen personalizada con Hugo Extended 0.152.0.
- `start.sh` – Script de arranque del contenedor (clona/actualiza repo y lanza Hugo).
- `docker-compose.yml` – Orquestación del contenedor y volúmenes.
- `repo`- Contenido del blog clonado de Github
. `.env` - El usuario que va a editar los archivos del blog

El contenido de ".env" simplemente va a ser:
``` bash
UID=1000
GID=1000
```

Y así quedará la estructura de directorios y carpetas de nuestro proyecto.

```text
~/dockers/hugo-dev/
  ├── .env
  ├── Dockerfile
  ├── start.sh
  ├── docker-compose.yml
  └── repo/              # aquí queda clonado el blog
```

La gracia está en que el contenido de `repo/` se gestiona siempre desde Git dentro del contenedor, de forma que no acumulo estados raros: cada arranque empieza con un repositorio “limpio”.

---

## 2. Imagen de Docker con Hugo Extended 0.152.0

El repositorio `klakegg/hugo` dejó de actualizarse hace tiempo, así que no puedo depender de él para tener versiones recientes de Hugo. La solución ha sido crear mi **propia imagen basada en Alpine**, descargando directamente el binario oficial de Hugo Extended desde GitHub.

Este es el contenido completo de mi `Dockerfile`:

```Dockerfile
FROM alpine:3.19

# Dependencias necesarias para Hugo Extended y Git
RUN apk add --no-cache \
    curl \
    git \
    bash \
    libc6-compat \
    libstdc++ \
    ca-certificates

# Descargar Hugo Extended 0.152.0 desde GitHub
RUN curl -L -o /tmp/hugo.tar.gz \
    https://github.com/gohugoio/hugo/releases/download/v0.152.0/hugo_extended_0.152.0_linux-amd64.tar.gz \
    && tar -C /usr/local/bin -xzf /tmp/hugo.tar.gz hugo \
    && rm /tmp/hugo.tar.gz

# Directorio de trabajo dentro del contenedor
WORKDIR /site

# Al arrancar el contenedor se ejecutará start.sh
ENTRYPOINT ["/bin/bash", "/site/start.sh"]
```

Puntos importantes:

- Uso `alpine:3.19` como base: ligera y suficiente.
- Instalo `curl`, `git`, `bash` y las librerías necesarias para el binario estático de Hugo Extended.
- Descargo **la versión exacta** de Hugo Extended que uso en GitHub Actions (`0.152.0` en mi caso).
- Dejo `/usr/local/bin/hugo` disponible en el `PATH`.
- Defino `/site` como directorio de trabajo y delego la lógica de arranque en `start.sh`.

---

## 3. Script de arranque: clonar, limpiar y lanzar Hugo

El siguiente paso es preparar un script que se encargue de **dejar el repositorio en un estado conocido** cada vez que levanto el contenedor, y después arrancar el servidor de desarrollo de Hugo.

El archivo `start.sh` que estoy usando queda así:

```bash
#!/bin/bash
set -e

REPO_URL="https://github.com/sherlockes/sherlockes.github.io.git"
REPO_DIR="/site/repo"

echo "🧹 Borrando contenido anterior..."
rm -rf "${REPO_DIR:?}/"*
rm -rf "${REPO_DIR:?}/."* 2>/dev/null || true

echo "📥 Clonando repositorio..."
git clone "$REPO_URL" "$REPO_DIR"

echo "👤 Ajustando permisos..."
chown -R "$(id -u)":"$(id -g)" "$REPO_DIR"

cd "$REPO_DIR"

echo "🚀 Lanzando Hugo..."
hugo server -D --bind 0.0.0.0 --baseURL http://localhost:1313 --disableFastRender
```

Y en el host me aseguro de que es ejecutable:

```bash
chmod +x start.sh
```

¿Qué hace este script?

1. Define la URL del repositorio (`REPO_URL`) y el directorio donde debe clonar (`REPO_DIR`).
2. Borra cualquier resto de carpeta previa y clona desde cero.
3. Por último, arranca `hugo server -D`:
   - `-D` incluye borradores.
   - `--bind 0.0.0.0` lo hace accesible desde fuera del contenedor.
   - `--baseURL` se queda en `http://localhost:1313` para el entorno de desarrollo.
   - `--disableFastRender` para renderizar por completo la web ante un cambio

El comportamiento final es el que buscaba:

- Cada arranque del contenedor deja el repositorio **limpio y sincronizado** con GitHub.
- Cualquier cambio que haga en el entorno de desarrollo y **no suba a GitHub** se perderá al siguiente arranque, que es exactamente lo que quiero para un entorno de pruebas efímero.

---

## 4. docker-compose.yml: atando piezas y montando el volumen

Para simplificar el manejo del contenedor, utilizo Docker Compose. Este es el contenido completo de mi `docker-compose.yml` en `~/dockers/hugo-dev`:

```yaml
services:
  hugo-dev:
    build: .
    container_name: hugo-dev
    user: "${UID}:${GID}"
    ports:
      - "1313:1313"
    volumes:
      - ./repo:/site/repo
      - ./start.sh:/site/start.sh
    restart: no
```

Detalles clave:

- `build: .` indica que Compose debe construir la imagen usando el `Dockerfile` del directorio actual.
- `container_name: hugo-dev` me permite identificar y ejecutar comandos fácilmente contra el contenedor.
- `user: "${UID}:${GID}"` me permite trabajar sobre la carpeta creada por el usuario y cuyo id hemos guardado en el archivo ".env"
- Exponemos el puerto `1313` del contenedor al mismo puerto en el host: puedo abrir el navegador en `http://mi-servidor:1313` y ver el blog en modo desarrollo.
- El volumen `./repo:/site/repo` hace que la copia del blog quede en `~/dockers/hugo-dev/repo` en el servidor:
  - Puedo inspeccionar el repositorio desde el host.
  - Puedo editar los archivos con Emacs sin necesidad de entrar al contenedor.
- El volumen `./start.sh:/site/start.sh` monta el script de arranque directamente desde el host, de forma que cualquier cambio que haga al script se aplica automáticamente al siguiente arranque.

Con este `docker-compose.yml`, todo lo que tengo que hacer para arrancar el entorno es:

```bash
cd ~/dockers/hugo-dev
docker compose up --build
```

La opción `--build` solo es necesaria la primera vez (o cuando cambie el `Dockerfile`). A partir de entonces, normalmente basta con:

```bash
docker compose up
```

Si quiero parar el entorno:

```bash
docker compose down
```

El código del blog queda en `~/dockers/hugo-dev/repo`, pero el siguiente arranque del contenedor se encargará de limpiarlo y sincronizarlo con GitHub de nuevo.

---

## 5. Editar el blog desde Emacs

Una de las razones de montar el volumen `./repo:/site/repo` es poder editar cómodamente los archivos del blog desde Emacs (en mi caso, uso Emacs con el paquete `dashboard` para ver proyectos y archivos recientes).

Como la carpeta `repo` existe en el propio servidor, tengo varias opciones:

- Entrar por SSH al servidor y lanzar Emacs allí.
- O, desde mi máquina local, usar TRAMP (`/ssh:usuario@servidor:...`) para editar los archivos sobre SSH.

### 5.1. Abrir el proyecto con TRAMP

Si quiero editar desde mi Emacs local, puedo abrir directamente el proyecto con TRAMP. Por ejemplo:

```text
/ssh:sherlockes@uber:/home/sherlockes/dockers/hugo-dev/repo/
```

Eso me abre un `dired` en la raíz del blog, y desde ahí puedo navegar a:

- `content/` para las entradas.
- `layouts/` para los layouts personalizados.
- `config.yaml` o `config.toml`, según mi configuración.

Los archivos que edito por TRAMP aparecen además en la lista de “recientes” de Emacs, lo cual encaja muy bien con el uso de `dashboard`.

### Enlaces de interés
- [Entorno de desarrollo en Emacs](https://sherblog.es/entorno-de-desarrollo-de-sherblog-en-emacs/)


