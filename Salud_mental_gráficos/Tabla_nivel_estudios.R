datos_grafico_estudios <- tabla_nivel_estudios %>%
  filter(
    Sexo != "Ambos sexos",
    Nivel_de_estudios != "Total",
    Edad == "TOTAL", 
    
    Prevalencia_depresion %in% c("Cuadro depresivo mayor", "Otros cuadros depresivos")
  ) %>% 
  mutate(Nivel_de_estudios= factor(
    Nivel_de_estudios, levels = c("TOTAL", "Básico e inferior", "Intermedio","Superior" )
  )
  )

View(datos_grafico_estudios)