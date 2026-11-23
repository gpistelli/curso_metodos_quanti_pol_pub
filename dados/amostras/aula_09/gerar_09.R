# Gerador OPCIONAL. Não é pré-requisito da análise.
set.seed(20261120)
dir.create("dados/amostras/aula_09",recursive=TRUE,showWarnings=FALSE)
d <- data.frame(tempo=1:12,
                observado=c(1,0,1,1,0,0,1,1,1,0,1,0))
write.csv(d,"dados/amostras/aula_09/observacoes_sinteticas.csv",row.names=FALSE,quote=FALSE)
