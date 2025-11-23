library(dplyr)
library(readr)
library(tidyr)
library(ggplot2)

View(mis_datos_salud_mental$depresion_actividad_economica)


df_salud_empleo <- mis_datos_salud_mental$depresion_actividad_economica %>%
  rename(
    Actividad = `Actividad.económica`,
    Tipo_Depresion = `Prevalencia.depresión`,
    Porcentaje = Total
  ) %>%
  filter(
    Sexo == "Ambos sexos",
    Tipo_Depresion == "Cuadro depresivo mayor",
    Actividad != "TOTAL"
  ) %>%
  mutate(
    Tasa_Depresion = parse_number(Porcentaje, locale = locale(decimal_mark = ",")),
    Situacion_laboral = case_when(
      Actividad %in% c("Parado/a", "Parados", "En desempleo", "Desempleado") ~ "En desempleo",
      Actividad == "Jubilado/a o prejubilado/a" ~ "Jubilado/Pensionista",
      Actividad == "Labores del hogar" ~ "Labores del hogar",
      Actividad == "Incapacitado/a para trabajar" ~ "Incapacitado",
      Actividad == "Estudiando"~"Estudiando",
      Actividad == "Trabajando"~"Trabajando",
      TRUE ~ "Otros"
    )
  )

View(df_salud_empleo)

# ==============================================================================
# 2. DATOS TIC (Uso de Internet)
# ==============================================================================
View(mis_datos_tic$uso_internet_socioeconomico)


lista_frecuencias <- c(
  "Han usado Internet diariamente (al menos 5 días a la semana)",
  "Han utilizado internet varias veces al día"
)

df_tic_empleo <- mis_datos_tic$uso_internet_socioeconomico %>%
  
  rename(
    Grupo = Clase.de.población, 
    Características = Características.socioeconómicas, 
    Frecuencia = Frecuencia.de.uso, 
    Total_TIC = Total
  ) %>%
  
  filter(
    Grupo == "Total de personas (16 a 74 años)",
    Frecuencia %in% lista_frecuencias
    
  ) %>%
  
  mutate(
 
    Tasa_Internet = parse_number(Total_TIC, locale = locale(decimal_mark = ",")),
    
    Situacion_laboral = case_when(
      Características == "Situación laboral: Activos ocupados" ~ "Trabajando",
      Características == "Situación laboral: Activos parados" ~ "En desempleo",
      Características == "Situación laboral: Inactivos: Estudiantes" ~ "Estudiando",
      Características == "Situación laboral: Inactivos: Pensionistas" ~ "Jubilado/Pensionista",
      Características == "Situación laboral: Inactivos: Labores del hogar" ~ "Labores del hogar",
      TRUE ~ "Otros"
    )
  ) %>%
  
  
  group_by(Situacion_laboral) %>%
  summarise(Tasa_Internet = mean(Tasa_Internet, na.rm = TRUE))

View(df_tic_empleo)
# ==============================================================================
# 3. UNIÓN FINAL
# ==============================================================================
df_final<- left_join(df_salud_empleo, df_tic_empleo, by = "Situacion_laboral") %>%
  filter(!is.na(Tasa_Internet)) %>% 
  select(Situacion_laboral, Tasa_Depresion, Tasa_Internet)

View(df_final)
