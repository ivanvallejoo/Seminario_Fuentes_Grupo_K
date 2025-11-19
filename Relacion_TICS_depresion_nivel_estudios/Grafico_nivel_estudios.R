library(ggplot2)
library(ggplot2)
library(dplyr)


max_tics <- max(tabla_nivel_estudios_final$Porcentaje_TIC, na.rm = TRUE)
max_depresion <- max(tabla_nivel_estudios_final$Porcentaje_Depresion, na.rm = TRUE)
factor_escala <- max_tics / max_depresion


ggplot(tabla_nivel_estudios_final, 
       # Asumimos que en tu tabla: 1=Básico, 2=Intermedio, 3=Superior
       aes(x = as.numeric(factor(Nivel_de_estudios, 
                                 levels = c("Básico e inferior", "Intermedio", "Superior"))), 
           group = 1)) +
  
  geom_line(aes(y = Porcentaje_TICS, color = "Uso de TICs"), linewidth = 1.5) +
  geom_point(aes(y = Porcentaje_TICS, color = "Uso de TICs"), size = 4) +
  geom_text(aes(y = Porcentaje_TICS, label = round(Porcentaje_TICS, 1)), vjust = -1.5) +
  
  geom_line(aes(y = Porcentaje_Depresion * factor_escala, color = "Depresión"), linewidth = 1.5) +
  geom_point(aes(y = Porcentaje_Depresion * factor_escala, color = "Depresión"), size = 4) +
  geom_text(aes(y = Porcentaje_Depresion * factor_escala, label = round(Porcentaje_Depresion, 2)), vjust = 2) +
  
  
  scale_y_continuous(
    name = "Uso de TICs (%)",
    sec.axis = sec_axis(~ . / factor_escala, name = "Depresión (%)")
  ) +
  
  scale_x_continuous(
    breaks = 1:3,
    labels = c("Básico e inferior", "Intermedio", "Superior"),
    name = "Nivel de Estudios"
  ) +
  
  # --- COLORES Y TEMA ---
  scale_color_manual(values = c("Uso de TICs" = "#1f77b4", "Depresión" = "#d62728")) +
  
  labs(
    title = "Conclusión: El Nivel de Estudios como Factor Protector",
    subtitle = "A mayor nivel educativo, aumenta el uso de TICs y disminuye la depresión",
    color = "Indicador"
  ) +
  theme_classic() +
  theme(legend.position = "bottom")

View(tabla_nivel_estudios_final)
