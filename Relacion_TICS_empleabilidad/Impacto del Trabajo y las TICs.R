# ==============================================================================
# 0. CARGA DE LIBRERÍAS
# ==============================================================================
library(ggplot2)
library(dplyr)
library(stringr)
library(ggthemes)  # Estilos visuales (FiveThirtyEight)
library(ggtext)    # Títulos con formato HTML/Markdown
library(ggrepel)   # Evitar solapamiento de etiquetas
library(ggforce)   # Anotaciones inteligentes (elipses)
library(patchwork) # Composición de múltiples gráficos

# ==============================================================================
# 1. PROCESAMIENTO DE DATOS: CONTEXTO (SALUD MENTAL)
# ==============================================================================
df_contexto <- mis_datos_salud[["depresion_actividad_economica"]] %>%
  rename(Sexo = 1, Actividad = 2, Tipo_Depresion = 3, Porcentaje = 4) %>%
  # Filtro: Población general y casos graves de depresión
  filter(Sexo == "Ambos sexos", 
         Tipo_Depresion == "Cuadro depresivo mayor", 
         Actividad != "TOTAL") %>%
  mutate(
    Tasa_Depresion = as.numeric(gsub(",", ".", Porcentaje)),
    
    # Homologación de categorías para el cruce posterior
    Clave_Union = case_when(
      str_detect(Actividad, "Trabajando") ~ "Trabajando",
      str_detect(Actividad, "desempleo") ~ "En desempleo",
      str_detect(Actividad, "Estudiando") ~ "Estudiando",
      str_detect(Actividad, "Jubilado") ~ "Jubilado/Pensionista",
      str_detect(Actividad, "hogar") ~ "Labores del hogar",
      str_detect(Actividad, "Incapacitado") ~ "Incapacitado",
      TRUE ~ "Otros"
    ),
    
    # Lógica visual: Destacamos "En desempleo" en color rojo
    Color_Barra = ifelse(Clave_Union == "En desempleo", "#C0392B", "#95A5A6")
  ) %>%
  select(Clave_Union, Actividad, Tasa_Depresion, Color_Barra)

# ==============================================================================
# 2. PROCESAMIENTO DE DATOS: EL GIRO (TICs)
# ==============================================================================
df_tic_preparado <- mis_datos_tic[["uso_internet_socioeconomico"]] %>%
  rename(Grupo = 1, Caracteristicas = 2, Frecuencia = 3, Total = 4) %>%
  # Filtro: Nos interesa el uso intensivo (diario)
  filter(Grupo == "Total de personas (16 a 74 años)", 
         str_detect(Frecuencia, "diariamente")) %>%
  mutate(
    Tasa_Internet = as.numeric(gsub(",", ".", Total)),
    
    # Homologación: Traducimos categorías TIC al lenguaje de Salud
    Clave_Union = case_when(
      str_detect(Caracteristicas, "ocupados") ~ "Trabajando",
      str_detect(Caracteristicas, "parados") ~ "En desempleo",
      str_detect(Caracteristicas, "Estudiantes") ~ "Estudiando",
      str_detect(Caracteristicas, "Pensionistas") ~ "Jubilado/Pensionista",
      str_detect(Caracteristicas, "hogar") ~ "Labores del hogar",
      TRUE ~ "Otros"
    )
  ) %>%
  group_by(Clave_Union) %>%
  summarise(Tasa_Internet = mean(Tasa_Internet, na.rm = TRUE))

# ==============================================================================
# 3. UNIÓN DE TABLAS (DATA MERGING)
# ==============================================================================
# Cruzamos ambas bases usando la 'Clave_Union' como puente
df_final_narrativa <- left_join(df_contexto, df_tic_preparado, by = "Clave_Union") %>%
  filter(!is.na(Tasa_Internet))

print("Datos unificados correctamente:")
print(head(df_final_narrativa))

