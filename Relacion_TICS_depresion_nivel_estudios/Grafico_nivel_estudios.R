max_tics <- max(tabla_nivel_estudios_final$Porcentaje_TICS, na.rm = TRUE)
max_depresion <- max(tabla_nivel_estudios$Porcentaje_Depresion, na.rm = TRUE)
factor_escala <- max_tics / max_depresion


ggplot(tabla_nivel_estudios_final, 
       aes(x = Nivel_de_estudios, group = 1)) +
  
  geom_line(aes(y = Porcentaje_TICS, color = "Uso de TICs"), linewidth = 1.5) +
  
  geom_point(aes(y = Porcentaje_TICS, color = "Uso de TICs"), size = 4) +
  
  geom_text(aes(y = Porcentaje_TICS, label = round(Porcentaje_TICS, 1)), vjust = -1.5) +

  geom_line(aes(y = Porcentaje_Depresion * factor_escala, color = "Depresión"), linewidth = 1.5) +
  
  geom_point(aes(y = Porcentaje_Depresion * factor_escala, color = "Depresión"), size = 4) +
  
  geom_text(aes(y = Porcentaje_Depresion * factor_escala, 
                label = round(Porcentaje_Depresion, 1)), vjust = -1.5) +
  
  scale_y_continuous(
    name = "Uso de TICs (%)",
    sec.axis = sec_axis(~ . / factor_escala, name = "Depresión (%)")
  ) +
  
  labs(
    title = "Relación Inversa: TICs vs. Depresión por Nivel de Estudios",
    x = "Nivel de Estudios",
    color = "Métrica"
  ) +
  theme_classic()
