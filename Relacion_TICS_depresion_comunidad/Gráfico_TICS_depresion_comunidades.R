library(dplyr)
library(ggplot2)
library(ggrepel)

View(uso_tic_ordenada) #Viene de gráfico de barras tic


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
 
  geom_text_repel(aes(label = Comunidad)) +
  
  labs(
    title = "Correlación: Uso Frecuente de TICs vs. Depresión",
    subtitle = "Datos por Comunidad Autónoma (Adultos)",
    x = "Uso Promedio de TICs (Adultos, %)",
    y = "Prevalencia de Depresión (Cuadro mayor, %)"
  ) +
  theme_minimal() +
  theme(legend.position = "none")


#CONCLUSIÓN de este gráfico, tendría q aparecer una linea de tendencia pero no aparece pq los datos no están lo suficientemente correlacionados
#en nuestro gráfico de dispersión vemos que cad dato esta en unpunto bastante alejado poreque no hay una correlación entre la depresion y las tic
#el impacto de las tic en salud mental no es un factor geográfico lo que influye.

#Rechazo de la Hipótesis Geográfica: Tu gráfico de correlación (image_6579ea.png) demuestra que el simple hecho de vivir en una comunidad 
#con alto uso de TICs no se correlaciona con una mayor tasa de depresión a nivel regional. 
#(Tu observación sobre Ceuta y Melilla fue la prueba clave).