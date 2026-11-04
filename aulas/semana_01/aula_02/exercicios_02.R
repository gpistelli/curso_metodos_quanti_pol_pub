# Aula 02 — Funções, matrizes, condicionamento e Bayes
# Executar da raiz do projeto; depende apenas de base R.
d <- read.csv("dados/amostras/aula_02/tabela_ficticia.csv",
              stringsAsFactors = FALSE)
stopifnot(nrow(d) == 4L, all(d$n >= 0), sum(d$n) == 200,
          setequal(unique(d$programa), c("sim","nao")),
          setequal(unique(d$formal), c("sim","nao")))
tab <- xtabs(n ~ programa + formal, data = d)
p_b <- sum(tab["sim", ]) / sum(tab)
p_f_b <- tab["sim","sim"] / sum(tab["sim", ])
p_f_naob <- tab["nao","sim"] / sum(tab["nao", ])
p_f <- p_f_b*p_b + p_f_naob*(1-p_b)
p_b_f <- p_f_b*p_b/p_f
p_intersecao <- tab["sim","sim"]/sum(tab)
p_uniao <- p_b + p_f - p_intersecao
print(tab)
print(c(P_B=p_b, P_F_dado_B=p_f_b, P_F=p_f,
        P_B_dado_F=p_b_f, P_intersecao=p_intersecao,
        P_uniao=p_uniao))
stopifnot(isTRUE(all.equal(unname(p_b_f), 30/110)),
          isTRUE(all.equal(unname(p_uniao), 0.60)))
X <- cbind(intercepto=1, indice=1:4)
beta <- c(50,2)
print(X %*% beta)
stopifnot(identical(as.numeric(X %*% beta), c(52,54,56,58)))
print(plogis(c(0,2)))
# Exercicio 5: sensibilidade 0.9, especificidade 0.95, prevalencia 0.05
prev <- 0.05; sens <- 0.90; esp <- 0.95
ppv <- sens*prev/(sens*prev+(1-esp)*(1-prev))
print(c(valor_preditivo_positivo=ppv))
stopifnot(isTRUE(all.equal(ppv, 0.4864864864864865)))
sessionInfo()
