library(readr)
library(janitor)

leer_csvs_objetos <- function(directorio, patron = "\\.csv$") {
  archivos <- list.files(path = directorio, pattern = patron, full.names = TRUE)
  
  for (archivo in archivos) {
    nombre <- tools::file_path_sans_ext(basename(archivo))
    
    # Detectar delimitador automáticamente (coma, punto y coma, tabulador, barra vertical)
    primera_linea <- readLines(archivo, n = 1, encoding = "UTF-8")
    posibles <- c(";", ",", "\t", "|")
    cuenta <- sapply(posibles, function(d) stringi::stri_count_fixed(primera_linea, d))
    delim_detectado <- posibles[which.max(cuenta)]

    # Intentar primero con UTF-8, si falla probar con Latin1
    datos <- tryCatch(
      read_delim(archivo, delim = delim_detectado, locale = locale(encoding = "UTF-8")),
      error = function(e) {
        read_delim(archivo, delim = delim_detectado, locale = locale(encoding = "Latin1"))
      }
    )
    
    # Limpiar nombres de columnas con janitor::clean_names()
    datos <- janitor::clean_names(datos)
    
    assign(nombre, datos, envir = .GlobalEnv)
  }
}

leer_csvs_objetos("Datos_tic")
