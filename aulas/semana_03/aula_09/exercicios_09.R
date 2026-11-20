# Aula 09 — análise didática, R base, semente de geração 20261120
# Origem: dados 100% sintéticos, NÃO oficiais. Sem inferência populacional.
# Fonte/manifesto: dados/amostras/aula_09/MANIFESTO.md
d <- read.csv("dados/amostras/aula_09/observacoes_sinteticas.csv")
stopifnot(identical(as.integer(d$tempo), seq_len(nrow(d))),
          all(d$observado %in% c(0L,1L)))
P <- matrix(c(.8,.2,.3,.7),2,byrow=TRUE,
            dimnames=list(c("B","Q"),c("B","Q")))
E <- matrix(c(.9,.1,.2,.8),2,byrow=TRUE,
            dimnames=list(c("B","Q"),c("0","1")))
delta <- c(.6,.4)
stopifnot(all(abs(rowSums(P)-1)<1e-12),
          all(abs(rowSums(E)-1)<1e-12))
print(P %*% P)
stopifnot(max(abs(unname(P%*%P)-matrix(c(.70,.30,.45,.55),2,byrow=TRUE)))<1e-12)
pi <- c(1,0)
for (j in seq_len(100)) pi <- as.numeric(pi %*% P)
stopifnot(max(abs(pi-c(.6,.4)))<1e-10)
print(pi)
forward <- function(obs,P,E,delta) {
  stopifnot(length(obs)>0, length(delta)==nrow(P),
            ncol(P)==nrow(P), nrow(E)==nrow(P))
  filt <- matrix(NA_real_,length(obs),length(delta))
  scales <- numeric(length(obs))
  z <- delta*E[,obs[1]+1L]
  scales[1] <- sum(z)
  stopifnot(scales[1]>0)
  filt[1,] <- z/scales[1]
  if(length(obs)>1) for(t in 2:length(obs)) {
    z <- as.numeric(filt[t-1,]%*%P)*E[,obs[t]+1L]
    scales[t] <- sum(z)
    stopifnot(scales[t]>0)
    filt[t,] <- z/scales[t]
  }
  colnames(filt) <- c("B","Q")
  list(filtered=filt,logLik=sum(log(scales)))
}
fit <- forward(d$observado,P,E,delta)
stopifnot(all(abs(rowSums(fit$filtered)-1)<1e-12),
          is.finite(fit$logLik))
print(data.frame(tempo=d$tempo,observado=d$observado,fit$filtered))
print(fit$logLik)
# Teste analítico do primeiro passo, independentemente da série do CSV
test <- forward(1L,P,E,delta)
stopifnot(abs(test$filtered[1,"Q"]-(.32/.38))<1e-12)
# Sensibilidade: emissões alternativas hipotéticas
E2 <- matrix(c(.8,.2,.3,.7),2,byrow=TRUE)
fit2 <- forward(d$observado,P,E2,delta)
print(c(logLik_base=fit$logLik,logLik_alternativo=fit2$logLik))
