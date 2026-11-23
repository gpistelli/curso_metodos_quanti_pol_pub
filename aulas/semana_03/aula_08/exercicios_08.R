# Aula 08 — MCMC Metropolis; R base, sem downloads
# Dados: amostra sintética versionada; semente 20261118
path <- "dados/amostras/aula_08/coorte_sintetica.csv"
if (!file.exists(path)) stop("Execute a partir da raiz do repositorio")
d <- read.csv(path)
stopifnot(nrow(d)==20, all(d$sucesso %in% 0:1), sum(d$sucesso)==6)
n <- nrow(d); y <- sum(d$sucesso); a <- 2; b <- 18
A <- a+y; B <- b+n-y
logpost_z <- function(z,A,B) {
  p <- plogis(z)
  dbeta(p,A,B,log=TRUE) + log(p) + log1p(-p)
}
metropolis <- function(n,start,sd_step,A,B) {
  z <- numeric(n); z[1] <- qlogis(start)
  accepted <- 0L
  for(i in 2:n) {
    candidate <- rnorm(1,z[i-1],sd_step)
    lr <- logpost_z(candidate,A,B)-logpost_z(z[i-1],A,B)
    if(is.finite(lr) && log(runif(1)) < min(0,lr)) {
      z[i] <- candidate; accepted <- accepted+1L
    } else z[i] <- z[i-1]
  }
  list(p=plogis(z),acceptance=accepted/(n-1))
}
set.seed(20261118)
starts <- c(.03,.15,.5,.85)
runs <- lapply(starts,function(s) metropolis(12000,s,.65,A,B))
retained <- lapply(runs,function(x) x$p[2001:12000])
cat("Taxas de aceitacao:\n"); print(sapply(runs,\`[[\`,"acceptance"))
cat("Medias por cadeia:\n"); print(sapply(retained,mean))
cat("Media exata:\n"); print(A/(A+B))
cat("Quantis exatos:\n"); print(qbeta(c(.025,.5,.975),A,B))
allp <- unlist(retained)
cat("Quantis MCMC:\n"); print(quantile(allp,c(.025,.5,.975)))
cat("Probabilidade p>0.25: MCMC e exata:\n")
print(c(mean(allp>.25),1-pbeta(.25,A,B)))
# ESS ilustrativo via soma de autocorrelacoes positivas
ess_simple <- function(x,maxlag=500) {
  ac <- as.numeric(acf(x,plot=FALSE,lag.max=maxlag)$acf)[-1]
  first_nonpositive <- which(ac<=0)[1]
  if(!is.na(first_nonpositive)) ac <- head(ac,first_nonpositive-1)
  length(x)/(1+2*sum(ac))
}
ess <- sapply(retained,ess_simple)
cat("ESS aproximado por cadeia:\n"); print(ess)
cat("MCSE aproximado da media (cadeias combinadas):\n")
print(sd(allp)/sqrt(sum(ess)))
# Rhat classico ilustrativo (nao rank-normalized)
mat <- do.call(cbind,retained)
W <- mean(apply(mat,2,var))
Bn <- nrow(mat)*var(colMeans(mat))
Vhat <- ((nrow(mat)-1)/nrow(mat))*W+Bn/nrow(mat)
cat("Rhat classico ilustrativo:\n"); print(sqrt(Vhat/W))
# Comparacao com draws independentes exatos
exact_draws <- rbeta(length(allp),A,B)
cat("Media rbeta:\n"); print(mean(exact_draws))
# Graficos opcionais (base R)
op <- par(mfrow=c(2,2))
for(i in seq_along(retained)) plot(retained[[i]],type="l",
  main=paste("Cadeia",i),xlab="Iteracao retida",ylab="p")
par(op)
op <- par(mfrow=c(1,2))
acf(retained[[1]],main="Autocorrelacao — cadeia 1")
hist(allp,breaks=50,probability=TRUE,main="Posterior MCMC",xlab="p")
curve(dbeta(x,A,B),add=TRUE,col=2,lwd=2)
par(op)
# Sensibilidade analitica
priors <- rbind(c(1,1),c(2,18),c(10,10))
print(data.frame(a=priors[,1],b=priors[,2],
  media=(priors[,1]+y)/(rowSums(priors)+n)))
sessionInfo()
