
library(dplyr)
df_depresion<- mis_datos_salud_mental$depresion_sexo_comunidades

View(df_depresion)

depresion_por_comunidades<- df_depresion %>% 
  filter(Prevalencia.depresión == "Cuadro depresivo mayor",
         Sexo == "Ambos sexos",
         Comunidad.autónoma != "Total") %>% 
  select(Comunidad = Comunidad.autónoma,
         Porcentaje_depresion = Total
         )
View(depresion_por_comunidades)

depresion_por_comunidades_corregido<- depresion_por_comunidades %>% 
  mutate(
    Comunidad = case_when(
      Comunidad == "Andalucía" ~ "Andalucía",
      Comunidad == "Aragón" ~ "Aragón",
      Comunidad == "Asturias (Principado de)" ~ "Asturias",
      Comunidad == "Balears (Illes)" ~ "Baleares",
      Comunidad == "Canarias" ~ "Canarias",
      Comunidad == "Cantabria" ~ "Cantabria",
      Comunidad == "Castilla y León" ~ "Castilla y León",
      Comunidad == "Castilla -La Mancha" ~ "Castilla - La Mancha",
      Comunidad == "Comunitat Valenciana" ~ "Comunidad Valenciana",
      Comunidad == "Extremadura" ~ "Extremadura",
      Comunidad == "Galicia" ~ "Galicia",
      Comunidad == "Madrid (Comunidad de)" ~ "Madrid",
      Comunidad == "Murcia (Región de)" ~ "Murcia",
      Comunidad == "Navarra (Comunidad Foral de)" ~ "Navarra",
      Comunidad == "País Vasco" ~ "País Vasco",
      Comunidad == "Rioja (La)" ~ "La Rioja",
      Comunidad == "Ceuta (Ciudad Autónoma de)" ~ "Ceuta",
      Comunidad == "Melilla (Ciudad Autónoma de)" ~ "Melilla",
      
      TRUE ~ Comunidad
    ),
    Porcentaje_depresion = parse_number(Porcentaje_depresion, locale = locale(decimal_mark = ","))
  )
View(depresion_por_comunidades_corregido)
