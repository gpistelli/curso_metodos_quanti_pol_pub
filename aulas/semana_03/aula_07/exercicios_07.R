# Aula 7/18 — análise sobre dados sintéticos publicados
# Execução: Rscript aulas/semana_03/aula_07/exercicios_07.R (na raiz do repositório)
# Origem: dados/amostras/aula_07/manifesto.md; nenhum dado real.
path <- "dados/amostras/aula_07/coorte_sintetica.csv"
stopifnot(file.exists(path))
d <- read.csv(path, stringsAsFactors=FALSE)
stopifnot(nrow(d)==20, all(d$sucesso %in% 0:1), !anyNA(d$sucesso))
n <- nrow(d); y <- sum(d$sucesso)
stopifnot(n==20,y==6)
priors <- data.frame(nome=c("uniforme","concentrada_baixa","simetrica"),
                     a=c(1,2,10),b=c(1,18,10))
res <- transform(priors, A=a+y, B=b+n-y)
res$media_prior <- with(res,a/(a+b))
res$media_posterior <- with(res,A/(A+B))
res$li95 <- with(res,qbeta(.025,A,B))
res$ls95 <- with(res,qbeta(.975,A,B))
res$prob_maior_025 <- with(res,1-pbeta(.25,A,B))
print(res)
A <- 8; B <- 32; m <- 5; k <- 0:m
pred <- choose(m,k)*beta(A+k,B+m-k)/beta(A,B)
stopifnot(abs(sum(pred)-1)<1e-10,
          abs(sum(k*pred)-1)<1e-10)
print(data.frame(k,probabilidade=pred))
# Opcional: exportar resultados sem alterar dados de entrada
dir.create("resultados/aula_07",recursive=TRUE,showWarnings=FALSE)
write.csv(res,"resultados/aula_07/sensibilidade.csv",row.names=FALSE)
write.csv(data.frame(k,probabilidade=pred),
          "resultados/aula_07/preditiva.csv",row.names=FALSE)
cat("R:",R.version.string,"\n")
