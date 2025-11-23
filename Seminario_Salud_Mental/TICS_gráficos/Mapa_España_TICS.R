library(ggplot2)
library(plotly)
library(dplyr)
library(mapSpain)
library(sf)


mapa_españa_ccaa <- esp_get_ccaa(moveCAN = TRUE)


# Corrección para mapa
uso_tic_total_corregido_mapa <- uso_tic_total %>%
  mutate(
    Comunidad = case_when(
      Comunidad == "Asturias, Principado de"~"Asturias",
      Comunidad == "Balears, Illes" ~ "Baleares",
      Comunidad == "Castilla - La Mancha" ~ "Castilla-La Mancha",
      Comunidad == "Comunitat Valenciana" ~ "Comunidad Valenciana",
      Comunidad == "Madrid, Comunidad de" ~ "Madrid",
      Comunidad == "Murcia, Región de" ~ "Murcia",
      Comunidad == "Navarra, Comunidad Foral de" ~ "Navarra",
      Comunidad == "Rioja, La" ~ "La Rioja",
      TRUE ~ Comunidad
    )
  )

mapa_con_datos <- mapa_españa_ccaa %>%
  left_join(uso_tic_total_corregido_mapa, by = c("ccaa.shortname.es" = "Comunidad"))




datos_mapa_coloreado <- mapa_con_datos %>%
  mutate(
    Uso_Global_Indice = (Frecuencia_Total_Adultos+ Frecuencia_Total_Niños+ Frecuencia_Total_Mayores)/3,
    
    
    tooltip_data = paste0(
      '<b>', ccaa.shortname.es, "</b><br>", 
      "--------------------------<br>",
      "Índice Global: ", round(Uso_Global_Indice, 1), "%<br>",
      "Adultos: ", round(Frecuencia_Total_Adultos, 1), "%<br>",
      "Niños: ", round(Frecuencia_Total_Niños, 1), "%<br>",
      "Mayores: ", round(Frecuencia_Total_Mayores, 1), "%"
    )
  )

mapa_intensidad <- ggplot(data = datos_mapa_coloreado) +
  geom_sf(
    aes(fill = Uso_Global_Indice, text = tooltip_data),
    color = "white", size = 0.2 
  ) +
  geom_sf_text(
    aes(label = ccaa.shortname.es), 
    size = 2,         
    color = "black",     
    fontface = "bold",
    check_overlap = TRUE 
  ) +

  scale_fill_gradient(
    low = "#EBF5FB",   
    high = "#21618C",  
    name = "Intensidad de Uso"
  ) +
  
  theme_void() +
  labs(title = "Intensidad del uso de TICs en España ") +
  theme(
    legend.position = "right",
    plot.title = element_text(hjust = 0.5, face = "bold")
  )


mapa_final_españa <- ggplotly(mapa_intensidad, tooltip = "text") %>%
  style(hoveron = "fills", traces = 1) %>% 
  layout(
    hoverlabel = list(bgcolor = "white", bordercolor = "black", font = list(color = "black"))
  )

htmlwidgets::saveWidget(
  widget = mapa_final_españa,
  file = "OUTPUT/figuras/mapa_interactivo_españa.html"
)

mapa_final_españa
