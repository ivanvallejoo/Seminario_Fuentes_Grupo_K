

library(readr)

leer_csvs_objetos <- function(directorio, patron = "\\.csv$") {
  archivos <- list.files(path = directorio, pattern = patron, full.names = TRUE)
  
  for (archivo in archivos) {
    nombre <- tools::file_path_sans_ext(basename(archivo))  # nombre del archivo sin extensión
    
    datos <- read_delim(archivo, delim = ";", locale = locale(encoding = "Latin1"))
    
    assign(nombre, datos, envir = .GlobalEnv)  # crea el objeto en el entorno global
  }
}

# Ejemplo de uso:
leer_csvs_objetos("C:/Users/diego/Downloads/Seminario_Fuentes_Grupo_K/Datos_salud_mental")

