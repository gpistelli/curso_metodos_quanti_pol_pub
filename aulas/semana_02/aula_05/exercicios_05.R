# Aula 05 — laboratório reprodutível, somente R base
# Dados: sintéticos, gerados didaticamente; NÃO são observações reais.
# Executar a partir da raiz do repositório.
d <- read.csv("dados/amostras/aula_05/celulas_ficticias.csv", stringsAsFactors = FALSE)
stopifnot(nrow(d)==4L, sum(d$n)==200L, all(d$sucessos<=d$n), all(d$n>0))
d$taxa <- d$sucessos/d$n
print(d)
ag <- aggregate(cbind(sucessos,n) ~ tratamento, data=d, FUN=sum)
ag$taxa <- ag$sucessos/ag$n
print(ag)
bruta <- ag$taxa[ag$tratamento=="sim"] - ag$taxa[ag$tratamento=="nao"]
alta <- with(subset(d, produtividade=="alta"), taxa[tratamento=="sim"]-taxa[tratamento=="nao"])
baixa <- with(subset(d, produtividade=="baixa"), taxa[tratamento=="sim"]-taxa[tratamento=="nao"])
# População-alvo DIDÁTICA: 50% produtividade alta, 50% baixa.
mu1 <- mean(d$taxa[d$tratamento=="sim"])
mu0 <- mean(d$taxa[d$tratamento=="nao"])
padronizada <- mu1-mu0
stopifnot(isTRUE(all.equal(unname(bruta), .44)), abs(padronizada+1/9)<1e-10)
print(c(bruta=bruta, alta=alta, baixa=baixa, padronizada=padronizada))
# Diferenças não são efeitos causais sem hipóteses de identificação.
