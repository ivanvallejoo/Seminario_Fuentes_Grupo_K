library(dplyr)
library(readr)  # Para parse_number
library(tidyr)
library(ggplot2)

View(mis_datos_salud_mental$depresion_actividad_economica)
df_contexto <- mis_datos_salud_mental$depresion_actividad_economica %>%
  
  # 1. Renombrar usando nombres reales (Más seguro que el índice 1, 2...)
  rename(
    Actividad = `Actividad.económica`,
    Tipo_Depresion = `Prevalencia.depresión`,
    Porcentaje = Total
  ) %>%
  
  # 2. Filtros estándar
  filter(
    Sexo == "Ambos sexos",
    Tipo_Depresion == "Cuadro depresivo mayor",
    Actividad != "TOTAL"
  ) %>%
  
  mutate(
    # 3. ¡CORRECCIÓN CLAVE! Usamos parse_number (de tu práctica)
    Tasa_Depresion = parse_number(Porcentaje, locale = locale(decimal_mark = ",")),
    
    # 4. Usamos grepl() (R base) o igualdad exacta para homologar
    Clave_Union = case_when(
      # --- ESTA ES LA LÍNEA QUE FALTABA PARA QUE SALGA ROJO ---
      Actividad == "Parado/a" ~ "En desempleo",
      # ------------------------------------------------------
      Actividad == "Jubilado/a o prejubilado/a" ~ "Jubilado/Pensionista",
      Actividad == "Labores del hogar" ~ "Labores del hogar",
      Actividad == "Incapacitado/a para trabajar" ~ "Incapacitado",
      TRUE ~ "Otros"
    ),
    
    # 5. Lógica visual simple
    Color_Barra = ifelse(Clave_Union == "En desempleo", "#C0392B", "#95A5A6")
  ) %>%
  select(Clave_Union, Actividad, Tasa_Depresion, Color_Barra)

# ==============================================================================
# 2. DATOS TIC (Uso de Internet)
# ==============================================================================
View(mis_datos_tic$uso_internet_socioeconomico)


lista_frecuencias <- c(
  "Han usado Internet diariamente (al menos 5 días a la semana)",
  "Han utilizado internet varias veces al día"
)

df_tic_preparado <- mis_datos_tic$uso_internet_socioeconomico %>%
  
  # 1. Renombrar usando los nombres que genera make.names (sin tildes)
  rename(
    Grupo = Clase.de.población, 
    Características = Características.socioeconómicas, 
    Frecuencia = Frecuencia.de.uso, 
    Total_TIC = Total
  ) %>%
  
  # 2. Filtros (usando grepl para buscar "diariamente")
  filter(
    Grupo == "Total de personas (16 a 74 años)",
    Frecuencia %in% lista_frecuencias
    
  ) %>%
  
  mutate(
    # 3. Usamos parse_number otra vez
    Tasa_Internet = parse_number(Total_TIC, locale = locale(decimal_mark = ",")),
    
    # 4. Homologación con grepl (equivalente a str_detect)
    Clave_Union = case_when(
      Características == "Situación laboral: Activos ocupados" ~ "Trabajando",
      Características == "Situación laboral: Activos parados" ~ "En desempleo",
      Características == "Situación laboral: Inactivos: Estudiantes" ~ "Estudiando",
      Características == "Situación laboral: Inactivos: Pensionistas" ~ "Jubilado/Pensionista",
      Características == "Situación laboral: Inactivos: Labores del hogar" ~ "Labores del hogar",
      TRUE ~ "Otros"
    )
  ) %>%
  
  
  group_by(Clave_Union) %>%
  summarise(Tasa_Internet = mean(Tasa_Internet, na.rm = TRUE))

View(df_tic_preparado)
# ==============================================================================
# 3. UNIÓN FINAL
# ==============================================================================
df_final<- left_join(df_contexto, df_tic_preparado, by = "Clave_Union") %>%
  filter(!is.na(Tasa_Internet)) %>% 
  select(Clave_Union, Tasa_Depresion, Tasa_Internet, Color_Barra)

View(df_final)