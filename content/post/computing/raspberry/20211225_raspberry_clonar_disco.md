---
title: "Clonar el disco de arranque de la raspberry"
date: "2021-12-25"
creation: "2021-12-25"
description: "Como crear una imagen de la raspberry sin apagarla"
thumbnail: "images/20211225_raspberry_clonar_disco_00.jpg"
disable_comments: true
authorbox: false
toc: false
mathjax: false
categories:
- "computing"
- "raspberry"
tags:
- "bash"
- "linux"
draft: false
weight: 5
---
La mejor copia de seguridad que puedes hacer del contenido de la Raspberry es una imagen de la tarjeta sobre la que está funcionando. Dejo a continuación un par de métodos para hacerlo de una forma rápida y sencilla.
<!--more-->
En mi caso dispongo en la actualizada de una Rpi4 que arranca sobre un pendrive usb de 64 Gb del que quiero crear una imagen para arrancar directamente en caso de que esta falle.

### Clonación en frío

La forma más sencilla de realizar una clonación de la unidad del sistema operativo en otra unidad es mediante un segundo sistema operativo al que conectaremos los dos pinchos usb y ejecutamos el comando

```
sudo dd if=/dev/sda of=/dev/sdb
```
donde if (input file) es el pendrive origen y of (output file) es el pendrive destino. Un poco de paciencia y ya estería realizada la clonación pero he necesitado un segundo sistema operativo y apagar la raspberry surente un buen rato.

> Este método requiere de una unidad de destino con al menos la misma capacidad que la de origen, esté ocupada o no.

### Clonación en caliente (Usando rpi-clone)
#### Identificando la unidad del sistema
Para identificar la unidad del sistema utilizaremos el comando `lsblk` que, al ejecutarlo via ssh sobre la Raspberry nos mostrará la siguente salida:

``` bash
NAME   MAJ:MIN RM  SIZE RO TYPE MOUNTPOINT
sda      8:0    1 57.3G  0 disk 
├─sda1   8:1    1  256M  0 part /boot
└─sda2   8:2    1 57.1G  0 part /
```

De donde se deduce que la unidad del sistema está montada como "sda". Ahora es el momento de introducir el pincho sobre el que queremos crear la imagen del sistema y volver a ejecutar el comando `lsblk', en este caso obtenemos lo siguiente:

``` bash
NAME   MAJ:MIN RM  SIZE RO TYPE MOUNTPOINT
sda      8:0    1 57.3G  0 disk 
├─sda1   8:1    1  256M  0 part /boot
└─sda2   8:2    1 57.1G  0 part /
sdb      8:16   1 28.7G  0 disk 
└─sdb1   8:17   1 28.7G  0 par
```

Con esto ya sabemos que la unidad origen será "sda" y el destino "sdb" pero tenemos un problema y es que la unidad de destino es mas pequeña por lo que necesitamos saber cuando espacio de "sda" está ocupado. Esto lo podemos obtener con el comando `df . -h` que muestra la siguiente salida:

``` bash
Filesystem      Size  Used Avail Use% Mounted on
/dev/root        57G  8.5G   46G  16% /

```
De los 57 Gb sólo están ocupados 8.5 por que, con la unidad de destino de 28.7 Gb será más que suficiente.

#### Instalación de rpi-clone
Para la instalación del [rpi-clone] hay que llevar a cabo los siguientes pasos:

- Descargar el repositorio del script
- Descomprimir el archivo descargado
- Renombrar el directorio
- Copiar el directorio al lugar de ejecución
- Eliminar lo la ya no se necesita

Lo realizaremos mediante los siguiente comandos:

``` bash
wget https://github.com/billw2/rpi-clone/archive/master.zip
unzip master.zip
mv rpi-clone-master rpi-clone
sudo cp rpi-clone/rpi-clone* /usr/local/sbin
rm -rf rpi-clone master.zip
```

> Tambien es posible clonar el repositorio mediante git en lugar de descargarlo, descomprimirlo y renombrarlo.

#### Ejecución de la copia
Llegados a este punto sólo resta ejecutar el siguiente comando

``` bash
sudo bash rpi-clone sdb -f
```

Donde "sdb" es la unidad donde vamos a crear la imagen del sistema y el parámetro "f" fuerza la inicialización de esta unidad. Habrá que esperar un rato, en mi caso unos 30 minutos y obtendremos una salida como la siguiente:

``` bash
Booted disk: sda 61.5GB                    Destination disk: sdb 30.8GB
---------------------------------------------------------------------------
Part      Size    FS     Label           Part   Size    FS     Label
1 /boot   256.0M  fat32  --              1       28.7G  fat32  --
2 root     57.1G  ext4   rootfs                                  
---------------------------------------------------------------------------
== Initialize: IMAGE partition table - forced by option ==
1 /boot               (48.0M used)   : MKFS  SYNC to sdb1
2 root                (8.4G used)    : RESIZE  MKFS  SYNC to sdb2
---------------------------------------------------------------------------
Run setup script       : no.
Verbose mode           : no.
-----------------------:
** WARNING **          : All destination disk sdb data will be overwritten!
-----------------------:

Initialize and clone to the destination disk sdb?  (yes/no): yes
Optional destination ext type file system label (16 chars max): homeassistant

Initializing
  Imaging past partition 1 start.
  => dd if=/dev/sda of=/dev/sdb bs=1M count=8 ...
  Resizing destination disk last partition ...
    Resize success.
  Changing destination Disk ID ...
  => mkfs -t vfat -F 32  /dev/sdb1 ...
  => mkfs -t ext4 -L homeassistant /dev/sdb2 ...

Syncing file systems (can take a long time)
Syncing mounted partitions:
  Mounting /dev/sdb2 on /mnt/clone
  => rsync // /mnt/clone with-root-excludes ...
  Mounting /dev/sdb1 on /mnt/clone/boot
  => rsync /boot/ /mnt/clone/boot  ...

Editing /mnt/clone/boot/cmdline.txt PARTUUID to use d8b40570
Editing /mnt/clone/etc/fstab PARTUUID to use d8b40570
===============================
Done with clone to /dev/sdb
   Start - 18:15:21    End - 18:39:32    Elapsed Time - 24:11

Cloned partitions are mounted on /mnt/clone for inspection or customizing. 

Hit Enter when ready to unmount the /dev/sdb partitions ...
  unmounting /mnt/clone/boot
  unmounting /mnt/clone
===============================

```

Y ya está el pendrive listo para sacar de la raspberry y guardarlo por si falla el del sistema.

### Enlaces de interés
- [Cambiaté a linux](https://cambiatealinux.com/ver_espacio_en_disco_en_linux)
- [Pysselilivet](https://pysselilivet.blogspot.com/2017/11/rpi-clone-raspberry-boot-disk.html)
- [Un fantasma en el sistema](https://www.unfantasmaenelsistema.com/2019/07/clonar-un-pendrive-booteable-en-linux/)
- [Yo Friki](https://www.yofriki.com/2016/06/como-clonar-un-usb-con-autoarranque-en.html)

[rpi-clone]: https://github.com/billw2/rpi-clone
