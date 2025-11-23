# Impacto de las TIC en la Salud Mental
## Un análisis conjunto en R de la situación en España entre el uso de tecnología y la salud mental.

> **Seminario de R** | Asignatura: Fuentes de Datos Biomédicos y Web Semántica  
> **Grado:** Ingeniería de la Salud - Universidad de Burgos  
> **Autores:** Diego Ugarte López, Ivan Vallejo Cabrero

---

## 1. Introducción

La salud mental es un fenómeno influenciado no solo por factores biológicos, sino fuertemente determinado por el entorno socioeconómico. En el contexto actual de digitalización acelerada, surge la necesidad de entender cómo interactúan los estresores clásicos (como el desempleo) con los nuevos determinantes tecnológicos (brecha digital y uso de TICs).

Aunque existe amplia literatura sobre el impacto negativo del desempleo, **se desconoce en gran medida si el acceso a la tecnología actúa como un factor protector (conectividad) o un estresor añadido** en poblaciones vulnerables. Este proyecto utiliza **R** y el ecosistema **Tidyverse** para procesar fuentes de datos heterogéneas (Encuestas Nacionales de Salud y TIC) y visualizar estas relaciones complejas.

## 2. Objetivos

### Objetivo General
Analizar la interacción entre el uso de tecnologías (TICs) y sus distintos ámbitos para determinar su impacto conjunto sobre la prevalencia de **Depresión Mayor** en España.

### Objetivos Específicos
1.  **Contextualizar el riesgo laboral:** Cuantificar la "Línea Base" del impacto del desempleo en la salud mental frente a otras situaciones.
2.  **Evaluar la "Paradoja Tecnológica":** Determinar si un alto uso de Internet mitiga o agrava la depresión en grupos de riesgo (Comparativa: *Estudiantes vs. Desempleados*).
3.  **Análisis Territorial:** Visualizar mediante mapas interactivos la distribución geográfica de la brecha digital por Comunidades Autónomas.
4.  **Factor Educativo:** Explorar el rol del nivel de estudios como variable protectora en esta ecuación.

---

## 3. Estructura del Repositorio

El proyecto se ha desarrollado siguiendo un flujo de trabajo reproducible, organizado en los siguientes módulos:

### Informe Principal
* **`Seminario.Rmd`**: Script maestro en *RMarkdown*. Integra todo el código, la narrativa y genera el informe final en HTML con estilos personalizados.
* **`style.css`**: Hoja de estilos personalizada.
* **`Enviroment_total.RData`**: Entorno de trabajo con los datos pre-procesados para una carga rápida.

### Scripts de Procesamiento
Limpieza de datos crudos, manejo de codificación y normalización de variables:
* `Procesamiento_CSV(Salud_Mental).R`: Ingesta de datos de actividad económica y edad.
* `Procesamiento_CSV(TIC).R`: Ingesta de datos de uso de internet y equipamiento.
* `Tabla y grafico JSON.R`: Procesamiento de datos provenientes de formato JSON.

### Scripts de Análisis y Visualización
* **La Paradoja (Empleo vs TICs):** `Impacto del Trabajo y las TICs.R` y `Gráfico_impacto_trabajo_TICS.R` (Genera el gráfico combinado de barras y dispersión).
* **Análisis Territorial:** `Mapa_España_TICS.R` (Generación de mapas con `mapSpain` y `plotly`) y `Uso_TICS.R`.
* **Factor Educativo:** `Grafico_nivel_estudios.R` (Gráfico de doble eje: TICs vs Depresión).
* **Contexto Salud:** `Tablas_graficos_CSV.R` (Gráficos de barras apiladas por edad y sexo).

### Datos (Fuente: INE)
Los datos brutos se organizan en carpetas temáticas:
* `INPUT/Datos_salud_mental/`: Encuesta Europea de Salud (`depresion_actividad_economica.csv`, etc.).
* `INPUT/Datos_tic/`: Encuesta de Uso de TIC (`uso_internet_socioeconomico.csv`, etc.).

---

## 4. Resultados Clave

El análisis visual arroja tres conclusiones principales:

1.  **El desempleo es el factor crítico:** La situación de desempleo triplica la prevalencia de cuadros depresivos mayores respecto a la población ocupada, siendo el predictor más fuerte.
2.  **La Paradoja Digital:** La tecnología no es un escudo universal. Se observa que grupos con **igual intensidad de uso digital** tienen resultados de salud mental opuestos:
    **Estudiantes:** Alta conexión, baja depresión.
    **Desempleados:** Alta conexión, muy alta depresión.
3.  **Educación como Factor Protector:** Existe una correlación inversa clara; a mayor nivel educativo, aumenta la adopción tecnológica y disminuye drásticamente la depresión.

---

## 5. Instrucciones de Ejecución

Para reproducir este análisis en tu equipo local:

1.  **Clonar el repositorio:**
    ```bash
    git clone [https://github.com/ivanvallejoo/Seminario_Fuentes_Grupo_K.git](https://github.com/ivanvallejoo/Seminario_Fuentes_Grupo_K.git)
    ```
2.  **Abrir el proyecto:** Abre el archivo `.Rproj` en RStudio.
3.  **Instalar dependencias:** Asegúrate de tener instaladas las librerías necesarias ejecutando en la consola de R:
    ```r
    install.packages(c("tidyverse", "rmarkdown", "knitr", "ggthemes", 
                       "ggtext", "ggrepel", "ggforce", "patchwork", 
                       "sf", "mapSpain", "plotly", "jsonlite", "stringr"))
    ```
4.  **Generar el informe:** Abre `Seminario.Rmd` y pulsa el botón **Knit**.

---

## 6. Referencias y Recursos

* **Lenguaje:** [R Project](https://www.r-project.org/)
* **Librerías Gráficas:** `ggplot2`, `patchwork`, `mapSpain`.
* **Fuente de Datos:** Instituto Nacional de Estadística (INE) - [www.ine.es](https://www.ine.es)