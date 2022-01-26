---
title: "Termostato Raspberry"
date: "2021-01-13"
creation: "2020-11-12"
description: "Proceso de la creación de un termostato mediante la raspberry en python"
thumbnail: "/images/20201112_termostato_raspberry_00.jpg"
disable_comments: true
authorbox: false
toc: true
mathjax: false
categories:
  - "raspberry"
tags:
  - "linux"
  - "raspberry"
  - "python"
  - "google sheets"
draft: false
weight: 5
---
Con la reciente muerte de termostato inteligente de NetAtmo a causa de una simple pila sulfatada me he decidido a crear el mio propio con la raspberry y un poco de Python. Iré escribiendo aquí los procesos con el mismo.
<!--more-->
### Archivo de configuración
Puesto que la idea es construir un script que se ejecute cada determinado tiempo, necesito un archivo que dote al sistema de persistencia de algunas variables. Después de barajar varias alternativas, he optado por guardar los datos de configuración en un archivo "config.json" ubicado en la carpeta raiz del usario que ejecuta el script.

El manejo de este tipo de archivos en python es muy sencillo y queda sentenciado con sólo seis líneas de código.
```
import json

with open('/home/pi/config.json', 'r') as archivo_json:
    data=archivo_json.read()

datos_json = json.loads(data)

...
...
... 
...
...

with open("config.json", "w") as archivo_json:
    json.dump(datos_json, archivo_json, indent = 4)
```
Al principio del script hay que importar la librería "json", abrir el archivo en modo de lectura, leer el contenido y asignar este al dicionario "json_data". Una vez realizadas las modificaciones necesarias en el diccionario a lo largo del script principal hay que abrir nuevamente el archivo "config.json", aunque esta vez en modo de escritura, y volcar sobre el el contenido del diccionario "datos_json" modificado.

La variables utilizadas en el almacenamiento externo de variables son:
- data - Lectura del archivo json
- datos_json - Diccionario de datos con variables

### Inicialización de variables

La primera vez que abramos este archivo de configuración estará vacío por lo que nos tendremos que asegurar de inicializar unas "variables por defecto" para no tenga lugar el correspondiente error en caso de uqe alguna no exista o tenga un valor nulo. Esto se realiza mediante el siguiente código una vez que la variable "datos_json" ha sido creada a partir del contenido del archivo.

```
def inic_var(var,valor):
    if var in datos_json:
        if datos_json[var] == "":
            datos_json[var] = valor
    else:
        datos_json[var] = valor

variables = {
    "rele_estado": "off",
    "rele_hora_cambio": datetime.now().strftime('%Y/%m/%d %H:%M:%S'),
    "histeresis": 0.2,
    "inercia": 750,
    "inercia_rango": 1.013,
    "consigna": 21.0,
    "rele_total_on": 0,
    "cons_manual": 21.0,
    "hora_manual": "2020/12/30 16:45:32",
    "min_manual": 60,
    "modo_fuera": False,
    "cons_fuera": 16,
    "dec_casa_vacia": 1,
    "horas": ["7:45","9:00","12:30","18:00","22:30"],
    "temperaturas": ["22","20.5","21.5","22.5","20.5"]
}

for x in variables:
    inic_var(x,variables[x])
```

Este código lo podemos dividir en tres partes, la función que inicializa las variables, el almacenamiento de las variables y la ejecución de la función para cada una de las variables.

#### La función inic_var
La función "inic_var" coge dos argumentos, por un lado el nombre de la variable a inicializar y por otro su valor por defecto. En un primer momento se comprueba si la variable existe dentro de "datos_json", si lo está y su valor es nulo le asignará el valor por defecto. En caso de que la variable no esté definida, se creará asignándole su valor por defecto.

#### El diccionario de variables
Después de barajar varias alternativas, he considerado que la forma más clara de representar todo el conjunto de variables dentro de un elemento es haciendo uso de un diccionario que he denominado "variables" en el que cada clave será el nombre de la variable a inicializar y el valor de la misma el valor por defecto de esta variable que está siendo inicializada.

#### For sobre el diccionario
Con la lista de variables, su valor por defecto y la función para inicializar cada una de ellas preparada solo resta realizar una combinación de ambas mediante un lazo "For". De esta forma cada variable existente dentro del diccionario "Variables" sera inicializada mediante la funcion "inic_var"

La variables utilizadas en la inicialización de variables son:
- variables - Diccionario con el nombre de variable y valor por defecto

### Captura de la temperatura exterior
De momento no he sido capaz de utilizarla para nada más allá de la mera representación de la misma. Extraigo la información de la web de la AEMET para obtener el valor de la temperatura exterior. Todo mediante la [clase Aemet] que puedes ver en mi repositorio de GitHub.

Esta clase nos devolverá las siguientes variables:
- hora - Momento de la última toma
- temp_actual - Valor instantáneo de Tª obtenida
- temp_media - Valor medio diaro de la Tª

### Captura de la temperatura interior
Para tomar la temperatura que tengo en casa voy a utilizar un DHT22 (sensor de humedad y temperatura) que, aunque no es lo más preciso del mundo, es suficientemente barato como para empezar a hacer pruebas. En el artículo de [atareao] se explica perfectamente como llevar a cabo esta medición. El propio sensor DHT22, una resistencia de 10k y tres cables para conectar al puerto GPIO de la Raspberry es odo lo que he necesitado.

