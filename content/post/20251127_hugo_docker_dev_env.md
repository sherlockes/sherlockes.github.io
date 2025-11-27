---
title: "Título"
date: "2025-11-27"
creation: "2025-11-27"
description: "Descripción"
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
draft: true
weight: 5
---
Resumen de introducción
<!--more-->

Durante años he tenido mi blog de Hugo desplegado desde GitHub usando GitHub Actions, pero no tenía un entorno de desarrollo cómodo y aislado donde trastear sin miedo a romper nada. En esta entrada cuento cómo he montado un **entorno de desarrollo efímero con Docker** en mi servidor, que:

- Usa la **misma versión de Hugo Extended** que utilizo en GitHub Actions (en mi caso, `0.152.0`).
- Clona automáticamente el repositorio del blog desde GitHub al arrancar.
- Limpia el estado del repositorio cada vez que se levanta el contenedor (no guarda cambios locales).
- Me permite editar los archivos desde Emacs como si fuesen locales.
- No deja “basura” permanente en el contenedor: si algo se rompe, paro y vuelvo a arrancar.

A continuación explico **solo la solución final que ha quedado funcionando**, junto con el contenido completo de los archivos que he creado.

> Nota: sustitúyase `sherlockes` y `sherlockes.github.io` por el usuario/repositorio que corresponda en tu caso.

---

## 1. Estructura del entorno en el servidor

En mi servidor he creado un directorio específico para este entorno de desarrollo:

```bash
mkdir -p ~/dockers/hugo-dev
cd ~/dockers/hugo-dev
```

Dentro de esa carpeta tengo tres piezas clave:

- `Dockerfile` – Imagen personalizada con Hugo Extended 0.152.0.
- `start.sh` – Script de arranque del contenedor (clona/actualiza repo y lanza Hugo).
- `docker-compose.yml` – Orquestación del contenedor y volúmenes.

Además, Docker monta una carpeta `repo/` en el host que contiene la copia del blog:

```text
~/dockers/hugo-dev/
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

if [ -d "$REPO_DIR/.git" ]; then
  echo "🧹 Limpiando copia anterior de $REPO_DIR..."
  cd "$REPO_DIR"
  # Descartar cualquier cambio local y dejar el repo como en la última commit
  git reset --hard
  git clean -fdx

  echo "🔄 Actualizando desde GitHub (git pull)..."
  git pull --ff-only
else
  echo "📥 Clonando repositorio por primera vez..."
  rm -rf "$REPO_DIR"
  git clone "$REPO_URL" "$REPO_DIR"
  cd "$REPO_DIR"
fi

echo "🚀 Lanzando servidor de desarrollo Hugo..."
hugo server -D --bind 0.0.0.0 --baseURL http://localhost:1313
```

Y en el host me aseguro de que es ejecutable:

```bash
chmod +x start.sh
```

¿Qué hace este script?

1. Define la URL del repositorio (`REPO_URL`) y el directorio donde debe clonar (`REPO_DIR`).
2. Si ya existe un repositorio Git en `/site/repo`:
   - Ejecuta `git reset --hard` y `git clean -fdx` para **eliminar cualquier cambio local** y archivos no versionados.
   - Hace `git pull --ff-only` para traer la última versión del blog desde GitHub.
3. Si no existe el repositorio:
   - Borra cualquier resto de carpeta previa y clona desde cero.
4. Por último, arranca `hugo server -D`:
   - `-D` incluye borradores.
   - `--bind 0.0.0.0` lo hace accesible desde fuera del contenedor.
   - `--baseURL` se queda en `http://localhost:1313` para el entorno de desarrollo.

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
    ports:
      - "1313:1313"
    volumes:
      - ./repo:/site/repo
      - ./start.sh:/site/start.sh
    restart: unless-stopped
```

Detalles clave:

- `build: .` indica que Compose debe construir la imagen usando el `Dockerfile` del directorio actual.
- `container_name: hugo-dev` me permite identificar y ejecutar comandos fácilmente contra el contenedor.
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

### 5.2. Añadir el proyecto a Dashboard como favorito

Si utilizo `dashboard` junto con `projectile`, puedo añadir el proyecto remoto como uno de mis “projects” favoritos para acceder a él rápidamente desde la pantalla de inicio. Un ejemplo sencillo de configuración podría ser:

```elisp
;; Asegurar que Dashboard muestra proyectos
(add-to-list 'dashboard-items '(projects . 5))

;; Añadir el proyecto del blog (ruta en el servidor o vía TRAMP)
(add-to-list 'projectile-known-projects
             "/ssh:sherlockes@uber:/home/sherlockes/dockers/hugo-dev/repo/")
```

Con esto, al abrir Emacs, en el dashboard me aparece el proyecto del blog y puedo saltar a él con un solo atajo.

---

## 6. Flujo de trabajo diario

Con todo esto montado, mi flujo de trabajo para tocar el blog y probar cosas nuevas es:

1. **Arrancar el entorno de desarrollo en el servidor**

   ```bash
   cd ~/dockers/hugo-dev
   docker compose up
   ```

2. **Abrir el proyecto en Emacs** (en el propio servidor o vía TRAMP):

   - Navego a `~/dockers/hugo-dev/repo/content/post/` y edito o creo nuevas entradas en Markdown.
   - Ajusto `layouts`, shortcodes, etc., según necesite.

3. **Visualizar los cambios en el navegador** entrando a:

   ```text
   http://mi-servidor:1313
   ```

   Hugo recarga automáticamente cuando guardo archivos.

4. Si una idea me gusta de verdad y la quiero “promocionar” fuera del entorno efímero:
   - Hago `git add`, `git commit` y `git push` desde cualquier clon “serio” del repositorio (por ejemplo, en mi máquina local).
   - O, si quiero, directamente desde `~/dockers/hugo-dev/repo` en el servidor.

5. Cuando termino de experimentar, simplemente:

   ```bash
   docker compose down
   ```

   El siguiente `docker compose up` volverá a dejar el repositorio limpio y sincronizado con GitHub.

---

## 7. Conclusión

Con estos tres archivos:

- `Dockerfile` (imagen con Hugo Extended 0.152.0),
- `start.sh` (script que clona, limpia y arranca),
- `docker-compose.yml` (orquestación y volúmenes),

he conseguido tener un **entorno de desarrollo de Hugo en Docker, efímero pero cómodo**, que no se cruza con GitHub Pages ni con el entorno de producción, y que se integra bien con mi forma de trabajar con Emacs.

Puedo romper cosas, cambiar shortcodes, probar nuevas versiones de Hugo, reorganizar layouts… y si no me convence, paro el contenedor y al siguiente arranque todo vuelve a estar limpio y actualizado desde GitHub.

La clave está en que todo el “estado” importante vive en Git; el contenedor solo es una herramienta para ver y experimentar de forma segura.


![image-01]

### Enlaces de interés
- [enlace](www.sherblog.pro)

[link]: https://www.google.es

[image-01]: /images/20251127_hugo_docker_dev_env_01.jpg



