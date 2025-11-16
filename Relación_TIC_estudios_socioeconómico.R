

csv_TICS_socioeconomico<- mis_datos_tic$uso_internet_socioeconomico

View(csv_TICS_socioeconomico)

json_nivel_estudios<- tabla_nivel_estudios_separada

View(json_nivel_estudios)


tabla_nivel_estudios<- json_nivel_estudios %>%
  filter(Sexo == "Ambos sexos",
         Prevalencia_depresion == "Cuadro depresivo mayor")

View(tabla_nivel_estudios)  


frecuencia_uso_util<- c("Han utilizado internet semanalmente (al menos una vez a la semana)",
                        "Han usado Internet diariamente (al menos 5 días a la semana)")

caracteristicas_socioeconomicas_util<- c("Estudios terminados: Educación superior"~"Superior",
  "Estudios terminados: Segunda etapa de Educación Secundaria",
  "Estudios terminados: Básico e inferior",
  "Estudios terminados: Analfabetos y primaria incompleta",
  "Estudios terminados: Educación Primaria",
  "Estudios terminados: Primera etapa de Educación Secundaria",
  "Estudios terminados: Formación Profesional de Grado Superior",
  "Estudios terminados: Diplomatura universitaria y equivalentes",
  "Estudios terminados: Licenciatura universitaria, máster y equivalentes",
  "Estudios terminados: Doctorado universitario")

tabla_tics_socioeconomico<- csv_TICS_socioeconomico %>% 
  filter(Frecuencia.de.uso %in% frecuencia_uso_util,
         Clase.de.población == "Total de personas (16 a 74 años)",
         Características.socioeconómicas %in% caracteristicas_socioeconomicas_util
         ) %>% 
  mutate(
    Nivel_de_estudios = case_when(
      Características.socioeconómicas == "Estudios terminados: Educación superior"~"Superior",
      Características.socioeconómicas == "Estudios terminados: Segunda etapa de Educación Secundaria"~"Intermedio",
      Características.socioeconómicas == "Estudios terminados: Básico e inferior"~"Básico e inferior",
      Características.socioeconómicas == "Estudios terminados: Analfabetos y primaria incompleta"~"Básico e inferior",
      Características.socioeconómicas == "Estudios terminados: Educación Primaria"~"Básico e inferior",
      Características.socioeconómicas == "Estudios terminados: Primera etapa de Educación Secundaria" ~ "Intermedio",
      Características.socioeconómicas == "Estudios terminados: Formación Profesional de Grado Superior" ~ "Superior",
      Características.socioeconómicas == "Estudios terminados: Diplomatura universitaria y equivalentes" ~ "Superior",
      Características.socioeconómicas == "Estudios terminados: Licenciatura universitaria, máster y equivalentes" ~ "Superior",
      Características.socioeconómicas == "Estudios terminados: Doctorado universitario" ~ "Superior"
    ))

View(tabla_tics_socioeconomico)  



