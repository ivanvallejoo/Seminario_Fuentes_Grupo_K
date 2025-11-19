# ==============================================================================
# 0. CARGA DE LIBRERÍAS
# ==============================================================================
library(ggplot2)
library(dplyr)
library(stringr)
library(ggthemes)  # Estilos visuales (FiveThirtyEight)
library(ggtext)    # Títulos con formato HTML/Markdown
library(ggrepel)   # Evitar solapamiento de etiquetas
library(ggforce)   # Anotaciones inteligentes (elipses)
library(patchwork) # Composición de múltiples gráficos

# ==============================================================================
# 1. PROCESAMIENTO DE DATOS: CONTEXTO (SALUD MENTAL)
# ==============================================================================
df_contexto <- mis_datos_salud_mental$depresion_actividad_economica %>%
  rename(Sexo = 1, Actividad = 2, Tipo_Depresion = 3, Porcentaje = 4) %>%
  # Filtro: Población general y casos graves de depresión
  filter(Sexo == "Ambos sexos", 
         Tipo_Depresion == "Cuadro depresivo mayor", 
         Actividad != "TOTAL") %>%
  mutate(
    Tasa_Depresion = as.numeric(gsub(",", ".", Porcentaje)),
    
    # Homologación de categorías para el cruce posterior
    Clave_Union = case_when(
      str_detect(Actividad, "Trabajando") ~ "Trabajando",
      str_detect(Actividad, "desempleo") ~ "En desempleo",
      str_detect(Actividad, "Estudiando") ~ "Estudiando",
      str_detect(Actividad, "Jubilado") ~ "Jubilado/Pensionista",
      str_detect(Actividad, "hogar") ~ "Labores del hogar",
      str_detect(Actividad, "Incapacitado") ~ "Incapacitado",
      TRUE ~ "Otros"
    ),
    
    # Lógica visual: Destacamos "En desempleo" en color rojo
    Color_Barra = ifelse(Clave_Union == "En desempleo", "#C0392B", "#95A5A6")
  ) %>%
  select(Clave_Union, Actividad, Tasa_Depresion, Color_Barra)

# ==============================================================================
# 2. PROCESAMIENTO DE DATOS: EL GIRO (TICs)
# ==============================================================================
df_tic_preparado <- mis_datos_tic$uso_internet_socioeconomico %>%
  rename(Grupo = 1, Caracteristicas = 2, Frecuencia = 3, Total = 4) %>%
  # Filtro: Nos interesa el uso intensivo (diario)
  filter(Grupo == "Total de personas (16 a 74 años)", 
         str_detect(Frecuencia, "diariamente")) %>%
  mutate(
    Tasa_Internet = as.numeric(gsub(",", ".", Total)),
    
    # Homologación: Traducimos categorías TIC al lenguaje de Salud
    Clave_Union = case_when(
      str_detect(Caracteristicas, "ocupados") ~ "Trabajando",
      str_detect(Caracteristicas, "parados") ~ "En desempleo",
      str_detect(Caracteristicas, "Estudiantes") ~ "Estudiando",
      str_detect(Caracteristicas, "Pensionistas") ~ "Jubilado/Pensionista",
      str_detect(Caracteristicas, "hogar") ~ "Labores del hogar",
      TRUE ~ "Otros"
    )
  ) %>%
  group_by(Clave_Union) %>%
  summarise(Tasa_Internet = mean(Tasa_Internet, na.rm = TRUE))

# ==============================================================================
# 3. UNIÓN DE TABLAS (DATA MERGING)
# ==============================================================================
# Cruzamos ambas bases usando la 'Clave_Union' como puente
df_final_narrativa <- left_join(df_contexto, df_tic_preparado, by = "Clave_Union") %>%
  filter(!is.na(Tasa_Internet))

print("Datos unificados correctamente:")
print(head(df_final_narrativa))


