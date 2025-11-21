library(dplyr)
library(ggplot2)
library(readr)


tabla_sitaucion_laboral <- mis_datos_salud_mental$depresion_actividad_economica %>%
  
  mutate(
    Porcentaje = parse_number(Total, locale = locale(decimal_mark = ","))
  ) %>%
  
  
  filter(
    Sexo != "Ambos sexos",
    Actividad.económica != "TOTAL",        
    Prevalencia.depresión %in% c("Cuadro depresivo mayor", "Otros cuadros depresivos")
  )

