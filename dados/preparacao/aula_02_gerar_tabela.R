# Geração opcional e determinística da tabela da Aula 02.
# NÃO é pré-requisito para executar a aula ou exercícios.
set.seed(20261104)
d <- data.frame(programa=c("sim","sim","nao","nao"),
                formal=c("sim","nao","sim","nao"),
                n=c(30L,10L,80L,80L))
write.csv(d, "dados/amostras/aula_02/tabela_ficticia.csv", row.names=FALSE,
          quote=FALSE)
