# Aula 03 — Amostragem, IC, bootstrap e verossimilhança
# Dados 100% sintéticos, SEM inferência para o Brasil.
# Executar a partir da raiz do repositório; R base, sem downloads.
dados <- read.csv("dados/amostras/aula_03/observacoes_ficticias.csv",
                  stringsAsFactors = FALSE)
stopifnot(nrow(dados) == 100L, !anyNA(dados$formal),
          all(dados$formal %in% 0:1), sum(dados$formal) == 64)
y <- dados$formal
n <- length(y)
phat <- mean(y)
ep <- sqrt(phat * (1-phat)/n)
ic_wald <- phat + c(-1,1)*qnorm(0.975)*ep
set.seed(20261106)
B <- 5000L
boot <- replicate(B, mean(sample(y, size=n, replace=TRUE)))
ep_boot <- sd(boot)
ic_boot <- unname(quantile(boot, c(0.025,0.975)))
loglik <- function(p) {
  if (p<=0 || p>=1) return(-Inf)
  sum(dbinom(y, 1, p, log=TRUE))
}
mv <- optimize(loglik, interval=c(.001,.999), maximum=TRUE)$maximum
stopifnot(abs(phat-.64)<1e-12, abs(ep-.048)<1e-12,
          abs(mv-.64)<.001)
print(list(n=n, sucessos=sum(y), phat=phat, erro_padrao=ep,
           ic_wald=ic_wald, ep_boot=ep_boot, ic_boot=ic_boot,
           mle_analitico=phat, mle_numerico=mv))
cat("Exercício 2: n=150, sucessos=81\n")
p2 <- 81/150
se2 <- sqrt(p2*(1-p2)/150)
print(list(p=p2,se=se2,ic=p2+c(-1,1)*qnorm(.975)*se2))
cat("Exercício 3: razão de SE com n=400 vs n=100 =",sqrt(100/400),"\n")
sessionInfo()