# ==============================================================================
# 4. VISUALIZACIÓN: GRÁFICO 1 (EL CONTEXTO)
# ==============================================================================
g1 <- ggplot(df_contexto, aes(x = reorder(Actividad, -Tasa_Depresion), y = Tasa_Depresion)) +
  # Barras con color condicional (Rojo para desempleo)
  geom_col(aes(fill = Color_Barra), width = 0.6, alpha = 0.9) + 
  
  # Etiquetas numéricas sobre las barras
  geom_text(aes(label = paste0(Tasa_Depresion, "%")), 
            vjust = -0.5, fontface = "bold", color = "#2C3E50", size = 3.5) +
  
  scale_fill_identity() +
  # Truco técnico: str_wrap parte los textos largos del eje X
  scale_x_discrete(labels = function(x) stringr::str_wrap(x, width = 10)) + 
  scale_y_continuous(limits = c(0, max(df_contexto$Tasa_Depresion) + 1.5)) +
  
  # Títulos con formato HTML (ggtext)
  labs(
    title = "<span style='font-size:14pt'>1. El Contexto</span>",
    subtitle = "El <span style='color:#C0392B'><b>Desempleo</b></span> es el factor crítico en la salud mental base.",
    x = "", y = ""
  ) +
  
  theme_fivethirtyeight() +
  theme(
    plot.title = element_markdown(face = "bold"),
    plot.subtitle = element_markdown(size = 10),
    axis.text.x = element_text(size = 8.5, face = "bold", lineheight = 0.9),
    axis.text.y = element_blank(),
    panel.grid.major = element_blank(),
    plot.background = element_rect(fill = "white", color = NA),
    panel.background = element_rect(fill = "white", color = NA)
  )

# ==============================================================================
# 5. VISUALIZACIÓN: GRÁFICO 2 (EL GIRO)
# ==============================================================================
g2 <- ggplot(df_final_narrativa, aes(x = Tasa_Internet, y = Tasa_Depresion)) +
  # Línea de tendencia
  geom_smooth(method = "lm", se = FALSE, color = "aquamarine1", linetype = "solid", size = 1) +
  
  # Puntos principales con borde blanco (estilo 'pop')
  geom_point(aes(fill = Clave_Union), size = 6, shape = 21, color = "white", stroke = 1.5) +
  
  # ggforce: Elipse para resaltar la paradoja (Estudiantes vs Parados)
  geom_mark_ellipse(aes(filter = Clave_Union %in% c("En desempleo", "Estudiando"),
                        label = Clave_Union,
                        description = "Perfiles opuestos"),
                    label.fontsize = 8, 
                    label.buffer = unit(5, "mm"),
                    con.cap = 0,
                    color = "grey50") +
  
  # ggrepel: Etiquetas para el resto de puntos sin solapamiento
  geom_text_repel(aes(label = Clave_Union), 
                  data = subset(df_final_narrativa, !Clave_Union %in% c("En desempleo", "Estudiando")),
                  size = 3.5, color = "grey40", point.padding = 0.5) +
  
  scale_fill_tableau() +
  labs(
    title = "<span style='font-size:14pt'>2. El Giro (TICs)</span>",
    subtitle = "Alta tecnología no garantiza salud mental: comparar <b style='color:#F28E2B'>Estudiantes</b> vs <b style='color:#E15759'>Parados</b>.",
    x = "Uso Diario de Internet (%)", 
    y = "Depresión Mayor (%)",
    caption = "Fuente: Elaboración propia con datos INE"
  ) +
  
  theme_minimal(base_size = 12) +
  theme(
    plot.title = element_markdown(face = "bold"),
    plot.subtitle = element_markdown(size = 10),
    legend.position = "none",
    axis.title = element_text(size = 9, face = "bold", color = "grey40"),
    panel.grid.minor = element_blank(),
    panel.grid.major = element_line(color = "grey95")
  )

# ==============================================================================
# 6. COMPOSICIÓN FINAL (PATCHWORK)
# ==============================================================================
layout_final <- g1 + g2 + 
  plot_annotation(
    title = 'IMPACTO DEL TRABAJO Y LA BRECHA DIGITAL EN LA SALUD MENTAL',
    subtitle = 'Análisis cruzado de Encuesta Europea de Salud y Encuesta TIC',
    theme = theme(plot.title = element_text(size = 18, face = "bold", hjust = 0.5))
  )

# Mostrar resultado final
print(layout_final)
