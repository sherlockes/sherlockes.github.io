---
title: "Synology. Falta de espacio en la unidad de sistema"
date: "2024-02-06"
creation: "2024-02-06"
description: "Solución al problema de la falta de espacio en la unidad de sistema"
thumbnail: "images/20240206_synology_space_filesystem_00.jpg"
disable_comments: true
authorbox: false
toc: false
mathjax: false
categories:
- "computing"
tags:
- "synololgy"
draft: true
weight: 5
---
En NAS de Synology no se actualiza por falta de espacio en la unidad de sistema y estos son los pasos que he dado para dar con la solución.
<!--more-->
El primer paso es acceder via ssh al NAS y ejecutar los comandos:

``` bash
sudo -i
df -h
```
Con el primero escalamos a los privilegios de root y con el segundo listamos el espacio ocupado por las particiones del sistema

``` bash
root@sherver:~$ df -h
Filesystem              Size  Used Avail Use% Mounted on
/dev/md0                2.3G  2.1G  110M  96% /
devtmpfs                1.9G     0  1.9G   0% /dev
tmpfs                   1.9G  124K  1.9G   1% /dev/shm
tmpfs                   1.9G   18M  1.9G   1% /run
tmpfs                   1.9G     0  1.9G   0% /sys/fs/cgroup
tmpfs                   1.9G  1.7M  1.9G   1% /tmp
/dev/mapper/cachedev_0  1.8T  1.2T  622G  66% /volume1
```
Claramente vemos que el problema por el que no podemos actualizar el sistema son los 110 Mb que quedan como espacio libre. Ahora falta determinar la causa para lo cual ejecutamos el comando `du -hd 1 --exclude=volume1` obteniendo la siguiente respuesta:

``` Bash
root@sherver:/# du -hd 1 --exclude=volume1
1.2M	./tmp
124K	./photo
1.2G	./usr
8.0K	./volumeUSB1
9.3M	./var.defaults
44K	./.old_patch_info
3.4M	./.log.junior
210M	./var
124K	./dev
4.0K	./lost+found
540M	./root
16K	./opt
4.0K	./initrd
4.0K	./mnt
59M	./.syno
18M	./run
2.5M	./etc.defaults
4.0K	./.system_info
0	./sys
4.7M	./etc
0	./config
```

Empezaremos por la carpeta más grande de todas aunque al acceder a la misma veamos esto:

``` Bash
root@sherver:~# ls
'FOR SYSTEM USE ONLY. DO NOT UPLOAD FILES HERE.'
```

Sólo es postureo ya que si lanzamos un `ls -a` vemos el contenido real de la carpeta "root"

``` Bash
root@sherver:~# ls -a
 .    .cache                                            .profile              .ssh
 ..  'FOR SYSTEM USE ONLY. DO NOT UPLOAD FILES HERE.'   .profile.size_check   .wget-hsts
```

Ahora volvemos a lanzar el comando `du -hd 1 --exclude=volume1` para ver el tamaño de las carpetas.

```  Bash
root@sherver:~# du -hd 1 --exclude=volume1
16K	./.ssh
544M	./.cache
3.6M	.
```

Ya parece que nos estamos acercando, entramos en ".cache" y...

``` Bash
root@sherver:~/.cache# du -hd 1 --exclude=volume1
542M	./pip
3.5M	.
```

Ya parece que hemos dado con el problema, la cache de "pip" que vamos a borrar mediante el comando `pip cache purge`

``` Bash
root@sherver:/# df -h
Filesystem              Size  Used Avail Use% Mounted on
/dev/md0                2.3G  1.5G  712M  68% /
devtmpfs                1.9G     0  1.9G   0% /dev
tmpfs                   1.9G  124K  1.9G   1% /dev/shm
tmpfs                   1.9G   18M  1.9G   1% /run
tmpfs                   1.9G     0  1.9G   0% /sys/fs/cgroup
tmpfs                   1.9G  1.7M  1.9G   1% /tmp
/dev/mapper/cachedev_0  1.8T  1.2T  621G  66% /volume1
```


![image-01]

### Enlaces de interés
- [Fernian - Liberar espacio](https://fernian.blogspot.com/2020/04/liberar-espacio-de-un-nas-synology.html)
- [Stackoverflow - pip cache ](https://stackoverflow.com/questions/37513597/is-it-safe-to-delete-cache-pip-directory)

[link]: https://www.google.es

[image-01]: /images/20240206_synology_space_filesystem_01.jpg



