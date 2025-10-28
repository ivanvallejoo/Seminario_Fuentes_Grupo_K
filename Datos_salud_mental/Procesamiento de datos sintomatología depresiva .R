

library(readr)

leer_csvs_objetos <- function(directorio, patron = "\\.csv$") {
  archivos <- list.files(path = directorio, pattern = patron, full.names = TRUE)
  
  for (archivo in archivos) {
    nombre <- tools::file_path_sans_ext(basename(archivo))
    
    # Intentar primero con UTF-8, si falla probar con Latin1
    datos <- tryCatch(
      read_delim(archivo, delim = ";", locale = locale(encoding = "UTF-8")),
      error = function(e) {
        read_delim(archivo, delim = ";", locale = locale(encoding = "Latin1"))
      }
    )
    
    # Limpiar nombres de columnas (quita espacios, acentos, etc.)
    colnames(datos) <- make.names(colnames(datos))
    
    assign(nombre, datos, envir = .GlobalEnv)
  }
}


# Ejemplo de uso:
leer_csvs_objetos("C:/Users/diego/Downloads/Seminario_Fuentes_Grupo_K/Datos_salud_mental")

