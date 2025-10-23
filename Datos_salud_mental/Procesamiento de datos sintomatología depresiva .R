library(readr)
Sintomatologia_depresiva <- read_delim("Datos_salud_mental/Sintomatología depresiva según sexo y grupo de edad.csv",
                               delim = ";", escape_double = FALSE, trim_ws = TRUE)

Sintomatologia_depresiva
summary(Sintomatologia_depresiva)
View(Sintomatologia_depresiva) 


