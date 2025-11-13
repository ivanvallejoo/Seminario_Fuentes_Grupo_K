# --- 1. Carga de Librerías ---
library(jsonlite)
library(tidyr)
library(dplyr)
library(ggplot2)

# --- 2. Cargar Datos desde la API del INE ---
# Esto crea el JSON
url_api_ine <- "https://servicios.ine.es/wstempus/js/ES/DATOS_TABLA/47804"
json_nivel_estudios <- jsonlite::fromJSON(url_api_ine)

# --- 3. Procesar y Limpiar el JSON ---
# Esto crea la tabla 'tabla_nivel_estudios_base' CORRECTAMENTE
tabla_nivel_estudios_base <- tidyr::unnest(json_nivel_estudios, cols = Data) %>%
  tidyr::separate(
    col = Nombre,
    # ¡Aquí se crea 'Prevalencia_depresion' con guion bajo!
    into = c("Sexo", "Edad", "Nivel_de_estudios", "Prevalencia_depresion"), 
    sep = ", "
  ) %>%
  dplyr::rename(Porcentaje = Valor) %>%
  dplyr::select(-Secreto) %>%
  dplyr::mutate(Porcentaje = as.numeric(sub(",", ".", Porcentaje, fixed = TRUE)))

# --- 4. Preparación del Gráfico (CORREGIDO) ---
datos_grafico_estudios <- tabla_nivel_estudios_base %>%
  filter(
    Sexo != "Ambos sexos",
    Nivel_de_estudios != "Total",
    
    # --- ¡LA CORRECCIÓN! ---
    # Ponemos "TOTAL" en mayúsculas, como en los datos reales
    Edad == "TOTAL", 
    
    Prevalencia_depresion %in% c("Cuadro depresivo mayor", "Otros cuadros depresivos")
  )

# --- 5. Gráfico de Barras Apiladas (Estudios) ---
# Este código de ggplot ESTÁ BIEN. No hay que cambiarlo.
g_estudios_apilado <- ggplot(datos_grafico_estudios,
                             aes(x = reorder(Nivel_de_estudios, Porcentaje), 
                                 y = Porcentaje, 
                                 fill = Prevalencia_depresion)) +
  geom_col() + 
  facet_wrap(~ Sexo) + 
  coord_flip() + 
  labs(
    title = "Depresión por Nivel de Estudios y Sexo",
    subtitle = "Mostrando 'Cuadro depresivo mayor' y 'Otros cuadros depresivos' (para 'Total' de edad)",
    x = "Nivel de Estudios",
    y = "Porcentaje Total de Prevalencia (%)",
    fill = "Prevalencia"
  ) +
  scale_fill_brewer(palette = "Reds") +
  theme_minimal()

# --- 6. Mostrar el Gráfico ---
# Ahora SÍ funcionará
print(g_estudios_apilado)

