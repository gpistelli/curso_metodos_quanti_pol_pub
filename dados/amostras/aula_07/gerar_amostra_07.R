# Gerador opcional — NÃO necessário para executar exercicios_07.R
set.seed(20261116)
d <- data.frame(id=1:20, sucesso=as.integer((1:20)<=6))
dir.create("dados/amostras/aula_07",recursive=TRUE,showWarnings=FALSE)
write.csv(d,"dados/amostras/aula_07/coorte_sintetica.csv",row.names=FALSE,quote=FALSE)
