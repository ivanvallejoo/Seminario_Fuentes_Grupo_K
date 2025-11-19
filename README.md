# Seminario de R: Determinantes Socioeconómicos y Digitales de la Salud Mental

Repositorio desarrollado para el seminario de la asignatura "Fuentes de Datos Biomédicos y Web Semántica", del grado de Ingeniería de la Salud de la Universidad de Burgos.

***

## 1. Introducción
La salud mental es un fenómeno multidimensional influenciado no solo por factores biológicos, sino fuertemente determinado por el entorno socioeconómico. En el contexto actual de digitalización acelerada, surge la necesidad de entender cómo interactúan los estresores clásicos (como el desempleo) con los nuevos determinantes tecnológicos (brecha digital y uso de TICs).

Aunque existe amplia literatura sobre el impacto negativo del desempleo en la salud mental, **se desconoce en gran medida si el acceso a la tecnología actúa como un factor protector (conectividad) o un estresor añadido** en poblaciones vulnerables. Este seminario utiliza herramientas analíticas de **R** y el ecosistema **Tidyverse** para procesar fuentes de datos heterogéneas (Encuestas Nacionales de Salud y TIC) y dilucidar estas relaciones.

## 2. Objetivos

### Objetivo General
Analizar la interacción entre la situación laboral, el nivel educativo y el uso de tecnologías (TICs) para determinar su impacto conjunto sobre la prevalencia de **Depresión Mayor** en España.

### Objetivos Específicos
1.  **Contextualizar el riesgo laboral:** Cuantificar la "Línea Base" del impacto del desempleo en la salud mental frente a otras situaciones (ocupados, estudiantes).
2.  **Evaluar la "Paradoja Tecnológica":** Determinar si un alto uso de Internet mitiga o agrava la depresión en grupos de riesgo (comparativa Estudiantes vs. Parados).
3.  **Análisis Territorial:** Visualizar mediante mapas la distribución geográfica de la brecha digital y la depresión por Comunidades Autónomas.
4.  **Factor Educativo:** Explorar el rol del nivel de estudios como variable estructural en esta ecuación.

---

## 3. Estructura del Repositorio y Metodología

El análisis se ha desarrollado siguiendo un flujo de trabajo reproducible en R, organizado en los siguientes módulos:

### 📄 Informe Principal
* **`Seminario.Rmd`**: Script maestro en RMarkdown que integra narrativa, código y visualización. Genera el informe final en HTML.
* **`Enviroment_total.RData`**: Entorno con los datos pre-procesados para optimizar la carga.
* **`style.css`**: Hoja de estilos para el renderizado del informe.

### 🛠️ Scripts de Procesamiento (ETL)
Funciones diseñadas para la ingesta y limpieza de datos crudos (manejo de encoding, decimales y normalización):
* `Procesamiento_CSV(Salud_Mental).R`
* `Procesamiento_CSV(TIC).R`
* `Json_depresion_nivel_estudios.R` (Conexión a API INE)

### 📊 Scripts de Análisis y Visualización
* **Impacto y Cruce:** `Analisis_Impacto.R` (Lógica del *join* entre Salud y TICs).
* **Territorio:** `Mapa_España_TICS.R` y `Gráfico_TICS_depresion_comunidades.R`.
* **Educación:** `Grafico_nivel_estudios.R` y `Relación_TIC_estudios_socioeconómico.R`.
* **Descriptivo:** `Uso_TICS.R` y `Gráfico_barras_TICS.R`.

### 💾 Fuentes de Datos Utilizadas
Los datos, provenientes del **Instituto Nacional de Estadística (INE)**, se encuentran en las carpetas:
* [cite_start]`/Datos_salud_mental/`: Incluye *Encuesta Europea de Salud* (`depresion_actividad_economica.csv` [cite: 16][cite_start], `depresion_sexo_comunidades.csv`[cite: 1], etc.).
* [cite_start]`/Datos_tic/`: Incluye *Encuesta de Uso de TIC* (`uso_internet_socioeconomico.csv` [cite: 5][cite_start], `uso_internet_comunidades_adultos.csv`[cite: 2], etc.).

---

## 4. Resultados y Conclusiones Generales

A través del análisis visual, el seminario arroja las siguientes conclusiones:

1.  **El desempleo es el factor crítico:** Se confirma que estar en situación de desempleo triplica la prevalencia de cuadros depresivos mayores respecto a la población ocupada.
2.  **La tecnología no es un escudo universal:** Se identifica una paradoja donde el alto uso de TICs correlaciona con baja depresión en estudiantes, pero con alta depresión en desempleados. Esto sugiere que la tecnología amplifica el estado base del individuo o que el uso en desempleados puede estar ligado a la búsqueda activa de empleo (estrés) o evasión.
3.  **Brecha Territorial:** Existen disparidades significativas entre Comunidades Autónomas, donde las regiones con menor infraestructura digital no siempre son las que presentan peor salud mental, sugiriendo factores culturales protectores.

---

## 5. Instrucciones de Ejecución

Para reproducir este análisis:

1.  Clonar el repositorio.
2.  Abrir el proyecto en RStudio.
3.  Instalar las dependencias necesarias:
    ```r
    install.packages(c("tidyverse", "ggrepel", "rmarkdown", "knitr", "ggthemes", "ggforce", "patchwork", "sf", "jsonlite"))
    ```
4.  Compilar el archivo **`Seminario.Rmd`** pulsando el botón **Knit** para generar el informe `Seminario.html`.

---

## 6. Referencias y Recursos

* **R for Data Science:** Wickham, H., & Grolemund, G.
* **ggplot2: Elegant Graphics for Data Analysis:** Wickham, H.
* **Fuentes de Datos:** Instituto Nacional de Estadística (INE) - [www.ine.es](https://www.ine.es)