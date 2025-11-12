library(dplyr)

uso_tic<- mis_datos_tic$uso_internet_socioeconomico
uso_internet_com_niños<- mis_datos_tic$uso_internet_comunidades_niños
uso_internet_com_adultos<- mis_datos_tic$uso_internet_comunidades_adultos
uso_internet_com_mayores<- mis_datos_tic$`uso_internet_comunidades_mayores`

View(uso_tic)
View(uso_internet_com_adultos)
View(uso_internet_com_niños)
View(uso_internet_com_mayores)



uso_frecuente <- c(
  "Han utilizado internet semanalmente (al menos una vez a la semana)",
  "Han usado Internet diariamente (al menos 5 días a la semana)",
  "Han utilizado internet varias veces al día"
)

adultos_tabla<- uso_internet_com_adultos%>% 
  filter(Clase.de.población == "Usuarios de Internet en los últimos 3 meses", 
         Frecuencia.de.uso %in% uso_frecuente) %>% 
  select(Comunidad = Comunidades.y.Ciudades.Autónomas,
         Frecuencia = Frecuencia.de.uso,
         Poblacion = Clase.de.población,
         Porcentaje_adultos = Total
         ) %>% 
  mutate(Porcentaje_adultos = parse_number(Porcentaje_adultos, 
                                           locale = locale(decimal_mark = ",")))
View(adultos_tabla)


mayores_tabla<- uso_internet_com_mayores %>% 
  filter(Clase.de.población == "Usuarios de Internet en los últimos 3 meses (75 y más años)", 
         Frecuencia.de.uso %in% uso_frecuente) %>% 
  select(Comunidad = Comunidades.y.Ciudades.Autónomas,
         Frecuencia = Frecuencia.de.uso,
         Poblacion = Clase.de.población,
         Porcentaje_mayores = Total
         ) %>% 
  mutate(Porcentaje_mayores = parse_number(Porcentaje_mayores, 
                                           locale = locale(decimal_mark = ",")))

View(mayores_tabla)

niños_tabla<- uso_internet_com_niños %>% 
  filter(Principales.variables!= "Total Niños (10-15 años)")


View(niños_tabla)
