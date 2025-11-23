#librerias utilizadas para la correcta ejecución de este script, vistas en clase
library(readr)
library(dplyr)
library(tools)

#Función para leer los CSV, itera sobre el directorio que le pasemos y crea una lista que contiene todos los csvs que vamos a usar

leer_csvs_salud_mental<- function(directorio, delim_fijo, patron = "\\.csv$") {
  
  #Ruta de los archivos que coincidan con el patrón definido arriba
  archivos <- list.files(path = directorio, pattern = patron, full.names = TRUE)
  
  lista_datos <- list() #lista vacía para almacenar los dataframes
  
  #iteramos por cada archivo encontrado en la ruta que queremos
  for (archivo in archivos) {
    
    #extraemos el nombre del archivo sin la extención para usarlo como clave en la lista
    nombre <- tools::file_path_sans_ext(basename(archivo))
    
    #esto sirve para los posibles problemas de codificación que podamos tener con los csvs, solo codifica en UTF-8 y Latin1
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

mis_datos_salud_mental<- leer_csvs_con_practica(directorio="Datos_salud_mental", delim_fijo = ";")

View(mis_datos_salud_mental)

