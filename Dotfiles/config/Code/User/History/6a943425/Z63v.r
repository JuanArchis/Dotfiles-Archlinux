#Lectura base de datos y librerias

library("readxl");library("dplyr");library("MASS");library("FactoMineR");library("factoextra");library("visdat");library("DMwR2") 
library("mice")
Datos_Impacto <- read_excel("C:/Users/kmili/Downloads/Impacto Decodificada.xlsx") 


#Estructura de la base de datos y datos faltantes
windows();visdat::vis_miss(Datos_Impacto)

#Imputación 
Datos_Impacto<-DMwR2::knnImputation(Datos_Impacto,k=5,scale=T,meth = "weighAvg")

windows();View(Datos_Impacto);visdat::vis_miss(Datos_Impacto)

#AFM

AFM_Datos_Impacto=MFA(Datos_Impacto, group=c(2,6,2,4,3,3,7),name.group=c("Socio demográficas","Ubicación y transporte","Sitios sostenibles","Eficiencia de Agua","Energía y atmósfera", "Materiales y recursos","Calidad del Ambiente Interior"),
graph =FALSE,num.group.sup=1)

#Gáfico por grupos
windows();fviz_mfa_var(AFM_Datos_Impacto, "group")

#Gráfico por variables con su contribución y los grupos

windows();fviz_mfa_var(AFM_Datos_Impacto, palette = "jco", col.var.sup = "violet", repel = TRUE)


windows();fviz_mfa_var(AFM_Datos_Impacto, "quanti.var", col.var = "contrib", gradient.cols = c("#00AFBB", "#E7B800", "#FC4E07"), col.var.sup = "violet", repel = TRUE,geom = c("point", "text"))

#Gráfico de individuos
windows();fviz_mfa_ind(AFM_Datos_Impacto, col.ind = "cos2", gradient.cols = c("#00AFBB", "#E7B800", "#FC4E07"),repel = TRUE)



#===========Clustering
Clust_Datos_Impacto= HCPC(AFM_Datos_Impacto, graph = FALSE)


# Individuals facor map
windows();fviz_cluster(Clust_Datos_Impacto, geom = "point", main = "Factor map")
z=Clust_Datos_Impacto$desc.var
table(z$quanti$`2`)
install.packages("knitr")

library(knitr)
Variables=names(Datos_Impacto)
Grupo_1=c(rep("X",2),rep("",22),"X","","")
Grupo_2=c(rep("",5),"X","","X","","X","X","X","","X","X",rep("",5),"X",rep("",5),"X")
Grupo_3=c(rep("",2),"X",rep("",5),"X","X","X","","X","X","X","X","X","","X","X",rep("",),"X","")
kable(cbind(Variables,Grupo_1,Grupo_2,Grupo_3))

x=c("ñ")