
# ------------------------------------------------------------#
#   Definición de parámetros (entradas) de la clase          #
#-----------------------------------------------------------#

Librerias_base = c("readxl","dplyr","ggplot2","reshape2","knitr","haven","foreign","stringi","labelled","tidyr","plyr","openxlsx","tidyverse",
             "lpSolve","Rglpk","Rsymphony","scatterplot3d","reshape","R6") # Nombra las librerias necesarias

# ---------------------------------------------------------------#
#   Primer método: Definición de librerias base (MÓDULO 000)     #
#----------------------------------------------------------------#


if (!require("pacman")) install.packages("pacman") # Paquete que simplifica la carga de librerias
pacman::p_load(char = Librerias_base);Librerias_base_print = paste0(paste0("'", Librerias_base, "'"), collapse = ", ") # Instala si es necesario, o en su defecto, sólo llama los paquetes 

cat("Las librerias usadas en el presente paquete son:",Librerias_base_print,"\n")

    
# ---------------------------------------------------------------#
#   Segundo método: Manipulación de bases de datos               #
#----------------------------------------------------------------#

#--------      -------#
# Precios mayoristas  #
#-----         -------#  

Mes = c("Abril", "Mayo", "Junio", "Julio", "Agosto", "Septiembre")


# Separando la base de datos en función de los meses disponibles. Los datos por mes se definen en el enviroment global de R

for (i in 1:length(Mes)) {
sipsa_precios = read_excel( "/home/juan-c/Descargas/Metodologia_CIAT-main/datos_primarios/precios_sipsa_fuente/series-historicas-precios-mayoristas-2022.xlsx",sheet = i+4)
colnames(sipsa_precios) = c("Fecha", "Grupo", "Alimento", "Mercado", "Precio_kg");sipsa_precios_nombre=paste("sipsa_precios",Mes[i], sep = "_")
assign(sipsa_precios_nombre,sipsa_precios);rm(sipsa_precios)
}


#--------      -------#
#    Abastecimiento   #
#-----         -------#  

Semestres=c("I_semestre","II_Semestre")

for (i in 1:length(Semestres)) {

sipsa_abs = read.xlsx("/home/juan-c/Descargas/Metodologia_CIAT-main/datos_primarios/abastecimiento_sipsa_fuente/microdato-abastecimiento-2022.xlsx",sheet = i+1)
colnames(sipsa_abs) = c("Ciudad_Mercado", "Fecha","Cod_Dep", "Cod_Mun", "Dep_Proc", "Mun_Proc","Grupo", "Alimento", "Cantidad_KG")

  sipsa_abs$Ciudad_Mercado = as.character(sipsa_abs$Ciudad_Mercado)
  sipsa_abs$Cod_Mun = gsub("'", "", sipsa_abs$Cod_Mun)
  sipsa_abs$Cod_Dep = gsub("'", "", sipsa_abs$Cod_Dep)
  sipsa_abs$Cod_Mun = as.numeric(sipsa_abs$Cod_Mun)
  sipsa_abs$Alimento = as.factor(sipsa_abs$Alimento)
  sipsa_abs$Grupo = as.factor(sipsa_abs$Grupo)

sipsa_abs_nombre=paste("sipsa_abs",Semestres[i], sep = "_");assign(sipsa_abs,sipsa_abs_nombre);rm(sipsa_abs)

}

sipsa_abs_I_semestre

sipsa_abs = read.xlsx("/home/juan-c/Descargas/Metodologia_CIAT-main/datos_primarios/abastecimiento_sipsa_fuente/microdato-abastecimiento-2022.xlsx")

View(sipsa_abs)

