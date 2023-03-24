

library("R6")

#setwd("C:/Users/kmili/OneDrive/Escritorio/Footype/Footype/R")

Paquete_foottype_ver_0_0_1=R6Class(classname="Paquete_foottype_ver_0_0_1",

# ------------------------------------------------------------#
#   Definición de parámetros (entradas) de la clase          #
#-----------------------------------------------------------#

public=list(
     Librerias_base = c("readxl","dplyr","ggplot2","reshape2","knitr","haven","foreign","stringi","labelled","tidyr","plyr","openxlsx","tidyverse",
             "lpSolve","Rglpk","Rsymphony","scatterplot3d","reshape"), # Nombra las librerias necesarias
    Mes_Estudio=NULL,
initialize=function(Mes_Estudio){self$Mes_Estudio=Mes_Estudio},



# ---------------------------------------------------------------#
#   Primer método: Definición de librerias base (MÓDULO 000)     #
#----------------------------------------------------------------#


Librerias=function(Librerias_base){


    if (!require("pacman")) install.packages("pacman") # Paquete que simplifica la carga de librerias
    pacman::p_load(char = self$Librerias_base);Librerias_base_print = paste0(paste0("'", self$Librerias_base, "'"), collapse = ", ") # Instala si es necesario, o en su defecto, sólo llama los paquetes

    cat("Las librerias usadas en el presente paquete son:","\n",Librerias_base_print,"\n")

},

# ---------------------------------------------------------------#
#   Segundo método: Carga de las bases de datos(MÓDULO 01)      #
#----------------------------------------------------------------#

Módulos_0_1_2=function(){
# ---------------------------------------------------------------#
#   Segundo método: Carga de las bases de datos(MÓDULO 01)      #
#----------------------------------------------------------------#

# Separando las base de datos en función de los meses disponibles. Los datos por mes se definen en el enviroment global de R

#--------      -------#
# Precios mayoristas  # bases de datos históricas sobre precios mayoristas (Fuente: SIPSA)
#-----         -------#

Mes = c("Abril", "Mayo", "Junio", "Julio", "Agosto", "Septiembre")


suppressWarnings(for (i in 1:length(Mes)) {
Sipsa_Precios = read_excel( "/home/juan-c/Descargas/Metodologia_CIAT-main/datos_primarios/precios_sipsa_fuente/series-historicas-precios-mayoristas-2022.xlsx",sheet = i+4)
colnames(Sipsa_Precios) = c("Fecha", "Grupo", "Alimento", "Mercado", "Precio_kg");sipsa_Precios_Nombre=paste("Sipsa_Precios",Mes[i], sep = "_")
assign(sipsa_Precios_Nombre,Sipsa_Precios);rm(Sipsa_Precios)
})




#--------      -------#
#    Abastecimiento   # base de datos históricas sobre abastecimiento (Fuente: SIPSA)
#-----         -------#

Semestres=c("I_Semestre","II_Semestre")

for (i in 1:length(Semestres)) {

Sipsa_Abs = read.xlsx("/home/juan-c/Descargas/Metodologia_CIAT-main/datos_primarios/abastecimiento_sipsa_fuente/microdato-abastecimiento-2022.xlsx",sheet = i+1)
colnames(Sipsa_Abs) = c("Ciudad_Mercado", "Fecha","Cod_Dep", "Cod_Mun", "Dep_Proc", "Mun_Proc","Grupo", "Alimento", "Cantidad_KG")

  Sipsa_Abs$Cod_Mun <- gsub("'", "", Sipsa_Abs$Cod_Mun)
  Sipsa_Abs$Cod_Dep <- gsub("'", "", Sipsa_Abs$Cod_Dep)

Sipsa_Abs = Sipsa_Abs %>% mutate_if(is.character,as.factor)
sipsa_abs_nombre=paste("Sipsa_Abs",Semestres[i], sep = "_");assign(sipsa_abs_nombre,Sipsa_Abs);rm(Sipsa_Abs)

}

#--------      -------#
#         Mapeos      #
#-----         -------#

# SIPSA (precios mayoristas-abastecimiento)
Mapeo_Precios_Abs = read_excel("/home/juan-c/Descargas/Metodologia_CIAT-main/datos_primarios/mapeo_y_criterios_fuente/mapeo_sipsa_abs_precios.xlsx")

# Mercar(precios mayoristas-precios minoristas)
Mapeo_Mayorista_Minorista = read_excel("/home/juan-c/Descargas/Metodologia_CIAT-main/datos_primarios/mapeo_y_criterios_fuente/mapeo_mayoristas_mercar.xlsx")

# SIPSA-TCAC (Códigos de sipsa a  Composición de Alimentos Colombianos)
Mapeo_Sipsa_TCAC = read_excel("/home/juan-c/Descargas/Metodologia_CIAT-main/datos_primarios/mapeo_y_criterios_fuente/mapeo_tcac.xlsx");colnames(Mapeo_Sipsa_TCAC) = c("Alimento", "Codigo_TCAC")
Mapeo_Sipsa_TCAC = Mapeo_Sipsa_TCAC %>% filter(Codigo_TCAC %in% setdiff(levels(as.factor(Mapeo_Sipsa_TCAC$Codigo_TCAC)), "EX000"))


# TCAC-GABAS (TCAC con Guías Alimentarias y SIN composición )
Mapeo_Sipsa_TCAC_GABAS_Grupos = read_excel("/home/juan-c/Descargas/Metodologia_CIAT-main/datos_primarios/composicion_nutricional_fuente/composicion_nutricional_corr.xlsx")
Variables_Necesarias = c("codigo", "Nombre del Alimento","Grupos  GABAS", "Subgrupos  GABAS",  "Grupo TCAC");Mapeo_Sipsa_TCAC_GABAS_Grupos = Mapeo_Sipsa_TCAC_GABAS_Grupos[Variables_Necesarias]
colnames(Mapeo_Sipsa_TCAC_GABAS_Grupos) = c("Cod_TCAC", "Alimento", "Grupo_GABAS", "Subgrupo_GABAS", "Grupo_TCAC")


#--------               -------#
#    Criterios de exclusión    #
#-----                  -------#

Primer_Criterio_Lista_Alimentos = read_excel("/home/juan-c/Descargas/Metodologia_CIAT-main/datos_primarios/mapeo_y_criterios_fuente/lista_alimentos_criterio_1.xlsx")

#--------               -------#
#    Precios minoristas        # Cargar las bases de datos disponibles de Mercar
#-----                  -------#

for (i in 4:length(Mes)) {
Precios_Minoristas_Mercar = read.xlsx(paste0("/home/juan-c/Descargas/Metodologia_CIAT-main/datos_primarios/precios_minoristas_fuente/mercar_",Mes[i],".xlsx"));colnames(Precios_Minoristas_Mercar) = c("Codigo_mercar", "Descripcion", "Fecha", "Precio", "Unidad")
Precios_Minoristas_Mercar_Nombre=paste("Precios_Minoristas_Mercar",Mes[i], sep = "_");assign(Precios_Minoristas_Mercar_Nombre,Precios_Minoristas_Mercar);rm(Precios_Minoristas_Mercar)
}

#--------               -------#
#    Composición nutricional   #
#-----                  -------#
Mapeo_Sipsa_TCAC_Carga_2 = read_excel("/home/juan-c/Descargas/Metodologia_CIAT-main/datos_primarios/composicion_nutricional_fuente/composicion_nutricional_corr.xlsx")

Micro_Macro_Nutrientes_Necesarios = c("codigo", "Nombre del Alimento", "% de parte comestible", "Factor de conversión", "Energia (Kcal)", "Proteina (g)", "Carbohidratos Totales (g)", "Lipidos (g)", "Calcio (mg)",
         "Zinc (mg)", "Hierro (mg)", "Magnesio (mg)", "Fosforo (mg)", "Vitamina C (mg)", "Tiamina (mg)", "Riboflavina (mg)",
         "Niacina (mg)", "Folatos (mcg)", "Vitamina B12 (mcg)", "Vitamina A (ER)", "Sodio (mg)", "Micr sin inf (por alimento)")

Sipsa_TCAC=Mapeo_Sipsa_TCAC_Carga_2[Micro_Macro_Nutrientes_Necesarios];colnames(Sipsa_TCAC)[1] = "Cod_TCAC";colnames(Sipsa_TCAC)[2] = "Alimento_TCAC"


#--------               -------#
# Intercambios (equivalencias) #
#-----                  -------#


Porciones_GABAS = read.xlsx("/home/juan-c/Descargas/Metodologia_CIAT-main/datos_primarios/requerimientos_fuente/Recomendaciones y gramos de intercambios GABAS.xlsx", sheet = 2);colnames(Porciones_GABAS) = c("Cod_TCAC", "Alimentos", "Subgrupo_GABAS", "Energia_100g", "Energia_Int", "Intercambio_g")


# ---------------------------------------------------------------#
# Tercer método: Definición de la muestra (Fechas-MÓDULO 02)    #
#----------------------------------------------------------------#

# seleccionar el período de estudio

# lista de secuencias mensuales

Abril = seq(from = as.Date("2022-04-01"), to = as.Date("2022-04-30"), by =1)
Mayo = seq(from = as.Date("2022-05-01"), to = as.Date("2022-05-31"), by =1)
Junio = seq(from = as.Date("2022-06-01"), to = as.Date("2022-06-30"), by =1)
Julio = seq(from = as.Date("2022-07-01"), to = as.Date("2022-07-31"), by =1)
Agosto = seq(from = as.Date("2022-08-01"), to = as.Date("2022-08-31"), by =1)
Septiembre = seq(from = as.Date("2022-09-01"), to = as.Date("2022-09-30"), by =1)



# lista de secuencias semestrales

Semestre_I = c("Enero", "Febrero", "Marzo", "Abril", "Mayo", "Junio")
Semestre_II = c("Julio", "Agosto", "Septiembre", "Octubre", "Noviembre", "Diciembre")

Lista_Mes=list(Abril,Mayo,Junio,Julio,Agosto,Septiembre);names(Lista_Mes)=Mes
Lista_Semestres = list(Semestre_I, Semestre_II);names(Lista_Semestres)=c("I_Semestre","II_Semestre")
Fecha=Lista_Mes[[self$Mes_Estudio]]
#--------                                   -------#
#    Asignación fecha para  Precios Mayoristas     #
#-----                                      -------#

# Extraer la base objeto del enviromet global con base en el mes de estudio asignado

Precios_Sipsa_Mes_Estudio=get(paste("Sipsa_Precios",self$Mes_Estudio, sep = "_"))

#--------                                      -------#
#    Asignación Semestre para  Datos abastecimiento   #
#-----                                         -------#

# Determinar el semestre asociado al mes de estudio

Semestre = names(Lista_Semestres)[which(sapply(Lista_Semestres, function(x) self$Mes_Estudio %in% x))]

# Extraer la base objetivo del enviromet global con base en el semestre del mes de estudio y validación del formato fecha según YYYY/MM/DD


Sipsa_Abs_Semestre_Estudio=get(paste("Sipsa_Abs",Semestre, sep = "_"));Sipsa_Abs_Semestre_Estudio$Fecha = as.Date(Sipsa_Abs_Semestre_Estudio$Fecha, origin = "1899-12-30")


# ---------------------------------------------------------------#
#     Cuarto método: Precios SIPSA         (MÓDULO 1)            #
#----------------------------------------------------------------#

Ciudad_de_estudio="Cali";Precios_Sipsa_Mes_Estudio_Ciudad=NULL

if(Ciudad_de_estudio=="Cali") {
  Precios_Sipsa_Mes_Estudio_Ciudad = Precios_Sipsa_Mes_Estudio %>% filter(Mercado %in% c("Cali, Cavasa","Cali, Galería Alameda","Cali, La Floresta","Cali, Santa Elena","Cali, Siloé"))
} else {
  Precios_Sipsa_Mes_Estudio_Ciudad=print("Ciudad no disponible por el momeno")
}
# Vector para el nombre de los alimentos
Alimentos_Sipsa = levels(as.factor(Precios_Sipsa_Mes_Estudio_Ciudad$Alimento))

# Base de datos de recepción para el precio único de cada alimento
Precio_Unico_Sipsa_Mes_Estudio_Ciudad = data.frame(Alimentos_Sipsa, Precio_kg = NA);colnames(Precio_Unico_Sipsa_Mes_Estudio_Ciudad)=c("Alimento","Precio_kg")

# El precio único de cada alimento corresponde al precio promedio entre los 5 mercados

for (i in 1:length(Alimentos_Sipsa)) {
  Media_Precios = data.frame()
  Media_Precios = Precios_Sipsa_Mes_Estudio_Ciudad[Precios_Sipsa_Mes_Estudio_Ciudad$Alimento == Alimentos_Sipsa[i],]
  Precio_Unico_Sipsa_Mes_Estudio_Ciudad$Precio_kg[i] = mean(Media_Precios$Precio_kg)
  rm(Media_Precios)
}


# La base de datos queda en el enviroment global como: Precio_Unico_Sipsa_Mes_Estudio_Ciudad


# -----------------------------------------------------------------#
#     Quinto método: Precios SIPSA         (MÓDULO 210)            #
#------------------------------------------------------------------#

# Filtrar la información de abastecimiento para Cali (SIPSA)

Precios_Sipsa_Abs_Mes_Estudio_Ciudad=NULL

if(Ciudad_de_estudio=="Cali") {
  Precios_Sipsa_Abs_Mes_Estudio_Ciudad = Sipsa_Abs_Semestre_Estudio %>% filter(Ciudad_Mercado %in% c("Cali, Cavasa","Cali, Santa Elena"))

} else {
  Precios_Sipsa_Abs_Mes_Estudio_Ciudad=print("Ciudad no disponible por el momento")
}

#--------                                     -------#
#    Abastecimiento según  mayoristas : CAVASA       #
#-----                                        -------#

# Filtrar la información de abastecimiento para Cavasa

Precios_Sipsa_Abs_Mes_Estudio_Ciudad_Cavasa = Precios_Sipsa_Abs_Mes_Estudio_Ciudad[Precios_Sipsa_Abs_Mes_Estudio_Ciudad$Ciudad_Mercado == "Cali, Cavasa",]

# Flujo total abastecimiento  de carga mensual

Alimentos_Sipsa_Abs=levels(as.factor(Precios_Sipsa_Abs_Mes_Estudio_Ciudad_Cavasa$Alimento))

Precio_Mensual_Sipsa_Abs_Mes_Estudio_Ciudad_Cavasa= data.frame(Alimentos_Sipsa_Abs, Cantidad_Total_KG_Cavasa = NA)
colnames(Precio_Mensual_Sipsa_Abs_Mes_Estudio_Ciudad_Cavasa)=c("Alimento_abs","Cantidad_Total_KG_Cavasa")

for(i in 1:length(Alimentos_Sipsa_Abs)){
Datos_Alimento=subset(Precios_Sipsa_Abs_Mes_Estudio_Ciudad_Cavasa, Alimento==Alimentos_Sipsa_Abs[i])

Precio_Mensual_Sipsa_Abs_Mes_Estudio_Ciudad_Cavasa$Cantidad_Total_KG_Cavasa[i]=sum(Datos_Alimento[is.element(Datos_Alimento$Fecha, Fecha),]$Cantidad_KG)
Precio_Mensual_Sipsa_Abs_Mes_Estudio_Ciudad_Cavasa["Cantidad_Total_KG_Cavasa"][Precio_Mensual_Sipsa_Abs_Mes_Estudio_Ciudad_Cavasa["Cantidad_Total_KG_Cavasa"] == 0] = NA
}




#--------                                     -------#
#  Abastecimiento según  mayoristas : Santa Elena    #
#-----                                        -------#


# Filtrar la información de abastecimiento para SE

Precios_Sipsa_Abs_Mes_Estudio_Ciudad_SE = Precios_Sipsa_Abs_Mes_Estudio_Ciudad[Precios_Sipsa_Abs_Mes_Estudio_Ciudad$Ciudad_Mercado == "Cali, Santa Elena",]

# Flujo total abastecimiento  de carga mensual

Precio_Mensual_Sipsa_Abs_Mes_Estudio_Ciudad_SE= data.frame(Alimentos_Sipsa_Abs, Cantidad_Total_KG = NA)
colnames(Precio_Mensual_Sipsa_Abs_Mes_Estudio_Ciudad_SE)=c("Alimento_abs","Cantidad_Total_KG_SE")

for(i in 1:length(Alimentos_Sipsa_Abs)){
Datos_Alimento=subset(Precios_Sipsa_Abs_Mes_Estudio_Ciudad_SE, Alimento==Alimentos_Sipsa_Abs[i])
Precio_Mensual_Sipsa_Abs_Mes_Estudio_Ciudad_SE$Cantidad_Total_KG_SE[i]=sum(Datos_Alimento[is.element(Datos_Alimento$Fecha, Fecha),]$Cantidad_KG)
Precio_Mensual_Sipsa_Abs_Mes_Estudio_Ciudad_SE["Cantidad_Total_KG_SE"][Precio_Mensual_Sipsa_Abs_Mes_Estudio_Ciudad_SE["Cantidad_Total_KG_SE"] == 0] = NA
}

# -----------------------------------------------------------------#
#         Quinto método: ABS Total         (MÓDULO 220)            #
#------------------------------------------------------------------#

# Unión entre la información de abastecimiento según mercados mayoristas
Cantidad_Sipsa_Abs_Mes_Estudio_Ciudad=merge(Precio_Mensual_Sipsa_Abs_Mes_Estudio_Ciudad_Cavasa,Precio_Mensual_Sipsa_Abs_Mes_Estudio_Ciudad_SE)


# Cálculo del abastecimiento total de cada alimento (suma del abastecimiento en cada mercado)
Cantidad_Sipsa_Abs_Mes_Estudio_Ciudad$Total_cali= rowSums(Cantidad_Sipsa_Abs_Mes_Estudio_Ciudad[c("Cantidad_Total_KG_Cavasa","Cantidad_Total_KG_SE")], na.rm =TRUE)
Cantidad_Sipsa_Abs_Mes_Estudio_Ciudad["Total_cali"][Cantidad_Sipsa_Abs_Mes_Estudio_Ciudad["Total_cali"] == 0] = NA


# Asignación de un alimento con abastecimiento a cada producto de la base de datos de precios
Precios_Sipsa_Abs_Mes_Estudio_Ciudad = merge(Precio_Unico_Sipsa_Mes_Estudio_Ciudad, Mapeo_Precios_Abs, by = "Alimento", all.x = TRUE)

# Asignación del valor de abastecimiento en cada caso
Precios_Sipsa_Abs_Mes_Estudio_Ciudad = merge(Precios_Sipsa_Abs_Mes_Estudio_Ciudad, Cantidad_Sipsa_Abs_Mes_Estudio_Ciudad,by = "Alimento_abs", all.x = TRUE)

# Selección de las variables de interés
Precios_Sipsa_Abs_Mes_Estudio_Ciudad = Precios_Sipsa_Abs_Mes_Estudio_Ciudad[c("Alimento", "Precio_kg", "Total_cali")]
Precios_Sipsa_Abs_Mes_Estudio_Ciudad_Cantidad_Total = Precios_Sipsa_Abs_Mes_Estudio_Ciudad[order(Precios_Sipsa_Abs_Mes_Estudio_Ciudad$Alimento),]
colnames(Precios_Sipsa_Abs_Mes_Estudio_Ciudad_Cantidad_Total) = c("Alimento",paste0("Precio_kg_", self$Mes_Estudio), paste0("Total_Cali_", self$Mes_Estudio))



# Guardar el abastecimiento mensual como:Abs_Total_Cali_Mes_Estudio

Nombre_Mes_Abs_Total=paste("Abs_Total_Cali",self$Mes_Estudio, sep = "_")
assign(Nombre_Mes_Abs_Total,Precios_Sipsa_Abs_Mes_Estudio_Ciudad_Cantidad_Total[c("Alimento", paste0("Total_Cali_", self$Mes_Estudio))])
assign("Abs_Total_Mes_Estudio",Precios_Sipsa_Abs_Mes_Estudio_Ciudad_Cantidad_Total[c("Alimento", paste0("Total_Cali_", self$Mes_Estudio))])


# -----------------------------------------------------------------#
#     Quinto método: Criterios de Exc      (MÓDULO 221)            #
#------------------------------------------------------------------#


#--------                    -------#
#  Segundo criterio de exclusión    #
#-----                       -------#

# Vector de alimentos incluidos a priori por alguna de las siguientes razones:
# (1) Unidades de medidas no comparables
# (2) Niveles de abastecimiento bajo por falta de subdivision (e.g. tipos de quesos)
# (3) Alimentos no sujetos a factores estacionales

Alimentos_Exclu = c("Aceite vegetal mezcla", "Huevo rojo A", "Huevo rojo AA","Huevo rojo extra", "Leche pasteurizada (1.1 L)", "Queso doble crema",
  "Queso cuajada", "Queso Caquetá", "Pollo entero con visceras","Lomitos de atún en lata", "Galletas saladas", "Sardinas en lata","Chocolate amargo")

Alimentos_Inclu = setdiff(Abs_Total_Mes_Estudio$Alimento, Alimentos_Exclu)
criterio_2 = Abs_Total_Mes_Estudio %>% filter(Alimento %in% Alimentos_Inclu)

# Eliminar niveles NA de abastecimiento (Flujos de carga nulos)
criterio_2 = criterio_2 %>% drop_na(paste0("Total_Cali_",self$Mes_Estudio))

# Calcular cuantiles
quant = quantile(criterio_2[,2], na.rm = TRUE)

# Eliminar los alimentos cuyo flujo de carga está abajo del percentil 25
criterio_2 = criterio_2[criterio_2[,2] < quant[2],]

# Guardar los alimentos excluidos según el segundo criterio

assign("Base_Exclu_Criterio_2",criterio_2)
colnames(Base_Exclu_Criterio_2)=c("Alimento","Total_cali")
# Gráfica para los flujos de carga
ggplot(Base_Exclu_Criterio_2) + geom_bar(aes(x = Total_cali, y = Alimento), stat = "identity", fill = 'brown') +
  geom_vline(xintercept = quant[2], linetype = "dashed") +
  xlim(c(0, 100000)) + xlab("Flujo de carga (kg)")+ggtitle(paste0("Flujo de Carga Cali-",self$Mes_Estudio))


#--------                               -------#
#  Primer  criterio de exclusión: Nutrición    #
#-----                                  -------#

Alimentos_Exclu_Criterio_1 = Primer_Criterio_Lista_Alimentos[Primer_Criterio_Lista_Alimentos$`COD. TCAC` == "EX000","Alimento"]

#--------                               -------#
# Lista depurada con base en los dos criterios #
#-----                                  -------#

# Abastecimiento nulo
Alimentos_NA = Abs_Total_Mes_Estudio %>% filter(is.na(get(paste0("Total_Cali_",self$Mes_Estudio))))

# Construir el vector con la totalidad de alimentos excluidos
# (criterio 1, criterio 2, flujo de carga nulo y exclusiones ad hoc)

Alimentos_Excluidos_1 = Alimentos_Exclu_Criterio_1["Alimento"]
Alimentos_Exclu_Criterio_2 = criterio_2$Alimento
Alimentos_Excluidos_Na = Alimentos_NA$Alimento
Alimentos_Excluidos = c(Alimentos_Excluidos_1, Alimentos_Exclu_Criterio_2, Alimentos_Excluidos_Na,"Queso Caquetá")



# Exclusión de los alimentos y construcción de la lista definitiva
Lista_Alimentos_Definitiva = Abs_Total_Mes_Estudio %>% filter(Alimento %in% setdiff(levels(as.factor(Abs_Total_Mes_Estudio$Alimento)), Alimentos_Excluidos))

if(length(warnings())==0) {cat("Depuración módulos 0, 1 y 2 exitosa", "\n")} else {cat("Cantidad de errores encontrados:", "\n")}

# -----------------------------------------------------------------#
#     Salidas de los métodos en en embiente GLOBAL                 #
#------------------------------------------------------------------#

assign(paste0("Lista_Alimentos_Definitiva_",self$Mes_Estudio),Lista_Alimentos_Definitiva,envir = globalenv())
assign(paste0("Alimentos_Exclu_Criterio_1"),Alimentos_Exclu_Criterio_1,envir = globalenv())
assign(paste0("Alimentos_Exclu_Criterio_2"),as.data.frame(Alimentos_Exclu_Criterio_2),envir = globalenv())
assign(paste0("Alimentos_Excluidos_Na"),as.data.frame(Alimentos_Excluidos_Na),envir = globalenv())
assign(paste0("Precios_Mayoristas_",self$Mes_Estudio),Precio_Unico_Sipsa_Mes_Estudio_Ciudad,envir = globalenv())

}

)
)


P

