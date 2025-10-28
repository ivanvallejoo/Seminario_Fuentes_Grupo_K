library(readr)

leer_csvs_objetos <- function(directorio, patron = "\\.csv$") {
  archivos <- list.files(path = directorio, pattern = patron, full.names = TRUE)
  
  for (archivo in archivos) {
    # Mantener el nombre del archivo como nombre del objeto
    nombre <- tools::file_path_sans_ext(basename(archivo))
    
    # Leer el CSV con delimitador ";"
    datos <- read_delim(archivo, delim = ";", locale = locale(encoding = "Latin1"))
    
    # Limpiar los nombres de las columnas (atributos)
    colnames(datos) <- make.names(colnames(datos))
    
    # Crear el objeto en el entorno global
    assign(nombre, datos, envir = .GlobalEnv)
  }
}


# Ejemplo de uso:
leer_csvs_objetos("C:/Users/ivanv/Desktop/ING_Salud/3º Ing_Salud/Fuentes_2/Seminario_Fuentes_Grupo_K/Datos_salud_mental")
leer_csvs_objetos("C:/Users/diego/Downloads/Seminario_Fuentes_Grupo_K/Datos_salud_mental")


