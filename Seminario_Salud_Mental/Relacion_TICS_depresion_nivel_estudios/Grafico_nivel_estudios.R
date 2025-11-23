library(ggplot2)
library(ggplot2)
library(dplyr)



max_tics <- max(tabla_nivel_estudios_final$Porcentaje_TICS, na.rm = TRUE)
max_depresion <- max(tabla_nivel_estudios_final$Porcentaje_Depresion, na.rm = TRUE)
factor_escala <- max_tics / max_depresion

grafico_nivel_estudios <- ggplot(tabla_nivel_estudios_final, 
       aes(x = as.numeric(factor(Nivel_de_estudios, 
                                 levels = c("Básico e inferior", "Intermedio", "Superior"))), 
           group = 1)) +
  
  geom_line(aes(y = Porcentaje_TICS, color = "Uso de TICs"), linewidth = 1.2) +
  geom_point(aes(y = Porcentaje_TICS, color = "Uso de TICs"), size = 4) +
  geom_text(aes(y = Porcentaje_TICS, label = round(Porcentaje_TICS, 1)), vjust = -1.5, fontface="bold") +
  
  geom_line(aes(y = Porcentaje_Depresion * factor_escala, color = "Depresión"), linewidth = 1.2) +
  geom_point(aes(y = Porcentaje_Depresion * factor_escala, color = "Depresión"), size = 4) +
  geom_text(aes(y = Porcentaje_Depresion * factor_escala, label = round(Porcentaje_Depresion, 1)), vjust = 2, fontface="bold") +
  
  scale_y_continuous(
    name = "Uso de TICs (%)",
    expand = expansion(mult = c(0.2, 0.2)), 
    sec.axis = sec_axis(~ . / factor_escala, name = "Depresión (%)")
  ) +
  
  scale_x_continuous(
    breaks = 1:3,
    labels = c("Básico e inferior", "Intermedio", "Superior"),
    name = "Nivel de Estudios"
  ) +
  
  labs(
    title = "Relación TICs y Depresión por Nivel de Estudios",
    subtitle = "Relación inversa entre adopción tecnológica y depresión",
    color = ""
  ) +
  theme_classic() +
  theme(legend.position = "bottom")

ggsave(
  filename = "OUTPUT/figuras/grafico_nivel_estudios.png",
  plot = grafico_nivel_estudios,
  width = 12,
  height = 8,
  dpi = 300,
  bg = "white"
)

View(tabla_nivel_estudios_final)
