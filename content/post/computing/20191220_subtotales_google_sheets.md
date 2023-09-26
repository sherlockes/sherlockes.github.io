---
title: "Subtotales en Google Sheets"
date: "2020-01-02"
creation: "2019-12-20"
description: "Dos formas de calcular subtotales dinámicos en Google Sheets."
thumbnail: "images/20191220_subtotales_google_sheets_00.jpg"
disable_comments: true
authorbox: false
toc: false
mathjax: false
categories:
  - "productividad"
tags:
  - "google sheets"
draft: false
weight: 5
---
En este post comentaré las dos formas que utilizo en mis archivos de Google Sheets para hacer cálculos de subtotales de forma "dinamica", es decir, en función del valor de otra columna. Para ello utilizo las funciones "filter" y "sumar.si".
<!--more-->
Para que sea más sencillo de entender usaré un ejemplo práctico. Tengo una hoja de cálculo en Google Sheets en la que guardo las horas al mes que escucho Podcast y que se ve algo como esto.

| Mes       | Dias | Horas | Total |
|-----------|------|-------|-------|
| 1/11/2018 | 4    | 17    | 113   |
| 1/12/2018 | 4    | 16    | 112   |
| 1/01/2019 | 5    | 7     | 127   |
| 1/02/2019 | 4    | 9     | 105   |
| 1/03/2019 | 4    | 5     | 101   |
| 1/04/2019 | 5    | 1     | 121   |
| 1/05/2019 | 5    | 11    | 131   |
| 1/06/2019 | 5    | 21    | 141   |
| 1/07/2019 | 7    | 11    | 179   |
| 1/08/2019 | 6    | 13    | 157   |
| 1/09/2019 | 5    | 1     | 121   |
| 1/10/2019 | 6    | 16    | 160   |
| 1/11/2019 | 6    | 4     | 148   |

Pues bien, necesito calcular el total de horas de un año específico, con la peculiaridad de que el año está determinado por el valor de otra celda en una segunda tabla que contiene el resumen por años.

Podría realizarse estás operación mediante unos cuantos pasos y hojas intermedias pero he optado por buscar la opción que lo calcule con una silla fórmula para lo que he encontrado dos opciones.

## Usando la función Sumar.Si
Google Sheets dispone de la función [Sumar.Si] que permite sumar dentro de un rango las celdas que cumplan con un determinado criterio. Usando esta posibilidad la función quedará como la siguiente:

![imagen_01]

### Parte 1 - TEXTO(Meses!$A$2:$A;"yyyy")
Dispongo de la fecha entera en la primera columna de la tabla superior (En mi archivo ubicada en la hoja "Meses" y la Columna "A"). Mediante la función [Texto] voy a reformatear los valores de la primera columna (Excepto el primero que es el título) a un formato de año de cuatro dígitos ("2019")

### Parte 2 - Criterio
Según está en la formula, en la celda A7 de la hoja de cálculo es donde estará el valor del año que quiero sumar cuando este coincida con la parte 1.

### Parte 3 - Rango a sumar 
La columna "D" de la hoja "Meses" es la que corresponde a los totales de horas que queremos sumar. Nuevamente se suma toda la columna a escepción de la primera fila que corresponde al título de la misma.

### Parte 4 - Sumar.Si
Esta es la función principal y que se encarga de comprobar los valores de la Parte 1 con el criterio de la Parte 2 y cuando se cumpla sumar la Parte 3

### Parte 5 - Arrayformula
No tengo claro la misión de la función [ArrayFormula], lo que está claro es que el método Sumar.Si tal y como lo he dispuesto no funciona si no lo incluyo como el argmento dentro de la función [ArrayFormula] para terminar quedando así.

***=ARRAYFORMULA(SUMAR.SI(TEXTO(Meses!$A$2:$A;"yyyy");A7;Meses!$D$2:$D))***

El resultado es bastante límpio y fácil de seguir, sin ningún tipo de columnas intermedias que tanto afean las hojas.

## Usando la función FILTER
Google Sheets dispone tambien de la avanzada función [Filter] que es capaz de filtrar una tabla de varias columnas con una o varias condiciones.

![imagen_02]

### Parte 1 - Intervalo
En la columna D de la hoja "Meses" (Excepto la primera fila que es el encabezado dispongo de los totales de horas para cada mes, esta es la columna de la que quiero obtener un subtotal para un mes determinado.

### Parte 2 - Condición
En la columna A de la hoja "Meses" tengo la fecha correspondiente al primer día del mes para el que he apuntado el total de horas. Cada una de estas fechas las convierto con la función [Año] y la comparo con la correspondiente casilla en la que está el número de año para el que quiero calcular el subtotal.

### Parte 3 - Filtro
La función [Filtro] nos mostrará todos los elementos del intervalo de la "Parte 1" que cumplan la condición de la "Parte 2"

### Parte 4 - Suma
Con el filtro ya aplicado calcularemos el total del mismo mediante la función [Suma] y con esto ya casi tendremos terminada la función.

### Parte 5 - Error
La función está completa pero presenta un pequeño problema y es que cuando no hay ningún valor dentro del intervalo que cumpla la condición (años futuros para los que no está metido el total de cada mes) presenta un error. Aunque es funcional resulta un poco desagradable a la vista. Lo evitamos con el uso de la función [Si.error] cuya misión únicamente es dejar la celda en blanco cuando encuentre un error. 

***=SI.ERROR(SUMA(FILTER(Meses!$D$2:$D;AÑO(Meses!$A$2:$A)=A8));"")***

Aunque haya que hacer la artimaña de la gestión de errores, prefiero utilizar la función [Filter] a la función [Sumar.Si] pues es mucho más potente al permitir el uso en una misma función de varias condiciones.

[Sumar.Si]: https://support.google.com/docs/answer/3093583?hl=es
[Texto]: https://support.google.com/docs/answer/3094139?hl=es
[ArrayFormula]: https://support.google.com/docs/answer/3093275?hl=es
[Filter]: https://support.google.com/docs/answer/3093197?hl=es
[Año]: https://support.google.com/docs/answer/3093061?hl=es
[Suma]: https://support.google.com/docs/answer/3093669?hl=es
[Si.error]: https://support.google.com/docs/answer/3093304?hl=es

[imagen_01]: /images/20191220_subtotales_google_sheets_01.jpg
[imagen_02]: /images/20191220_subtotales_google_sheets_02.jpg
