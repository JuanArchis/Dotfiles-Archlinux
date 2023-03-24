Semestres=c("I_Semestre","II_Semestre")

for (i in 1:length(Semestres)) {

Sipsa_Abs = read.xlsx("/home/juan-c/Descargas/Metodologia_CIAT-main/datos_primarios/abastecimiento_sipsa_fuente/microdato-abastecimiento-2022.xlsx",sheet = i+1)
colnames(Sipsa_Abs) = c("Ciudad_Mercado", "Fecha","Cod_Dep", "Cod_Mun", "Dep_Proc", "Mun_Proc","Grupo", "Alimento", "Cantidad_KG")

  Sipsa_Abs$Cod_Mun <- gsub("'", "", Sipsa_Abs$Cod_Mun)
  Sipsa_Abs$Cod_Dep <- gsub("'", "", Sipsa_Abs$Cod_Dep)

Sipsa_Abs = Sipsa_Abs %>% mutate_if(is.character,as.factor)
sipsa_abs_nombre=paste("Sipsa_Abs",Semestres[i], sep = "_");assign(sipsa_abs_nombre,Sipsa_Abs);rm(Sipsa_Abs)

}