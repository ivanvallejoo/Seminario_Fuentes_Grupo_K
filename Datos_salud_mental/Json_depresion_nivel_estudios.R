# 1. Instala jsonlite si no lo tienes
# install.packages("jsonlite")

library(jsonlite)
library(tidyr) # ¡Necesario para bind_rows()!

# 2. Define la URL de la API
url_api_ine <- "https://servicios.ine.es/wstempus/js/ES/DATOS_TABLA/47804"

datos_anidados<-jsonlite::fromJSON(url_api_ine)


tabla_completa <- tidyr::unnest(datos_anidados, cols = Data)

# 5. ¡Listo! Mira la tabla completa, limpia y aplanada
View(tabla_completa)

# 1. Carga la librería (es parte del Tidyverse, como dplyr)
library(tidyr)
library(dplyr)

# 2. Asumimos que tu tabla se llama "tabla_completa"
#    (la que creamos en el paso anterior)

tabla_separada <- tabla_completa %>%
  tidyr::separate(
    col = Nombre,  # La columna que quieres dividir
    
    # Los nombres de las nuevas columnas
    into = c("Sexo", "Edad", "Nivel_de_estudios", "Prevalencia_depresion"), 
    
    # El carácter que usa para separar (coma + espacio)
    sep = ", "
  )

# 3. ¡Listo! Mira tu nueva tabla, ahora con las columnas separadas
View(tabla_separada)