# Script opcional de construcao — NAO executar como dependencia das aulas
# Dados sinteticos deterministas; semente registrada para padronizacao
set.seed(20261106)
dir.create("dados/amostras/aula_03", recursive=TRUE, showWarnings=FALSE)
dados <- data.frame(id=1:100, formal=c(rep(1L,64),rep(0L,36)))
write.csv(dados, "dados/amostras/aula_03/observacoes_ficticias.csv", row.names=FALSE, quote=FALSE)
