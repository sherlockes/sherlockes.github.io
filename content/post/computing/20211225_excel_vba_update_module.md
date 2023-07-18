---
title: "Actualizar módulo de funciones en excel"
date: "2021-12-27"
creation: "2021-12-25"
description: "Actualizar módulo de funciones en excel mediante vba de forma automática."
thumbnail: "images/20211225_excel_vba_update_module_00.jpg"
disable_comments: true
authorbox: false
toc: false
mathjax: false
categories:
- "computing"
tags:
- "excel"
- "vba"
draft: false
weight: 5
---
Tenemos varias hojas de cálculo de Excel que trabajan todas con un mismo módulo de funciones. Esta es la forma para que de forma automática se actualicen los módulos de todas las hojas al realizar una modificación en el módulo que alberga las funciones.
<!--more-->
Tenemos una plantilla con dos módulos de funciones:
 - init: sólo con la función de actualización de módulos
 - vbapp: resto de funciones
 
El problema pasa por que son muchos los archivos que comparten el módulo "vbapp" para el funcionamiento de la hojas de cálculo por lo que cualquier modificación implica tener que actualizar este módulo en todos los archivos.

> He intentado hacer uso de módulos compartidos pero al ser usados por distintos usuarios desde una unidad de red que está montada con distintos nombres no he conseguido que funcione.

De esta forma, el módulo "init" sólo albergará las funciones "update" e "importar" quienes serán las encargadas de sustituir el módulo "vbapp" por una versión más reciente gracias al siguiente código:

```
Option Explicit

Sub update()
    Dim m As VBComponent

	For Each m In ThisWorkbook.VBProject.VBComponents
        If m.Name = "vbapp" Then
            ThisWorkbook.VBProject.VBComponents.Remove m
        End If
    Next
    Application.OnTime Now, "importar"
End Sub

Sub importar()
    ThisWorkbook.VBProject.VBComponents.Import (Application.ActiveWorkbook.path & "\vba.bas")
End Sub
```
El proceso que sigue la función "update" es el siguiente:
- Busca todos los componentes de Visual Basic del proyecto
- Borra todos los que sean módulos que se llamen "vbapp"
- Tras la limpieza importa el módulo "vba.bas"

> Es imprescindible hacer la eliminación y la importación en funciones distintas de forma que se llama a la función "importar" mediante un "Application.OnTime Now" dentro de la función "update" ya que de otra forma se intenta hacer la importación del módulo antes de la eliminación del anterior lo que provoca que la importación se realiza con otro nombre en lugar de "vbapp"

Con esto ya sólo resta llamar a la función "update" y se actualizará el módulo de funciones.
