ggplot(df_final, aes(x = Tasa_Internet, y = Tasa_Depresion)) +
  
  # Línea de tendencia (sin la sombra de error 'se=FALSE')
  geom_smooth(method = "lm", se = FALSE, color = "turquoise", size = 1) +
  
  # Puntos grandes
  geom_point(aes(color = Clave_Union), size = 5) +
  
  # Etiquetas inteligentes (ggrepel) para que no se monten
  geom_text_repel(aes(label = Clave_Union), size = 4, fontface = "bold") +
  
  # Títulos y estilo
  labs(
    title = "2. La Paradoja: Estudiantes vs. Parados",
    subtitle = "Ambos grupos usan mucho Internet (Eje X), pero su depresión (Eje Y) es opuesta",
    x = "Uso Diario de Internet (%)", 
    y = "Tasa de Depresión Mayor (%)"
  ) +
  theme_minimal() +
  theme(legend.position = "none") 

