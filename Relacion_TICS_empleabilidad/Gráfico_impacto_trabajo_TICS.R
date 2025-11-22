library(stringr)
library(ggthemes)  
library(ggtext)    
library(ggrepel)   
library(patchwork) 
library(ggplot2)
library(dplyr) 


grafico_salud_empleo <- df_salud_empleo %>% 
  ggplot(mapping = aes(x = reorder(Actividad, -Tasa_Depresion), y = Tasa_Depresion)) +
  
  
  geom_bar(stat = "identity", 
           aes(fill = Tasa_Depresion == max(Tasa_Depresion)), 
           width = 0.6, 
           alpha = 0.9) +
  
  geom_text(aes(label = paste0(Tasa_Depresion, "%")), 
            vjust = -0.5, 
            fontface = "bold", 
            colour = "#2C3E50", 
            size = 3.5) +
  
  
  scale_fill_manual(values = c("FALSE" = "#EBF5FB", "TRUE" = "#21618C"), guide = "none") +
  
  scale_y_continuous(expand = expansion(mult = c(0, .1))) +
  
  labs(
    x = NULL, 
    y = "Tasa de Depresión (%)",
    title = "Salud Mental en función de la Situación Laboral",
    subtitle = "El desempleo es el factor más crítico."
  ) +
  
  theme_classic() +
  theme(
    plot.title = element_text(face = "bold", size = 14, hjust = 0),
    axis.text.x = element_text(size = 9, face = "bold", color = "black"), 
    axis.text.y = element_blank(), 
    axis.ticks.y = element_blank(),
    axis.line.y = element_blank()
  )


print(grafico_salud_empleo)

# ==============================================================================
# 5. VISUALIZACIÓN: GRÁFICO 2 (EL GIRO)
# ==============================================================================
library(ggplot2)
library(ggrepel)
library(dplyr)

View(df_final)

grafico_depresion_tics_empleo<- df_final %>% 
  
  mutate(Grupo = case_when(
    Situacion_laboral == "Estudiando" ~ "Estudiantes",
    Situacion_laboral == "En desempleo" ~ "Parados",
    TRUE ~ "Otros" 
  )) %>% 
  
  ggplot(aes(x = Tasa_Internet, y = Tasa_Depresion)) +
  
  geom_smooth(method = "lm", 
              se = FALSE, 
              color = "black", 
              size = 1, linetype= 
                "dashed") +
  
  
  geom_point(aes(fill = Grupo), 
             size = 4, 
             shape = 21, 
             color = "white", 
             stroke = 1) +
  
  geom_text_repel(aes(label = Situacion_laboral), 
                  size = 3.5, 
                  color = "grey40",
                  box.padding = 0.6) +
  
  scale_fill_manual(values = c("Estudiantes" = "#F28E2B", 
                               "Parados" = "#21618C",     
                               "Otros" = "#EBF5FB")) +     
  
  
  labs(
    title = "Añadiendo las TICs",
    subtitle = "Comparativa: Estudiantes vs Parados",
    x = "Uso Diario de Internet (%)", 
    y = "Depresión Mayor (%)"
  ) +
  
  theme_classic() +
  theme(
    plot.title = element_text(face = "bold", size = 14),
    plot.subtitle = element_text(size = 11, color = "grey30"),
    axis.text = element_text(face = "bold")
  )

# Imprimir gráfico
print(grafico_depresion_tics_empleo)



# ==============================================================================
# 6. COMPOSICIÓN FINAL (PATCHWORK)
# ==============================================================================
 composicion_graficos_empleo<- grafico_salud_empleo / grafico_depresion_tics_empleo + 
  plot_annotation(
    title = 'IMPACTO DEL TRABAJO Y LA BRECHA DIGITAL EN LA SALUD MENTAL',
    theme = theme(plot.title = element_text(size = 16, face = "bold", hjust = 0.5))
  )


print(composicion_graficos_empleo)

