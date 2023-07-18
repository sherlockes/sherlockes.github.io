---
title: "Raspberry configurando rclone sin entorno gráfico"
date: "2019-07-11"
creation: "2018-19-10"
description: "Como instalar y configurar una nube en rclone dentro de nuestra Raspberry"
thumbnail: "images/20180910_raspberry_rclone_00.jpg"
disable_comments: true
authorbox: false
toc: true
mathjax: false
categories:
  - "raspberry"
tags:
  - "desarrollo"
  - "rclone"
draft: false
weight: 5
---
En linux no hay cliente oficial para acceder a Google Drive pero por suerte hay varias utilizades que permiten realizar enta labor.  Hay cientos de post al respecto de la existencia de estas utilidades, por lo que no voy a crear uno más, simplemente voy a explicar mi experiencia con una de las que yo utilizo. [Rclone]
<!--more-->

# Instalación

La instalación es realmente sencilla gracias al script que hay en la web oficial

```bash
curl https://rclone.org/install.sh | sudo bash
```

Podemos comprobar que se ha instalado correctemente mediante el comando

```bash
rclone -V
```

# Configuración de la nube

Hasta aquí bastante sencillo, el problema viene en el momento que intentamos configurar cualquiera de las nubes ya que, a priori, es necessario un entorno gráfico para conseguir el código de autorización a través del navegador web.

> Por la red circulan varios tutoriales para realizar esta configuración de las nubes mediante navegadores web en línea de comando en modo texto y... después de probar varios no he conseguido que me funcione ninguno para esta operación.  A unos del falla el javascript...

En ausencia de entorno gráfico en  la Raspberry voy a utilizar el viejo portatil con linux Mint desde el que accedo a la misma para realizar esta configuración.

Empezamos a añadir una nueva nube mediante

```bash
rclone config
```

y nos aparecen las suigiente opciones

```bash
No remotes found - make a new one
n) New remote
s) Set configuration password
q) Quit config
n/s/q>
```

Optamos por "n" para añadir una nueva nube remota.  En mi caso voy a realizar una sincroización con Google Drive por lo que cuando se me solicita el nombre utilizo "gdrive" y ante la opción "storage" selecciono el 11 que es el correspondiente a Google Drive.

```
Type of storage to configure.
Enter a string value. Press Enter for the default ("").
Choose a number from below, or type in your own value
 1 / Alias for a existing remote
   \ "alias"
 2 / Amazon Drive
   \ "amazon cloud drive"
 3 / Amazon S3 Compliant Storage Providers (AWS, Ceph, Dreamhost, IBM COS, Minio)
   \ "s3"
 4 / Backblaze B2
   \ "b2"
 5 / Box
   \ "box"
 6 / Cache a remote
   \ "cache"
 7 / Dropbox
   \ "dropbox"
 8 / Encrypt/Decrypt a remote
   \ "crypt"
 9 / FTP Connection
   \ "ftp"
10 / Google Cloud Storage (this is not Google Drive)
   \ "google cloud storage"
11 / Google Drive
   \ "drive"
12 / Hubic
   \ "hubic"
13 / JottaCloud
   \ "jottacloud"
14 / Local Disk
   \ "local"
15 / Mega
   \ "mega"
16 / Microsoft Azure Blob Storage
   \ "azureblob"
17 / Microsoft OneDrive
   \ "onedrive"
18 / OpenDrive
   \ "opendrive"
19 / Openstack Swift (Rackspace Cloud Files, Memset Memstore, OVH)
   \ "swift"
20 / Pcloud
   \ "pcloud"
21 / QingCloud Object Storage
   \ "qingstor"
22 / SSH/SFTP Connection
   \ "sftp"
23 / Webdav
   \ "webdav"
24 / Yandex Disk
   \ "yandex"
25 / http Connection
   \ "http"
Storage> 
```

A continuación, las opciones "client_id" y "client_secret" las dejo en blanco.  La siguiente opción es el tipo de acceso que voy a necesitar, sólo lectura, lectura y escritura...

```bash
 1 / Full access all files, excluding Application Data Folder.
   \ "drive"
 2 / Read-only access to file metadata and file contents.
   \ "drive.readonly"
   / Access to files created by rclone only.
 3 | These are visible in the drive website.
   | File authorization is revoked when the user deauthorizes the app.
   \ "drive.file"
   / Allows read and write access to the Application Data folder.
 4 | This is not visible in the drive website.
   \ "drive.appfolder"
   / Allows read-only access to file metadata but
 5 | does not allow any access to read or download file content.
   \ "drive.metadata.readonly"

```

Selecciono "1" puesto que quiero tanto poder leer como escribir en las carpetas de la nube.

Ahora, la opcion "ID of the root folder" la dejo en blanco para poder acceder a toda la nube.  Deja tambien en blanco la opción "Service Account Credentials JSON file path" 

La siguiente opción es la configuración avanzada que no necesitamos.

