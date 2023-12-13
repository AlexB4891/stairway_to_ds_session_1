
# ------------------------------------------------------------------------- #
#                  Cálculo del numero de empresas activas                   #
# ------------------------------------------------------------------------- #

# Se importan las librerias necesarias
library(tidyverse)
library(janitor)

ruc_pichincha <- read_delim("data/SRI_RUC_Pichincha.csv",delim = "|")

series_agregadas <- read_delim("data/ts_empresas_operacion_mensual.csv",delim = ",")

# tengo fechas asi: 1973/04/11 00:00:00.0… en "FECHA_INICIO_ACTIVIDADES" "FECHA_SUSPENSION_DEFINITIVA" "FECHA_REINICIO_ACTIVIDADES"

ruc_pichincha <- ruc_pichincha %>% 
  mutate(FECHA_INICIO_ACTIVIDADES = as.Date(FECHA_INICIO_ACTIVIDADES, format = "%Y/%m/%d"),
         FECHA_SUSPENSION_DEFINITIVA = as.Date(FECHA_SUSPENSION_DEFINITIVA, format = "%Y/%m/%d"), 
         FECHA_REINICIO_ACTIVIDADES = as.Date(FECHA_REINICIO_ACTIVIDADES, format = "%Y/%m/%d")) %>% 
  clean_names()

series_agregadas <- series_agregadas %>% 
  clean_names()

actividades <- series_agregadas %>% 
  distinct(actividad_economica) %>% 
  unlist()
# filtro para sociedades:


ruc_pichincha <- ruc_pichincha %>% 
  filter(tipo_contribuyente == "SOCIEDADES")

ruc_pichincha_target <- ruc_pichincha %>% 
  filter(tipo_contribuyente == "SOCIEDADES",
         codigo_ciiu %in% actividades)

caclular_numero_de_empresas_por_mes <- function(tabla,actividad){

  tabla_unida <- c(nuevas = "fecha_inicio_actividades",
                   suspendidas = "fecha_suspension_definitiva",
                   reingresos = "fecha_reinicio_actividades")  %>% 
    imap(~{ 
      
      name <- .y
      
      tabla %>% 
        group_by(across(.cols = .x)) %>% 
        summarise(n = n_distinct(numero_ruc)) %>% 
        rename_with(.cols = c("n",.x),.fn = ~c(name,"fecha"))
      
      }) 
  
  tabla_unida <- tabla_unida %>% 
    reduce(full_join)  %>% 
    arrange(fecha) %>% 
    mutate(across(c(nuevas,suspendidas,reingresos), ~replace_na(.x,0)),
           fecha = if_else(fecha <= "2000-01-01",ymd("2000-01-01"),fecha)) %>% 
    group_by(fecha) %>% 
    summarise(across(c(nuevas,suspendidas,reingresos), ~sum(.x,na.rm = T))) %>% 
    mutate(
      across(c(suspendidas,reingresos), ~if_else(fecha <= "2000-01-01",0,.x))) %>% 
    arrange(desc(fecha)) %>% 
    filter(complete.cases(.))

  tabla_unida <- tabla_unida %>% 
    arrange(fecha) 
  
  tabla_unida <- tabla_unida %>% 
    mutate(
      actividad = actividad,
      delta = reingresos + suspendidas*(-1),
      saldo = accumulate2(.x = nuevas,.y = delta[2:nrow(tabla_unida)],.f = ~.x+.y)) 
    
  return(tabla_unida)
}  


series_agregadas <- series_agregadas %>% 
  mutate(actividad_economica = str_sub(actividad_economica,1,5)) %>% 
  group_by(anio_fiscal,
           mes_fiscal,
           tipo_contribuyente,
           actividad_economica) %>% 
  summarise(across(everything(),~sum(.x,na.rm = T)))

series_pichincha_target <- ruc_pichincha_target %>% 
  mutate(codigo_ciiu = str_sub(codigo_ciiu,1,5)) %>% 
  split(.$codigo_ciiu) %>% 
  imap(~caclular_numero_de_empresas_por_mes(.x,.y))

iwalk(.x = series_pichincha_target,
      ~write_csv(x = .x,
                 file = str_c("data/ts_series_actividad_",.y,".csv")))

# series_globales <- caclular_numero_de_empresas_por_mes(ruc_pichincha,"Todas")

write_csv(x = series_globales,
          file = str_c("data/ts_series_pichincha.csv"))

write_csv(x = series_agregadas,
          file = str_c("data/ts_series_iva.csv"))






