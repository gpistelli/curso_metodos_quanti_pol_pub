# Aula 10/18 — ACM a partir da matriz disjuntiva completa (R base)
# Execute da raiz do repositorio: source("aulas/semana_04/aula_10/exercicios_10.R")
# Origem: dados 100% sinteticos, gerador opcional e manifesto no mesmo diretorio.
# Nao representam o Brasil, nao sustentam inferencia populacional ou causal.
set.seed(20261123)
path <- "dados/amostras/aula_10/perfis_sinteticos.csv"
stopifnot(file.exists(path))
d <- read.csv(path, stringsAsFactors = FALSE)
stopifnot(nrow(d) == 16L, !anyNA(d))
ativas <- c("vinculo", "qualificacao", "remuneracao")
suplementares <- c("setor", "exposicao_politica")
stopifnot(all(c("id", ativas, suplementares) %in% names(d)))
# Construir explicitamente uma coluna por categoria para cada variavel
partes <- lapply(ativas, function(v) {
  f <- factor(d[[v]], levels = sort(unique(d[[v]])))
  z <- sapply(levels(f), function(k) as.integer(f == k))
  z <- matrix(z, nrow = nrow(d))
  colnames(z) <- paste(v, levels(f), sep = "_")
  z
})
Z <- do.call(cbind, partes)
Q <- length(ativas); n <- nrow(Z); K <- ncol(Z)
stopifnot(all(rowSums(Z) == Q), all(colSums(Z) > 0))
N <- Z / sum(Z)
r <- rowSums(N)
mass <- colSums(N)
S <- sweep(sweep(N - outer(r, mass), 1, sqrt(r), "/"),
           2, sqrt(mass), "/")
decomp <- svd(S)
keep <- which(decomp$d > 1e-10)
lambda <- decomp$d[keep]^2
F <- sweep(decomp$u[,keep,drop=FALSE], 1, sqrt(r), "/") %*%
     diag(decomp$d[keep], nrow=length(keep))
G <- sweep(decomp$v[,keep,drop=FALSE], 1, sqrt(mass), "/") %*%
     diag(decomp$d[keep], nrow=length(keep))
rownames(F) <- paste0("unidade_", d$id)
rownames(G) <- colnames(Z)
colnames(F) <- colnames(G) <- paste0("Dim", seq_along(keep))
ctr <- sweep(sweep(G^2, 1, mass, "*"), 2, lambda, "/")
cos2 <- sweep(G^2, 1, rowSums(G^2), "/")
stopifnot(abs(sum(lambda) - (K/Q - 1)) < 1e-8)
stopifnot(all(abs(colSums(ctr)-1) < 1e-8))
cat("Inercia total:", sum(lambda), "\n")
print(data.frame(eixo=seq_along(lambda), inercia=lambda,
                 proporcao=lambda/sum(lambda)))
cat("\nCoordenadas de modalidades:\n")
print(round(G[,seq_len(min(2,ncol(G))),drop=FALSE],3))
cat("\nContribuicoes:\n")
print(round(ctr[,seq_len(min(2,ncol(ctr))),drop=FALSE],3))
cat("\nCos2:\n")
print(round(cos2[,seq_len(min(2,ncol(cos2))),drop=FALSE],3))
# Resumo suplementar: centroides dos individuos; nao alteram os eixos
for (v in suplementares) {
  cat("\nVariavel suplementar:", v, "\n")
  print(aggregate(F[,seq_len(min(2,ncol(F))),drop=FALSE],
                  by=list(grupo=d[[v]]), FUN=mean))
}
# Graficos em arquivo local; nao sao obrigatorios para executar analises
if (ncol(G) >= 2L) {
  plot(G[,1:2], pch=19, col="steelblue", asp=1,
       xlab="Dimensao 1", ylab="Dimensao 2",
       main="ACM — modalidades ativas (dados sinteticos)")
  text(G[,1:2], labels=rownames(G), pos=3, cex=.75)
  abline(h=0,v=0,lty=3,col="gray70")
}
cat("\nR:", R.version.string, "\n")
print(sessionInfo())
