
library(jsonlite)
library(tidyr)
library(dplyr)
library(ggplot2)


  
grafico_nivel_estudios<- ggplot(datos_grafico_estudios,
                             aes(x = Nivel_de_estudios,
                                 y = Porcentaje, 
                                 fill = Prevalencia_depresion)) +
  geom_col() + 
  facet_wrap(~ Sexo) + 
  coord_flip() + 
  labs(
    title = "Depresión por Nivel de Estudios y Sexo",
    subtitle = "Cuadro depresivo mayor y Otros cuadros depresivos",
    x = "Nivel de Estudios",
    y = "Porcentaje Total de Prevalencia (%)",
    fill = "Prevalencia"
  ) +
  scale_fill_brewer(palette = "Reds") +
  theme_minimal()


print(grafico_apilado)

