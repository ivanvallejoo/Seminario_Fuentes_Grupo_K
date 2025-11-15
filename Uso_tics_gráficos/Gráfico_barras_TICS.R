library(tidyr)
library(dplyr)  
library(ggplot2)

View(uso_tic_total_corregido)

uso_tic_total_pivotada<- uso_tic_total_corregido %>% 
  pivot_longer(
    cols= -Comunidad,
    names_to = "Grupo_Edad",
    values_to = "Frecuencia_Total"
  )

View(uso_tic_total_pivotada)

orden_grupos <- c(
  "Frecuencia_Total_Niños",
  "Frecuencia_Total_Adultos",
  "Frecuencia_Total_Mayores"
)

uso_tic_ordenada<- uso_tic_total_pivotada %>% 
  mutate(
    Grupo_Edad = factor(Grupo_Edad, levels = orden_grupos)
  )

View(uso_tic_ordenada)

ggplot(uso_tic_ordenada, aes(x=Comunidad, y=Frecuencia_Total, fill=Grupo_Edad))+
  geom_bar(stat = "identity", position = "dodge")+
  labs(
    title= "Perfil de Uso Frecuente de las TIC por Edad y Comunidad",
    y= "Porcentaje de Uso Promedio(%)",
    x= "Comunidad Autónoma",
    fill = "Grupo de Edad")+
  theme_classic()+
  theme(axis.text.x = element_text(angle = 60, hjust = 1))
