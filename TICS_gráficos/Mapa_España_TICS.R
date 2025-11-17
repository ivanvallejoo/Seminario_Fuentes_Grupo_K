library(sf)
library(dplyr)
library(ggplot2)
library(plotly)
library(mapSpain)

mapa_españa_ccaa <- esp_get_ccaa(moveCAN = TRUE)

uso_tic_total_corregido <- uso_tic_total %>%
  mutate(
    Comunidad = case_when(
      Comunidad == "Andalucía" ~ "Andalucía",
      Comunidad == "Aragón" ~ "Aragón",
      Comunidad == "Asturias, Principado de" ~ "Asturias",
      Comunidad == "Balears, Illes" ~ "Baleares",
      Comunidad == "Canarias" ~ "Canarias",
      Comunidad == "Cantabria" ~ "Cantabria",
      Comunidad == "Castilla y León" ~ "Castilla y León",
      Comunidad == "Castilla - La Mancha" ~ "Castilla - La Mancha",
      Comunidad == "Comunitat Valenciana" ~ "Comunidad Valenciana",
      Comunidad == "Extremadura" ~ "Extremadura",
      Comunidad == "Galicia" ~ "Galicia",
      Comunidad == "Madrid, Comunidad de" ~ "Madrid",
      Comunidad == "Murcia, Región de" ~ "Murcia",
      Comunidad == "Navarra, Comunidad Foral de" ~ "Navarra",
      Comunidad == "País Vasco" ~ "País Vasco",
      Comunidad == "Rioja, La" ~ "La Rioja",
      Comunidad == "Ceuta" ~ "Ceuta",
      Comunidad == "Melilla" ~ "Melilla",
      
      TRUE ~ Comunidad
    )
  )

View(uso_tic_total)
# 2. Vuelve a realizar el join usando la tabla CORREGIDA:
mapa_con_datos <- mapa_españa_ccaa %>%
  left_join(uso_tic_total_corregido, by = c("ccaa.shortname.es" = "Comunidad"))
View(mapa_con_datos)
# 3. Preparación de la etiqueta personalizada (tooltip)
mapa_con_datos <- mapa_con_datos %>%
  mutate(
    tooltip_data = paste0(
      'Comunidad Autónoma: ', ccaa.shortname.es, "<br>", 
      "Uso Adultos: ", round(Frecuencia_Total_Adultos, 2), "%<br>",
      "Uso Niños: ", round(Frecuencia_Total_Niños, 2), "%<br>",
      "Uso Mayores: ", round(Frecuencia_Total_Mayores, 2), "%"
    )
  )

colores_ccaa <- c(
  # Comunidades Autónomas
  "Andalucía" = "#C0C0C0",           
  "Aragón" = "#FFD700",              
  "Asturias" = "#0000FF",            
  "Baleares" = "#800080",            
  "Canarias" = "#FFA500",            
  "Cantabria" = "#008000",           
  "Castilla y León" = "#B0C4DE",     
  "Castilla-La Mancha" = "#FF0000",
  "Comunidad Valenciana" = "#ADD8E6",
  "Extremadura" = "#8B4513",         
  "Galicia" = "#40E0D0",            
  "Madrid" = "#FFFF00",              
  "Murcia" = "#FFC0CB",              
  "Navarra" = "#A52A2A",             
  "País Vasco" = "#00FF00",          
  "La Rioja" = "#DA70D6",            
  "Ceuta" = "#4682B4",               
  "Melilla" = "#5F9EA0",
  "Cataluña" = "#FFDAB9"
  
)


mapa_estatico_gg <- ggplot(data = mapa_con_datos) +
  
  # CAPA 1: Geometrías del mapa y datos interactivos (el tooltip)
  geom_sf(
    # 'text' es el aesthetic que usa ggplotly para el tooltip de datos.
    aes(fill = ccaa.shortname.es, text = tooltip_data, key = ccaa.shortname.es),
    color = NA, 
    size = 0 
  ) +
  
  # CAPA 2: Nombres fijos en el centro de los polígonos
  # NO incluimos ningún aesthetic 'text' o 'label' para evitar tooltips duplicados aquí.
  geom_sf_text(
    aes(label = ccaa.shortname.es), 
    color = "black", 
    size = 2 
  ) +
  
  scale_fill_manual(values = colores_ccaa) +
  theme_void() +
  theme(legend.position = "none")


# 2. Convertimos el objeto ggplot en un objeto plotly
mapa_interactivo_gg <- ggplotly(
  mapa_estatico_gg,
  # Solo incluimos el 'text' (nuestra etiqueta de datos) en el tooltip
  tooltip = "text" 
)

# 3. Aplicamos el estilo de Plotly para lograr los efectos deseados
mapa_interactivo_final <- mapa_interactivo_gg %>%
  # CAMBIO A: Activa el hover en el relleno ('fills') para que el tooltip salte en el área.
  # El traces = 1 aplica esto a la capa geom_sf (el mapa).
  style(hoveron = "fills", traces = 1) %>% 
  
  # CAMBIO B: Aplica el estilo blanco al tooltip (etiqueta)
  layout(
    hoverlabel = list(
      bgcolor = "white",
      bordercolor = "black",
      font = list(color = "black")
    )
  )


mapa_interactivo_final
