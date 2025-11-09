library(readr)

# Intento 1: Usar "Latin1" (la más común para español)
datos_buenos <- read_delim(
  "Datos_salud_mental/47281.csv", 
  delim = "\t",  # Especificamos que el separador es un TAB
  locale = locale(encoding = "Latin1")
)



# Revisa si los datos se han cargado bien
View(datos_buenos)

datos_buenos1 <- read_delim(
  "Datos_salud_mental/47803.csv", 
  delim = "\t",  # Especificamos que el separador es un TAB
  locale = locale(encoding = "UTF-8")
)



# Revisa si los datos se han cargado bien

View(datos_buenos1)
library(readr)

# 1. Define tu directorio
directorio <- "Datos_salud_mental"

# 2. Obtén la lista de archivos (como en tu función)
archivos <- list.files(path = directorio, pattern = "\\.csv$", full.names = TRUE)

# 3. Recorre cada archivo y muestra su codificación más probable
for (archivo in archivos) {
  
  # Adivina la codificación
  codificacion <- guess_encoding(archivo)$encoding[1] # Tomamos solo la primera (la más probable)
  
  # Mostramos el resultado en la consola
  print(paste("Archivo:", basename(archivo), "--- Codificación:", codificacion))
}