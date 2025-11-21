tabla_nivel_estudios <- nivel_estudios_parseado %>%
  tidyr::separate(
    col = Nombre,
    into = c("Sexo", "Edad", "Nivel_de_estudios", "Prevalencia_depresion"), 
    sep = ", "
  ) %>% 
  rename(Porcentaje = Valor) %>%  
  select(-Secreto)


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
