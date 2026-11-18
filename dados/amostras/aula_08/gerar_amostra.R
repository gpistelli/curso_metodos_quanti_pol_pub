# Gerador OPCIONAL; nunca necessario para executar exercicios_08.R
# Origem inteiramente sintética, determinística. Semente registrada.
set.seed(20261118)
d <- data.frame(id=1:20,sucesso=as.integer((1:20) %in% c(2,5,7,11,16,19)))
dir.create("dados/amostras/aula_08",recursive=TRUE,showWarnings=FALSE)
write.csv(d,"dados/amostras/aula_08/coorte_sintetica.csv",row.names=FALSE)
