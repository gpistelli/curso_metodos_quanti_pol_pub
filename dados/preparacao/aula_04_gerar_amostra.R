# Gerador opcional; NAO e pre-requisito para executar as aulas.
set.seed(20261109)
i <- 1:24
investimento <- 1 + (i * 7) %% 9
porte <- 1 + (i * 3 + floor(i / 4)) %% 5
programa <- as.integer(i %% 3 == 0)
salario <- round(1.5 + .19 * investimento + .23 * porte + .12 * programa + (((i * 11) %% 7) - 3) * .09, 2)
formal <- as.integer(((i * 13 + investimento + porte + programa * 4) %% 17) < (4 + investimento + programa * 2))
d <- data.frame(id=i, investimento, porte, programa, salario, formal)
dir.create("dados/amostras/aula_04", recursive=TRUE, showWarnings=FALSE)
write.csv(d, "dados/amostras/aula_04/estabelecimentos_ficticios.csv", row.names=FALSE, quote=FALSE)
