library(sf)
library(dplyr)
library(ggplot2)
library(plotly)
library(mapSpain)

mapa_españa_ccaa <- esp_get_ccaa(moveCAN = TRUE)

View(mapa_españa_ccaa)

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

mapa_con_datos <- mapa_españa_ccaa %>%
  left_join(uso_tic_total_corregido, by = c("ccaa.shortname.es" = "Comunidad"))
View(mapa_con_datos)

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
  
  geom_sf(
    aes(fill = ccaa.shortname.es, text = tooltip_data, key = ccaa.shortname.es),
    color = NA, 
    size = 0 
  ) +
  
  geom_sf_text(
    aes(label = ccaa.shortname.es), 
    color = "black", 
    size = 2 
  ) +
  
  scale_fill_manual(values = colores_ccaa) +
  theme_void() +
  theme(legend.position = "none")


mapa_interactivo_gg <- ggplotly(
  mapa_estatico_gg,
  tooltip = "text" 
)

mapa_interactivo_final <- mapa_interactivo_gg %>%
  style(hoveron = "fills", traces = 1) %>% 

  layout(
    hoverlabel = list(
      bgcolor = "white",
      bordercolor = "black",
      font = list(color = "black")
    )
  )


mapa_interactivo_final
