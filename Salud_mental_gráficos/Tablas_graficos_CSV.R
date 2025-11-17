

# --- 4. Preparación Gráfico 1 (Actividad) ---
# Este usa 'Prevalencia.depresión'
datos_grafico_actividad <- mis_datos_salud_mental$depresion_actividad_economica %>%
  
  rename(Porcentaje = Total) %>% 
  mutate(Porcentaje = as.numeric(sub(",", ".", Porcentaje, fixed = TRUE))) %>%
  
  filter(
    Sexo != "Ambos sexos",
    Actividad.económica != "TOTAL",        
    Prevalencia.depresión %in% c("Cuadro depresivo mayor", "Otros cuadros depresivos")
  )


g_actividad_apilado <- ggplot(datos_grafico_actividad,
                              aes(x = reorder(Actividad.económica, Porcentaje), 
                                  y = Porcentaje, 
                                  fill = Prevalencia.depresión)) +
  geom_col() + 
  facet_wrap(~ Sexo) + 
  coord_flip() + 
  labs(
    title = "Depresión por Actividad Económica y Sexo",
    subtitle = "Mostrando 'Cuadro depresivo mayor' y 'Otros cuadros depresivos'",
    x = "Actividad Económica",
    y = "Porcentaje Total de Prevalencia (%)",
    fill = "Prevalencia"
  ) +
  scale_fill_brewer(palette = "Reds") +
  theme_minimal()

print(g_actividad_apilado)

# --- 6. Preparación Gráfico 2 (Edad) ---
# Este usa 'Intensidad.depresión'
datos_grafico_edad <- mis_datos_salud_mental$depresion_sexo_y_grupo_de_edad %>%
  
  rename(Porcentaje = Total) %>% 
  mutate(Porcentaje = as.numeric(sub(",", ".", Porcentaje, fixed = TRUE))) %>%
  
  filter(
    Sexo != "Ambos sexos",
    Edad != "TOTAL", # Columna se llama 'Edad'
    Intensidad.depresión %in% c("Leve", "Moderada", "Moderadamente grave", "Grave")
  )

# --- 7. Gráfico 2 (Edad) ---
g_edad_apilado <- ggplot(datos_grafico_edad,
                         aes(x = Edad, 
                             y = Porcentaje, 
                             fill = Intensidad.depresión)) +
  geom_col() + 
  facet_wrap(~ Sexo) + 
  labs(
    title = "Intensidad de Depresión por Edad y Sexo",
    subtitle = "Mostrando niveles de 'Leve' a 'Grave' apilados",
    x = "Grupo de Edad",
    y = "Porcentaje Total de Prevalencia (%)",
    fill = "Intensidad"
  ) +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) 

print(g_edad_apilado)

# --- 8. Preparación Gráfico 3 (Comunidades) ---
# ¡¡CORRECCIÓN!! Este usa 'Prevalencia.depresión' (como nos has dicho)
datos_grafico_comunidades <- mis_datos_salud_mental$depresion_sexo_comunidades %>%
  
  rename(Porcentaje = Total) %>% 
  mutate(Porcentaje = as.numeric(sub(",", ".", Porcentaje, fixed = TRUE))) %>%
  
  filter(
    Sexo != "Ambos sexos",
    Comunidad.autónoma != "Total", # El 'Total' nacional
    # Usamos los mismos valores que en el Gráfico 1
    Prevalencia.depresión %in% c("Cuadro depresivo mayor", "Otros cuadros depresivos")
  )

# --- 9. Gráfico 3 (Comunidades) ---
# Usamos el mismo tipo de gráfico (apilado)
g_comunidades_apilado <- ggplot(datos_grafico_comunidades,
                                aes(x = reorder(Comunidad.autónoma, Porcentaje), 
                                    y = Porcentaje, 
                                    # Corregimos el 'fill'
                                    fill = Prevalencia.depresión)) +
  geom_col() + 
  facet_wrap(~ Sexo) + 
  coord_flip() + 
  labs(
    title = "Depresión por Comunidad Autónoma",
    subtitle = "Mostrando 'Cuadro depresivo mayor' y 'Otros cuadros depresivos'",
    x = "Comunidad Autónoma",
    y = "Porcentaje Total de Prevalencia (%)",
    fill = "Prevalencia"
  ) +
  scale_fill_brewer(palette = "Reds") + # Añadimos paleta de color
  theme_minimal()

print(g_comunidades_apilado)

