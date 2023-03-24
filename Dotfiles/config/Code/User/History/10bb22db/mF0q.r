library(R6)

Foodprice=R6Class(classname="Foodprice",
# ------------------------------------------------------------#
#   Definición de parámetros (entradas) de la clase          #
#-----------------------------------------------------------#

    public=list(
        Librerias_base = c("readxl","dplyr","ggplot2","reshape2","knitr","haven","foreign","stringi","labelled","tidyr","plyr","openxlsx","tidyverse",
             "lpSolve","Rglpk","Rsymphony","scatterplot3d","reshape"), # Nombra las librerias necesarias
        X=NULL,

# ---------------------------------------------------------------#
#   Primer método: Definición de librerias base (MÓDULO 000)     #
#----------------------------------------------------------------#

    Librerias=function(Librerias_base){ 

    if (!require("pacman")) install.packages("pacman") # Paquete que simplifica la carga de librerias
    pacman::p_load(char = self$Librerias_base);Librerias_base_print = paste0(paste0("'", self$Librerias_base, "'"), collapse = ", ") # Instala si es necesario, o en su defecto, sólo llama los paquetes 

    cat("Las librerias usadas en el presente paquete son:",Librerias_base_print,"")

    }

# ---------------------------------------------------------------#
#   Segundo método: Definición de librerias base (MÓDULO 000)    #
#-------------------------------------------------1---------------#

1+1

