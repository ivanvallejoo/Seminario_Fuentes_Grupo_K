g_actividad_apilado <- ggplot(tabla_sitaucion_laboral,
                              aes(x = reorder(Actividad.económica, Porcentaje), 
                                  y = Porcentaje, 
                                  fill = Prevalencia.depresión)) +
  
  
  geom_col(stat = "identity") + 
  
  geom_text(
    aes(label = paste0(round(Porcentaje, 1), "%")), # Redondeamos a 1 decimal y añadimos %
    
    # position_stack(vjust = 0.5) coloca el número en el CENTRO de cada color
    # (Es la mejor forma para gráficos apilados)
    position = position_stack(vjust = 0.5),
    
    color = "black", 
    size = 2,        # Tamaño del texto
    fontface = "bold"
  )+
  
  # Dividimos el gráfico por Sexo
  facet_wrap(~ Sexo) +
  
  # Giramos el gráfico para que las etiquetas se lean bien
  coord_flip() + 
  
  # Etiquetas y Títulos
  labs(
    title = "Depresión por Situación Laboral y Sexo",
    x = "", # Dejamos vacío porque los nombres de actividad ya describen el eje
    y = "Porcentaje Total (%)",
    fill = "Diagnóstico"
  ) +
  
  # Paleta de colores y Tema
  scale_fill_brewer(palette = "Reds") +
  theme_minimal() +
  theme(
    legend.position = "bottom",
    plot.title = element_text(face = "bold")
  )

# Imprimir el gráfico
print(g_actividad_apilado)
