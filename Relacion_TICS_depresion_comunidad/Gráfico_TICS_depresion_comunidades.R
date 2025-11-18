library(dplyr)
library(ggplot2)
library(ggrepel)
 #Viene de gráfico de barras tic



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

View(tabla_tics_depresion_comunidades)

#--- 0. CARGAR LIBRERÍAS ---
library(dplyr)
library(ggplot2)
library(ggrepel) # (De tu práctica)

# (Asumimos que tu tabla 'tabla_maestra_final' ya existe)

#--- 1. CREAR LOS TRAMOS (BAJO, MEDIO, ALTO) ---
tabla_con_tramos <- tabla_tics_depresion_comunidades %>%
  # (Quitamos NAs para que ntile funcione)
  filter(!is.na(Frecuencia_Total_Adultos) & !is.na(Porcentaje_depresion)) %>%
  
  # (Usamos 'mutate' y 'ntile' para crear 3 grupos)
  mutate(
    # ntile(columna, 3) crea 3 grupos (1, 2, 3) de tamaño similar
    tramo_num = ntile(Frecuencia_Total_Adultos, 3),
    
    # (Usamos 'case_when' para ponerles etiquetas)
    Tramos_de_Uso = case_when(
      tramo_num == 1 ~ "Uso Bajo",
      tramo_num == 2 ~ "Uso Medio",
      tramo_num == 3 ~ "Uso Alto"
    )
  )
#--- 2. CREAR EL GRÁFICO (CON REGRESIÓN POR TRAMOS) ---
ggplot(tabla_con_tramos, 
       aes(x = Frecuencia_Total_Adultos, y = Porcentaje_depresion)) +
  
  # 1. Las Burbujas (geom_point)
  #    X = TICs, Y = Depresión
  #    TAMAÑO (size) = Desviación Estándar
  #    COLOR = Tramos (Bajo, Medio, Alto)
  geom_point(aes(color = Tramos_de_Uso, size = Desviacion_estandar_Adultos), alpha = 0.7) +
  
  # 2. Las Líneas de Regresión por Tramos (Tu idea)
  #    (Usamos la idea de tu práctica)
  geom_smooth(method = "lm", aes(color = Tramos_de_Uso), se = FALSE, na.rm = TRUE) + 
  
  # 3. Las Etiquetas (ggrepel)
  geom_text_repel(aes(label = Comunidad), na.rm = TRUE) +
  
  # 4. Títulos (labs)
  labs(
    title = "Correlación TICs vs. Depresión por Tramos de Uso",
    subtitle = "El tamaño de la burbuja indica la variabilidad (Desv. Est.) del uso de TICs",
    x = "Uso Promedio de TICs (Adultos, %)",
    y = "Prevalencia de Depresión (Cuadro mayor, %)",
    color = "Tramos de Uso (Terciles)",
    size = "Desv. Estándar de TICs"
  ) +

  theme_classic()

View(tabla_con_tramos)


#CONCLUSIÓN de este gráfico, tendría q aparecer una linea de tendencia pero no aparece pq los datos no están lo suficientemente correlacionados
#en nuestro gráfico de dispersión vemos que cad dato esta en unpunto bastante alejado poreque no hay una correlación entre la depresion y las tic
#el impacto de las tic en salud mental no es un factor geográfico lo que influye.

#Rechazo de la Hipótesis Geográfica: Tu gráfico de correlación (image_6579ea.png) demuestra que el simple hecho de vivir en una comunidad 
#con alto uso de TICs no se correlaciona con una mayor tasa de depresión a nivel regional. 
#(Tu observación sobre Ceuta y Melilla fue la prueba clave).