![Imagen_01]

Necesitamos una librería para capturar los datos del sensor. Esta se instalará en la raspberry medianta el comando `sudo pip3 install Adafruit_DHT` siempre y cuando tengamos instalado Python3 y el gestos de paquetes pip.

```
import Adafruit_DHT as dht

datos_dht = dht.read_retry(dht.DHT22,4)

while datos_dht[0] > 100:
    time.sleep(5)
    datos_dht = dht.read_retry(dht.DHT22,4)
    
real_hume = round(datos_dht[0],2)
real_temp = round(datos_dht[1],2)
```

Sobre estas líneas aparece la parte de código en Python involucrada en la medición de la temperatura. Importación de la libreria [ADAfruit-DHT], captura de los datos del sensor y un redondeo a dos decimales que es más que suficiente.

> Alguna vez me ha dado un dato inválido la medición por lo que le he incrustado una condición de que siempre que la medición de humedad sea mayor del 100% (dato no válido) que espere 5 segundos y vuelva a medir.

Las variables utilizadas en la adquisición de temperatura son las siguientes:
- datos_dht - Tupla con los valores de la medida del sensor
- real_hume - Humedad medida y redondeada
- real_temp - Temperatura medida y redondeada

### El relé de la caldera

Para poder enceder la caldera es necesario un relé. Lo más sencilo hubiera sido colocar uno que, a través del puerto GPIO, fuera directamente gobernado por la Raspberry pero tengo una serie de limitaciones en casa que no me han permitido hacerlo. Por eso necesito un relé que cumpla con lo siguiente:

- Alimentación de 220V
- Conexión wifi
- Relé seco (Sin tensión en lo contactos)
- Disponibilidad de API

Aunque no son muchas las limitaciones que le he impuesto, no me ha resultado fácil enontrar un relé que se adapte a ellas y el resultado es este.

![Imagen_02]

Una combinación casera de un [relé wifi sonoff], un [transformador] de 220V a 5V y un [relé] de 5V (todo perfectamente unido con cinta adhesiva) que si no quieres esperar y los compras en Amazon te constarán en total poco más de 20€ pero que si no tienes prisa se pueden encontar en Aliexpress por menos de la mitad.

Según lo he montado, la Raspberry menda a través de wifi el comando de activación al relé Sonnoff y, cuando este se activa alimenta al mini transformador que a su  vez hace lo mismo con el relé seco de 5V. A través del contacto de este segundo relé activamos los contactos del termostato de la caldera. una combinación efectiva, fiable y económica.

{{< borrador >}}

#### El modo DIY de Sonoff
La principal característica que convierte al relé Sonoff mini en el más interesante para este proyecto es el modo DIY (Hazlo tu mismo) gracias al cual se puede gobernar el interruptor mediante un comando enviado a través de wifi sin que sea necesaria una app, plugin o skill intermedia.

En la web del fabricante está perfectamente documentado como habilitar el modo [DIY] que se resume en lo siguiente:

- Alimentar el relé
- Instalar la aplicación [ewelink]
- Conectar el relé a la aplicación
- Actualizar el firmware del relé a través de la App
- Resetear el relé pulsando el botón de emparejamiento durante 5 segundos
- Volver a pulsar durante 5 segundos el botón para entrar en el modo de emparejamiento

> LLegados a este punto el led del relé deberá estar parpadeando de forma intermitente. Habrá creado una red wifi llamada ITEAD-XXXXXXXXXX. Es importante guardar este nombre ya que la segunda parte corresponde a la identificación del relé que la usaremos posteriormente.

- Conectarse a la red wifi creada por el relé
- Abrir en el navegador la dirección http://10.10.7.1/

![Imagen_03]


mdns-scan

{{< / borrador >}}

[atareao]: https://www.atareao.es/podcast/temperatura-con-la-raspberry/
[Adafruit-DHT]: https://pypi.org/project/Adafruit-DHT/
[clase Aemet]: https://github.com/sherlockes/SherloScripts/blob/master/python/etc/aemet.py
[DIY]: http://developers.sonoff.tech/sonoff-diy-mode-api-protocol.html
[eewlink]: https://sonoff.tech/ewelink
[jota]: https://github.com/domoticafacilconjota/capitulos/blob/master/temporada_1/S01E23/rester-ewelink
[transformador]: https://www.amazon.es/gp/product/B074CB1N7Z/ref=ppx_yo_dt_b_asin_title_o05_s00?ie=UTF8&psc=1
[relé wifi sonoff]: https://www.amazon.es/Interruptor-peque%C3%B1o-interruptor-soporte-funciona/dp/B07X1CHF3V/ref=sr_1_17?dchild=1&keywords=sonoff+mini&qid=1606301867&sr=8-17
[relé]: https://www.amazon.es/gp/product/B07CNR7K9B/ref=ppx_yo_dt_b_asin_title_o04_s00?ie=UTF8&psc=1

[Imagen_01]: /images/20201112_termostato_raspberry_01.jpg
[Imagen_02]: /images/20201112_termostato_raspberry_02.jpg
[Imagen_03]: /images/20201112_termostato_raspberry_03.jpg
