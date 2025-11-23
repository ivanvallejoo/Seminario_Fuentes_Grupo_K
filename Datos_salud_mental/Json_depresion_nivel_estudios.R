
library(jsonlite)
library(tidyr) 
library(dplyr)

# Url de la api
url_api_ine <- "https://servicios.ine.es/wstempus/js/ES/DATOS_TABLA/47804"

json_nivel_estudios<-jsonlite::fromJSON(url_api_ine)


nivel_estudios_parseado <- tidyr::unnest(json_nivel_estudios, cols = Data) 
#Función de paquete tidyr para sacar los valores contenidos en el datafame y añadirlos a la tabla.

View(nivel_estudios_parseado)



tabla_nivel_estudios_separada <- nivel_estudios_parseado %>%
  tidyr::separate(
    col = Nombre,
    into = c("Sexo", "Edad", "Nivel_de_estudios", "Prevalencia_depresion"), 
    sep = ", "
  ) %>% 
  rename(Porcentaje = Valor) %>%  
  select(-Secreto)


View(tabla_nivel_estudios_separada)

