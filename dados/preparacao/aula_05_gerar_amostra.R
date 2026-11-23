# Gerador opcional; não executar como pré-requisito das aulas.
# Construção determinística; semente fixa registrada para padronização.
set.seed(20261111)
d <- data.frame(
 produtividade=c("alta","alta","baixa","baixa"),
 tratamento=c("sim","nao","sim","nao"),
 sucessos=c(72L,9L,1L,20L),
 n=c(90L,10L,10L,90L)
)
dir.create("dados/amostras/aula_05",recursive=TRUE,showWarnings=FALSE)
write.csv(d,"dados/amostras/aula_05/celulas_ficticias.csv",row.names=FALSE,quote=FALSE)
