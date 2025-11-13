# --- 1. Carga de Librerías ---
library(readr)
library(dplyr)
library(tools)
library(ggplot2)

# --- 2. Tu función para leer los CSV ---
leer_csvs_con_practica <- function(directorio, delim_fijo, patron = "\\.csv$") {
  
  
  archivos <- list.files(path = directorio, pattern = patron, full.names = TRUE)
  
  lista_datos <- list()
  
  for (archivo in archivos) {
    
    nombre <- tools::file_path_sans_ext(basename(archivo))
    
    datos <- tryCatch(
      read_delim(archivo, delim = delim_fijo, locale = locale(encoding = "UTF-8")),
      error = function(e) {
        read_delim(archivo, delim = delim_fijo, locale = locale(encoding = "Latin1"))
      }
    )
    
    colnames(datos) <- make.names(colnames(datos))
    
    lista_datos[[nombre]] <- datos
  }
  
  return(lista_datos)
}

