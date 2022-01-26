---
title: "Cambiar el orden de los elementos del grub"
date: "2020-10-07"
creation: "2020-10-02"
descrption: "Cambiar el orden de los elementos del grub"
thumbnail: "/images/20201002_cambiar_orden_grub_00.jpg"
disable_comments: true
authorbox: false
toc: false
mathjax: false
categories:
  - "linux"
tags:
  - "grub"
  - "bash"
draft: false
weight: 5
---
En mi Pc de sobremesa coexisten Linux Mint y Windows 7, en el GRUB aparecen por defecto en primer lugar las opciones de Linux pero necesito que la opción en la que se produzca el arranque si el usuario no toca nada sea Windows, así lo he conseguido.
<!--more-->
Lo que puede parecer un complejo problema se resuelve con tres líneas de terminal. 

```
cd /etc/grub.d
sudo mv 30_os-prober 09_os-prober
sudo update-grub
```

La explicación es bastante simple. En el directorio "/etc/grub.d" están ubicados una serie de archivos que corresponden a cada uno de los tipos de arranque que puede tratar el grub. Algo parecido a lo siguiente.

```
sherlockes@imedia:/etc/grub.d$ ls -l
total 128
-rwxr-xr-x 1 root root 10627 abr 15 13:31 00_header
-rwxr-xr-x 1 root root  6258 abr 15 13:31 05_debian_theme
-rwxr-xr-x 1 root root 17622 sep  8 12:24 10_linux
-rwxr-xr-x 1 root root 42359 sep  8 12:24 10_linux_zfs
-rwxr-xr-x 1 root root 12894 abr 15 13:31 20_linux_xen
-rwxr-xr-x 1 root root 12059 abr 15 13:31 30_os-prober
-rwxr-xr-x 1 root root  1424 abr 15 13:31 30_uefi-firmware
-rwxr-xr-x 1 root root   214 abr 15 13:31 40_custom
-rwxr-xr-x 1 root root   216 abr 15 13:31 41_custom
-rw-r--r-- 1 root root   483 abr 15 13:31 README

```

La numeración de cada uno de los archivos corresponde a la posición en el menú de arranque. El archivo que hace referencia al arranque en Windows es el "30_os-prober", como el arranque en Linux corresponde al "10", solo hace falta cambiar el "30" por uno anterior al "10" y el listado del directorio quedará parecido a lo siguiente.

```
sherlockes@imedia:/etc/grub.d$ ls -l
total 128
-rwxr-xr-x 1 root root 10627 abr 15 13:31 00_header
-rwxr-xr-x 1 root root  6258 abr 15 13:31 05_debian_theme
-rwxr-xr-x 1 root root 12059 abr 15 13:31 09_os-prober
-rwxr-xr-x 1 root root 17622 sep  8 12:24 10_linux
-rwxr-xr-x 1 root root 42359 sep  8 12:24 10_linux_zfs
-rwxr-xr-x 1 root root 12894 abr 15 13:31 20_linux_xen
-rwxr-xr-x 1 root root  1424 abr 15 13:31 30_uefi-firmware
-rwxr-xr-x 1 root root   214 abr 15 13:31 40_custom
-rwxr-xr-x 1 root root   216 abr 15 13:31 41_custom
-rw-r--r-- 1 root root   483 abr 15 13:31 README
```

[PcSteps]: https://www.pcsteps.com/1053-change-grub-boot-order-linux-mint-ubuntu/
