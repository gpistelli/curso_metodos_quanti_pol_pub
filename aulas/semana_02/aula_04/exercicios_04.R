# Aula 04 — executar a partir da raiz do repositorio. Apenas R base.
# Fonte: dados sinteticos versionados, manifesto em dados/amostras/aula_04/manifesto.yml
# Nao baixar microdados. Nao inferir para empresas reais.
d <- read.csv("dados/amostras/aula_04/estabelecimentos_ficticios.csv")
stopifnot(nrow(d)==24L, !anyNA(d), all(d$formal %in% 0:1), all(d$programa %in% 0:1))
print(summary(d))
# MQO simples e multiplo
m_simples <- lm(salario ~ investimento, data=d)
m_linear <- lm(salario ~ investimento + porte + programa, data=d)
print(summary(m_simples)); print(summary(m_linear))
# Exemplo numerico independente da amostra
x <- 1:4; y <- c(2,3,5,6)
stopifnot(isTRUE(all.equal(unname(coef(lm(y~x))),c(.5,1.4))))
# HC1 calculado em R base; observacoes tratadas como independentes somente para ilustracao
X <- model.matrix(m_linear); u <- residuals(m_linear)
n <- nrow(X); k <- ncol(X)
B <- solve(crossprod(X))
meat <- crossprod(X, X * as.numeric(u^2))
V_HC1 <- (n/(n-k)) * B %*% meat %*% B
print(data.frame(coef=coef(m_linear), se_classico=sqrt(diag(vcov(m_linear))), se_HC1=sqrt(diag(V_HC1))))
# Regressao logistica: coeficientes em log-odds, exp(coef) em odds ratios
m_logit <- glm(formal ~ investimento + porte + programa, data=d, family=binomial())
print(summary(m_logit)); print(exp(coef(m_logit)))
prob <- predict(m_logit, type="response")
stopifnot(all(prob>0 & prob<1))
print(head(prob))
# Exemplo de razao de chances de 1.5 partindo de p=0.4
p0 <- .4; odds0 <- p0/(1-p0); p1 <- 1.5*odds0/(1+1.5*odds0)
print(p1) # 0.5
print(sessionInfo())
