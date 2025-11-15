library(dplyr)
library(ggplot2)
library(ggrepel)

View(uso_tic_ordenada)


uso_tic_adultos<- uso_tic_ordenada %>% 
  filter(Grupo_Edad == "Frecuencia_Total_Adultos",
         Comunidad != "Total nacional")

#Cojo solo adultos porque es el perfil que más utiliza las tic asi que usaremos

tabla_tics_depresion_comunidades<- uso_tic_adultos%>% 
  left_join(depresion_por_comunidades_corregido, by = "Comunidad") %>% 
  rename(Frecuencia_Total_Adultos = Frecuencia_Total)

View(tabla_tics_depresion_comunidades)

ggplot(tabla_tics_depresion_comunidades, 
       aes(x = Frecuencia_Total_Adultos, y = Porcentaje_depresion)) +
  
  geom_point(aes(color = Comunidad), size = 4) +

  geom_smooth(method = "lm", color = "black", na.rm = TRUE) + 
  
  # 5. Las Etiquetas (ggrepel)
  #    Para poner el nombre a cada punto
  #    (De tu práctica)
  geom_text_repel(aes(label = Comunidad)) +
  
  # 6. Los Títulos (labs)
  #    (De tu práctica)
  labs(
    title = "Correlación: Uso Frecuente de TICs vs. Depresión",
    subtitle = "Datos por Comunidad Autónoma (Adultos)",
    x = "Uso Promedio de TICs (Adultos, %)",
    y = "Prevalencia de Depresión (Cuadro mayor, %)"
  ) +
  
  # 7. El Estilo (theme_classic)
  #    (De tu práctica)
  theme_classic() +
  theme(legend.position = "none") # Oculta


#CONCLUSIÓN de este gráfico, tendría q aparecer un alinea de tendencia pero no aparece pq los datos no están lo suficientemente correlacionados
#en nuestro gráfico de dispersión vemos que cad dato esta en unpunto bastante alejado poreque no hay una correlación entre la depresion y las tic
#el impacto de las tic en salud mental no es un factor geográfico lo que influye.