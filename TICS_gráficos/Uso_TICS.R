library(dplyr)
library(readr)

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



library(dplyr)
library(readr)


funcion_tic_adultos_mayores <- function(csv_tic, tipo_poblacion, uso_frecuente) {
  
  datos_limpios <- csv_tic %>%
    filter(
      # Usamos el nombre "limpio" (sin tilde) que genera R
      Clase.de.población == tipo_poblacion,
      Frecuencia.de.uso %in% uso_frecuente,
      Comunidades.y.Ciudades.Autónomas != "Total nacional"
    ) %>%
    select(
      Comunidad = Comunidades.y.Ciudades.Autónomas,
      Porcentaje = Total
    ) %>%
    mutate(
      Porcentaje = parse_number(Porcentaje, locale = locale(decimal_mark = ","))
    ) %>%
    group_by(Comunidad) %>%
    summarise(
      Frecuencia_Total = mean(Porcentaje, na.rm = TRUE),
      Desviacion_Estandar = sd(Porcentaje, na.rm = TRUE)
    )
  
  return(datos_limpios)
}


adultos_tabla <- funcion_tic_adultos_mayores(
  csv_tic = mis_datos_tic$uso_internet_comunidades_adultos,
  tipo_poblacion = "Total personas (16 a 74 años)",
  uso_frecuente = uso_frecuente #vector creado arriba
) %>%
  
  rename(
    Frecuencia_Total_Adultos = Frecuencia_Total,
    Desviacion_Estandar_Adultos = Desviacion_Estandar
  )


mayores_tabla <- funcion_tic_adultos_mayores(
  csv_tic = mis_datos_tic$uso_internet_comunidades_mayores, 
  tipo_poblacion = "Total personas (75 y más años)",
  uso_frecuente = uso_frecuente
) %>%
  rename(
    Frecuencia_Total_Mayores = Frecuencia_Total,
    Desviacion_Estandar_Mayores = Desviacion_Estandar
  )

View(adultos_tabla)
View(mayores_tabla)

niños_tabla<- uso_internet_com_niños %>% 
  filter(Principales.variables!= "Total Niños (10-15 años)",
         Comunidades.y.Ciudades.Autónomas!= "Total nacional") %>% 
  select(Comunidad = Comunidades.y.Ciudades.Autónomas,
         Tipo_poblacion_niños = Principales.variables,
         Porcentaje_niños = Total) %>% 
  mutate(Porcentaje_niños = parse_number(Porcentaje_niños,
                                           locale = locale(decimal_mark = ",")))

View(niños_tabla)


niños_tabla_pivotada<- niños_tabla %>%
  tidyr::pivot_wider(
    names_from = Tipo_poblacion_niños,
    values_from = Porcentaje_niños
  ) %>% 
  select(Comunidad,
         Niños_internet = `Niños usuarios de Internet en los últimos 3 meses`,
         Niños_ordenador = `Niños usuarios de ordenador en los últimos 3 meses`,
         Niños_con_movil = `Niños que disponen de teléfono móvil`
         )
View(niños_tabla_pivotada)

niños_tabla_final<- niños_tabla_pivotada %>% 
  rowwise() %>% 
  mutate(
    Frecuencia_Total_Niños = mean(
      c(Niños_internet, Niños_ordenador, Niños_con_movil), 
      na.rm = TRUE
    )
  ) %>% 
  select(Comunidad, Frecuencia_Total_Niños)

View(niños_tabla_final)


adultos_y_mayores <- adultos_tabla %>% 
  full_join(mayores_tabla, by = c("Comunidad"))

View(adultos_y_mayores)

uso_tic_total<- adultos_y_mayores %>% 
  full_join(niños_tabla_final, by = "Comunidad") %>% 
  select(Comunidad , Frecuencia_Total_Niños, Frecuencia_Total_Adultos, Frecuencia_Total_Mayores)

View(uso_tic_total)
