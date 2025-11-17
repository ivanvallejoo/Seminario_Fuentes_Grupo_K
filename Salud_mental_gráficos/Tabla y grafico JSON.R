
library(jsonlite)
library(tidyr)
library(dplyr)
library(ggplot2)




datos_grafico_estudios <- tabla_nivel_estudios_separada %>%
  filter(
    Sexo != "Ambos sexos",
    Nivel_de_estudios != "Total",
    
    # --- ¡LA CORRECCIÓN! ---
    # Ponemos "TOTAL" en mayúsculas, como en los datos reales
    Edad == "TOTAL", 
    
    Prevalencia_depresion %in% c("Cuadro depresivo mayor", "Otros cuadros depresivos")
  )

# --- 5. Gráfico de Barras Apiladas (Estudios) ---
# Este código de ggplot ESTÁ BIEN. No hay que cambiarlo.
g_estudios_apilado <- ggplot(datos_grafico_estudios,
                             aes(x = reorder(Nivel_de_estudios, Porcentaje), 
                                 y = Porcentaje, 
                                 fill = Prevalencia_depresion)) +
  geom_col() + 
  facet_wrap(~ Sexo) + 
  coord_flip() + 
  labs(
    title = "Depresión por Nivel de Estudios y Sexo",
    subtitle = "Mostrando 'Cuadro depresivo mayor' y 'Otros cuadros depresivos' (para 'Total' de edad)",
    x = "Nivel de Estudios",
    y = "Porcentaje Total de Prevalencia (%)",
    fill = "Prevalencia"
  ) +
  scale_fill_brewer(palette = "Reds") +
  theme_minimal()

# --- 6. Mostrar el Gráfico ---
# Ahora SÍ funcionará
print(g_estudios_apilado)

