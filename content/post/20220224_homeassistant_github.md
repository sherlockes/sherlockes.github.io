---
title: "Homeassistant github"
date: "2022-02-24"
creation: "2022-02-24"
description: "Homeassistant github"
thumbnail: "images/20220224_homeassistant_github_00.jpg"
disable_comments: true
authorbox: false
toc: false
mathjax: false
categories:
- "computing"
tags:
- "bash"
draft: true
weight: 5
---
Resumen de introducción
<!--more-->

``` bash
scp -r -P 222 root@192.168.10.202:config/*.yaml ~/config
```
### Metodo 2
- Installar el Addon “SSH & Web Terminal“ desde la tienda del supervidor de Home Assistant
 - Poner el password que deseemos para la conexión
 - Asignar el puerto 22 del contenedor al 222 del host
 - Guardar y arrancar el complemento
 - Activar el inicio en el aranque, vigilancia, actualización automática y mostrar en la barra lateral
- Crear un repositorio privado en GitHub (Sin añadir el archivo ".gitignore")
- Desde la barra lateral de Home Assistan abrimos la terminal.
- Accedemos al directorio "config" mediante `cd config`
- Creamos el archivo ".gitignore" mediante `nano .gitignore`
- En el archivo copiamos el siguiente texto
``` txt
# El * inicial asegura que se va a ignorar todo en un principio.
*

# Lista blanca, archivos con !, no serán ignorados.
!*.yaml
!.gitignore
!*.md
!*.sh
!*.js*

# No queremos incluir el archivo "secrets.yaml" 
secrets.yaml

# Ignorar estos archivos/carpetas
.storage
.cloud
.google.token 
home-assistant.log
```
- Para guardar y salir "Ctrl + x" y luego "y"
- Iniciamos el repositorio mediante `git init`
- Añadimos todo el contenido mediante `git .`
- Ejecutamos el primer commit mediante `git commit -m "Primer Commit"`
- Añadimos el repositorio de GitHub como repositorio remoto mediante el comando
``` bash
git remote add origin git@github.com:USUARIO_GITHUB/NOMBRE_REPO_GITHUB.git
```
- Creamos las llaves ssh para conexión a GitHub
  - Dentro de "config" creamos el directorio ".ssh" mediante `mkdir .ssh`
  - Generamos la llave publico/privada mediante `ssh-keygen -t rsa -b 4096 -C "usuario@correo.com"`
  - Cuando pregunte donde guardar la llave ponemos ".ssh/id_rsa"
  - Copiamos el contenido de "id_rsa.pub" como llave de acceso ssh para nuestra cuenta de GitHub accediendo a Github.com > Tu perfil > Settings > SSH and GPG keys > New SSH key
  - Ahora hay que indicar a "git" donde se encuentra ubicada la llave mediante el siguiente comando
  ``` bash
  git config core.sshCommand "ssh -i /config/.ssh/id_rsa -F /dev/null"
  ```

 > Copiar el contenido de "id_rsa.pub" desde nano al portapapeles puede ser un profundo dolor de cabeza, la forma más sencilla es, una vez dentro del directorio ".ssh" mostrar el contenido de la llave mediante `cat id_rsa.pub`. Con Ctrl + Mays pulsado arrastramos con el ratón para releccionar todo el contenido de la llave y lo copiamos mediante "Ctrl + Mays + c".

  
 

ssh root@192.168.10.202 -p 222 'bash -s' < ~/SherloScripts/bash/ha_gitpush.sh


![image-01]

### Enlaces de interés
- [Linux Hint - Scp different port](https://linuxhint.com/scp-different-port/)
- [Peyanski - Home Asistant backup to github](https://peyanski.com/automatic-home-assistant-backup-to-github/)
- [HomeAssistan - Shell command](https://www.home-assistant.io/integrations/shell_command/)
[link]: https://www.google.es


[image-01]: /images/20220224_homeassistant_github_01.jpg
[image-02]: /images/20220224_homeassistant_github_02.jpg
[image-03]: /images/20220224_homeassistant_github_03.jpg
[image-04]: /images/20220224_homeassistant_github_04.jpg
[image-05]: /images/20220224_homeassistant_github_05.jpg
[image-06]: /images/20220224_homeassistant_github_06.jpg
[image-07]: /images/20220224_homeassistant_github_07.jpg
[image-08]: /images/20220224_homeassistant_github_08.jpg
[image-09]: /images/20220224_homeassistant_github_09.jpg
