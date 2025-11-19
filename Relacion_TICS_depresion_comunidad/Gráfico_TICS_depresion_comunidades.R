library(dplyr)
library(ggplot2)
library(ggrepel)



uso_tic_adultos<-adultos_tabla%>% 
  filter(Comunidad != "Total nacional") %>% 
  mutate(
    Comunidad = case_when(
      Comunidad == "Andalucía" ~ "Andalucía",
      Comunidad == "Aragón" ~ "Aragón",
      Comunidad == "Asturias, Principado de" ~ "Asturias",
      Comunidad == "Balears, Illes" ~ "Baleares",
      Comunidad == "Canarias" ~ "Canarias",
      Comunidad == "Cantabria" ~ "Cantabria",
      Comunidad == "Castilla y León" ~ "Castilla y León",
      Comunidad == "Castilla - La Mancha" ~ "Castilla - La Mancha",
      Comunidad == "Comunitat Valenciana" ~ "Comunidad Valenciana",
      Comunidad == "Extremadura" ~ "Extremadura",
      Comunidad == "Galicia" ~ "Galicia",
      Comunidad == "Madrid, Comunidad de" ~ "Madrid",
      Comunidad == "Murcia, Región de" ~ "Murcia",
      Comunidad == "Navarra, Comunidad Foral de" ~ "Navarra",
      Comunidad == "País Vasco" ~ "País Vasco",
      Comunidad == "Rioja, La" ~ "La Rioja",
      Comunidad == "Ceuta" ~ "Ceuta",
      Comunidad == "Melilla" ~ "Melilla",
      
      TRUE ~ Comunidad
    ))

View(uso_tic_adultos)




#Cojo solo adultos porque es el perfil que más utiliza las tic asi que usaremos

tabla_tics_depresion_comunidades<- uso_tic_adultos%>% 
  left_join(depresion_por_comunidades_corregido, by = "Comunidad")

tabla_tics_depresion_comunidades$Porcentaje_depresion <- as.numeric( tabla_tics_depresion_comunidades$Porcentaje_depresion)


View(tabla_tics_depresion_comunidades)

ggplot(data = tabla_tics_depresion_comunidades, aes(x = Frecuencia_Total_Adultos, y = Porcentaje_depresion)) +
  
  geom_point(aes(colour = Comunidad), size = 3) +

  geom_smooth(method = "lm", se = TRUE, color = "black", linetype = "dashed") +
  
  geom_text_repel(aes(label = Comunidad), size = 3)+
  
  labs(
    title = "Relación entre Frecuencia Total de Adultos y % de Depresión",
    subtitle = "Línea de tendencia global",
    x = "Frecuencia Total Adultos",
    y = "Porcentaje de Depresión"
  ) +  
  guides(color= "none")+
  
  theme_minimal()

 
  
  ggplot(tabla_tics_depresion_comunidades, 
         aes(x = Frecuencia_Total_Adultos, y = Porcentaje_depresion)) +
  
  geom_point(aes(size = Desviacion_estandar_Adultos, color = Comunidad), alpha = 0.7) +

  geom_smooth(method = "lm", color = "red", se = FALSE) +
  
  geom_text_repel(aes(label = Comunidad), size = 3) +
  
  labs(
    title = "Correlación TICs vs Depresión (desv.estándar)",
    subtitle = "El tamaño del punto indica la Desviación Estándar (variabilidad) del uso de TICs",
    x = "Uso Promedio de TICs (Adultos, %)",
    y = "Prevalencia de Depresión (%)",
    size = "Desviación Estándar"
  ) +
    
  theme_classic() +
  guides(color= "none", size = "legend")

#CONCLUSIÓN de este gráfico, tendría q aparecer una linea de tendencia pero no aparece pq los datos no están lo suficientemente correlacionados
#en nuestro gráfico de dispersión vemos que cad dato esta en unpunto bastante alejado poreque no hay una correlación entre la depresion y las tic
#el impacto de las tic en salud mental no es un factor geográfico lo que influye.

#Rechazo de la Hipótesis Geográfica: Tu gráfico de correlación (image_6579ea.png) demuestra que el simple hecho de vivir en una comunidad 
#con alto uso de TICs no se correlaciona con una mayor tasa de depresión a nivel regional. 
#(Tu observación sobre Ceuta y Melilla fue la prueba clave).