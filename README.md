# Impacto de las TIC en la Salud Mental
## Un análisis conjunto en R de la situación en España entre el uso de tecnología y la salud mental.

> **Seminario de R** | Asignatura: Fuentes de Datos Biomédicos y Web Semántica  
> **Grado:** Ingeniería de la Salud - Universidad de Burgos  
> **Autores:** Diego Ugarte López, Ivan Vallejo Cabrero

---

## 1. Introducción

Este repositorio contiene el trabajo práctico que hemos realizado para el seminario de la asignatura **Fuentes de Datos Biomédicos y Web Semántica**, del Grado en Ingeniería de la Salud (Universidad de Burgos).

La idea principal del proyecto surge de una duda bastante común: siempre escuchamos que la tecnología y las pantallas pueden ser perjudiciales para la salud mental, pero queríamos ver qué dicen realmente los datos.

Para ello, hemos descargado y procesado las encuestas oficiales del INE (Encuesta Nacional de Salud y Encuesta de Uso de TIC) y las hemos analizado utilizando R. Nuestro objetivo era cruzar estas dos fuentes de información para entender si el acceso a internet actúa como un factor de protección o de riesgo, especialmente cuando se combina con situaciones complicadas como el desempleo.

En este repositorio encontrarás todo el código que hemos escrito para limpiar los datos, generar los mapas por Comunidades Autónomas y crear las visualizaciones que comparan el nivel de estudios y la situación laboral con la depresión.

## 2. Objetivos

### Objetivo General
Analizar la interacción entre el uso de tecnologías (TICs) y sus distintos ámbitos para determinar su impacto conjunto sobre la prevalencia de **Depresión Mayor** en España.

### Objetivos Específicos
1.  **Medir el impacto real del desempleo:** Antes de mirar la tecnología, necesitábamos saber cuánto afecta el paro a la salud mental.
2.  **Evaluar la "Paradoja Tecnológica":** Determinar si un alto uso de Internet suaviza o agrava la depresión en grupos de riesgo como Estudiantes y desempleados.
3.  **Visualización Territorial:** Nos parecía fundamental llevar estos datos a un mapa para observar si existen diferencias notables entre las distintas Comunidades Autónomas.
4.  **Factor Educativo:** Otro de nuestros intereses era ver si el nivel de estudios tiene algo que ver en esta relación de TICs y salud mental.

---

## 3. Estructura del Repositorio

Para mantener el trabajo ordenado y que sea fácil de reproducir, hemos organizado los archivos en varias carpetas y documentos principales:

* **`Seminario.Rmd`**: Es el archivo principal del proyecto. Aquí es donde unimos todo el código, la narrativa y los gráficos para generar el informe final.
* **`Seminario.html`**: El resultado final. Es el informe ya compilado y listo para ver en cualquier navegador, con todos los gráficos interactivos funcionando.
* **`style.css`**: Un archivo de estilos que hemos creado para personalizar la apariencia del HTML y que no tenga el diseño "por defecto" de R.
* **`Scripts/`**: En esta carpeta hemos guardado los scripts de R individuales que utilizamos para limpiar los datos y crear los gráficos específicos antes de integrarlos en el informe final.
* **`INPUT/`**: Aquí almacenamos los datos tal y como los descargamos del INE (los archivos CSV y JSON originales).
* **`OUTPUT/`**: Esta carpeta contiene los archivos procesados, como el *Environment* (`.RData`), que permite cargar los datos ya limpios rápidamente sin tener que repetir todo el proceso desde cero.
* **`Seminario_Fuentes_Grupo_K.Rproj`**: El archivo de proyecto de RStudio. Es importante abrir RStudio desde aquí para que las rutas a los datos funcionen correctamente.
---

## 4. Resultados Clave

Después de cruzar los datos y generar las visualizaciones, hemos llegado a tres conclusiones principales que resumen lo que hemos encontrado:

* **El desempleo es el factor más crítico:** Los datos son contundentes. Estar en situación de desempleo aumenta la probabilidad de sufrir un cuadro depresivo mayor en comparación con las personas que están trabajando.

* **Uso idéntico de las TICs, diferente salud mental:** Hemos observado que dos grupos que usan internet con la misma intensidad (estudiantes y desempleados) tienen niveles de salud mental totalmente opuestos. 

* **La educación como factor de protección:** Existe una relación muy clara entre formación y salud. A medida que sube el nivel de estudios, aumenta el uso de la tecnología y disminuye drásticamente la tasa de depresión.
---

## 5. Instrucciones de Ejecución

Para reproducir este análisis en tu equipo local:

1.  **Clonar el repositorio:**
    ```bash
    git clone https://github.com/ivanvallejoo/Seminario_Fuentes_Grupo_K.git
    ```

2.  **Abrir el proyecto:** Haz doble clic en el archivo `.Rproj` para abrir RStudio. Esto configurará automáticamente las rutas de trabajo.

3.  **Instalar dependencias:** Copia y pega este código en la consola de R para instalar todas las librerías necesarias de una sola vez:
    ```r
    install.packages(c("tidyverse", "rmarkdown", "knitr", "ggthemes", 
                       "ggtext", "ggrepel", "ggforce", "patchwork", 
                       "sf", "mapSpain", "plotly", "jsonlite", "stringr"))
    ```

4.  **Generar el informe:** Abre el archivo `Seminario.Rmd` y pulsa el botón **Knit** (el icono del ovillo de lana) en la barra superior.

---

## 6. Referencias y Recursos

* **Lenguaje:** [R Project](https://www.r-project.org/)
* **Librerías Principales:** `tidyverse` (procesamiento), `ggplot2` y `plotly` (visualización), `mapSpain` (mapas).
* **Fuente de Datos:** Instituto Nacional de Estadística (INE) - [www.ine.es](https://www.ine.es)