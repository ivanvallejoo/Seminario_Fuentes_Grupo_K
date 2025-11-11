library(readr)
leer_mi_csv <- function(ruta_archivo, delimitador) {
  
  print(paste("Intentando cargar:", ruta_archivo, "con delimitador:", shQuote(delimitador)))
  
  df <- read.csv(
    file = ruta_archivo,
    sep = delimitador,
    header = TRUE,
    fileEncoding = "UTF-8",
    stringsAsFactors = FALSE,
    check.names = FALSE
  )
  
  print(paste("¡Éxito! Se cargó:", ruta_archivo))
  print("--- Primeras 5 filas: ---")
  print(head(df, 5))
  print("--------------------------")
  
  # La función devuelve el data frame cargado
  return(df)
}

df_47803 <- leer_mi_csv(
  ruta_archivo = "Datos_salud_mental/47803.csv",
  delimitador = ";"
)

View(df_47803)

# 2. Delimitador: Tabulador (\t)
df_55158 <- leer_mi_csv(
  ruta_archivo = "Datos_salud_mental/55158.csv",
  delimitador = "\t"
)
View(df_55158)

# 3. Delimitador: Punto y coma (;)
df_stats_redes <- leer_mi_csv(
  ruta_archivo = "Datos_salud_mental/estadisticas-de-uso-de-redes-sociales (1).csv",
  delimitador = ";"
)

View(df_stats_redes)

# 4. Delimitador: Punto y coma (;)
df_sintomas <- leer_mi_csv(
  ruta_archivo = "Datos_salud_mental/Sintomatologia_depresiva_segun_sexo_y_grupo_de_edad.csv",
  delimitador = ";"
)

View(df_sintomas)

