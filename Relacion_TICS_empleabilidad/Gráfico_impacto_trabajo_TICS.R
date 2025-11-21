library(stringr)
library(ggthemes)  # Estilos visuales (FiveThirtyEight)
library(ggtext)    # Títulos con formato HTML/Markdown
library(ggrepel)   # Evitar solapamiento de etiquetas
library(ggforce)   # Anotaciones inteligentes (elipses)
library(patchwork) # Composición de múltiples gráficos
library(ggplot2)

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
    subtitle = "Alta tecnología no garantiza salud mental: comparar <b style='color:#F28E2B'>Estudiantes</b> vs <b style='color:#094B5B'>Parados</b>.",
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