```bash
Edit advanced config? (y/n)
y) Yes
n) No
y/n> n
```

Y ahora llega lo más interesante del post.  Cuando se nos pregunta por la configuración automática debemos seleccionar la opción "No"

Ya ha llegado el momento de la arte más interesante de este post para la que abriremos una nueva sesion de terminal pero en este caso directamente en la instalación de Linux Mint que tengo instalada en el portatil.  Hay que tener instalado Rclone tambien en esta máquina con navegador completo y entorno gráfico.  Si no lo tengo, lo instalo y a continuación ejecuto el siguiente comando.

```bash
rclone authorize "drive"
```

> He usado la opción "drive" por estar configurando una cuenta de Google Drive, para el resto de servicios hay que revisar la lista en la que anteriormente hemos seleccionado el tipo de nube para ver la opción que debemos poner entrecomillada.

Si todo ha ido bien se nos abrirá el navegador en Linux Mint y nos pedirá la cuente de Google Drive a la que queremos dar permiso tal y como se muestra en la siguiente imagen.

![imagen][1]

Tras permitir el acceso a Rclone a nuestra nube de google drive, si todo ha ido bien  nos aparece una ventana tan simple como expresiva...

![imagen][2]

Y ya podemos cerrar el navegador para volver a la sesión de terminal sobre Linux Mint en la que aparecerá algo así

```
Log in and authorize rclone for access
Waiting for code...
Got code
Paste the following into your remote machine --->
{"access_token":"ya29.GlsUErbFcat-9A3rWwjFXtLPnZyHTuaRiNMp9-Dshye44tciu3Ad1syvXrtCqXau_3N8gYt7d4bRzDsTlRVeF79Qcf8Id-IBvwW_wr88s-PELgRs9KKaf","token_type":"Bearer","refresh_token":"1/90zRjxj0d7fDh-W979DbnJ6xscxcsKto0ekygRo-97yOns","expiry":"2018-09-10T18:22:45.52936872+02:00"}
<---End pasteConfigure this as a team drive?
y) Yes
n) No
y/n>
```

Y... después de todo este trabajo y de intentar documentar sobre la marcha el [método oficial ][12] que debería funcionar resulta que me aparece un error por faltar el parámetro "Code"

```bash
Failed to configure token: failed to get token: oauth2: cannot fetch token: 400 Bad Request
Response: {
  "error" : "invalid_grant",
  "error_description" : "Malformed auth code."
}
```

Toca probar el plan"b" que consiste en configurar la nube desde la instalación de Linux Mint y posterior mente copiar el archivo de configuración a la Raspberry. Con todo lo explicado anteriormente no creo que sea necesario más para configurar Google Drive en Rclone instalado sobre Linux Mint, sólo restaba en la últime opción escoger la opción "Si" en la configuración automática y se nos abre el navegador para permitir el acceso.

Con la nube configurada en Linux Mint hay que buscar el archivo de configuración de rclone que en mi caso se encuentra en "/home/sherlockes/.config/rclone/rclone.conf" para el caso de la instalación sobre el portatil  y en "/home/pi/.config/rclone/rclone.conf" para el caso de la Raspberry.

Es posible copiar directamente el archivo de una máquina a otra a través de ssh mediante el comando scp

```bash
scp /home/sherlockes/.config/rclone/rclone.conf pi@192.168.1.203:/home/pi/.config/rclone/
```

Y con esto ya debería estar configurada la nube de Google Drive en la instalación de rclone de la raspberry, la mejor muestra es que al introcudir el comando "rclone config" en una sesión de la terminal sobre la Raspberry nos aparecerá algo como lo siguiente.

```bash
Current remotes:

Name                 Type
====                 ====
GoogleDrive          drive

e) Edit existing remote
n) New remote
d) Delete remote
r) Rename remote
c) Copy remote
s) Set configuration password
q) Quit config
e/n/d/r/c/s/q> 
```

En la que podremos ver la que ya tenemos una nube añadida.

# Encriptación de la nube
Es recomendable empezar con una carpeta vacía en la nube en la que queremos subir el contenido encriptado. Para, previamente tal y como he explicado hay que configurar la nube en rclone y luego pasamos a configurar la carpeta encriptada "micarpeta".

1- Accedemos a la configuración de Rclone `rclone config`
1- Creamos un nuevo remoto <kbd>n</kbd>
2- Nombramos la carpeta `micarpeta`


Para otro día el modo de realizar la sincronización o copia de contenidos desde la nube hasa la Raspberry.

[1]: /images/20180910_raspberry_rclone_01.jpg
[2]: /images/20180910_raspberry_rclone_02.jpg
[Rclone]: https://rclone.org
[12]: https://rclone.org/remote_setup/
[Articulo de MosqueteroWeb]: https://diario.mosqueteroweb.eu/2019/06/como-cifrar-y-descifrar-archivos-en-la.html


