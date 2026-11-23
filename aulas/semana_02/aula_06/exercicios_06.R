# Aula 06, R base, amostra 100% sintética versionada
d <- read.csv("dados/amostras/aula_06/painel_ficticio.csv")
stopifnot(nrow(d)==24L, length(unique(d$id))==8L, all(table(d$id)==3L), !anyNA(d))
d$grupo <- factor(d$grupo, levels=c("controle","tratado"))
s <- subset(d,tempo %in% c(-1L,0L))
m <- aggregate(resultado~grupo+post,s,mean)
print(m)
media <- function(g,p) m$resultado[m$grupo==g & m$post==p]
did <- (media("tratado",1)-media("tratado",0))-(media("controle",1)-media("controle",0))
stopifnot(isTRUE(all.equal(unname(did),8)))
print(did)
fit <- lm(resultado~grupo*post,data=s)
print(coef(fit))
stopifnot(isTRUE(all.equal(unname(coef(fit)["grupotratado:post"]),8)))
pre <- subset(d,tempo %in% c(-2L,-1L))
pre$post_falso <- as.integer(pre$tempo==-1L)
placebo <- coef(lm(resultado~grupo*post_falso,data=pre))["grupotratado:post_falso"]
stopifnot(abs(placebo)<1e-10)
print(placebo)
print(aggregate(resultado~grupo+tempo,d,mean))
plot(NA,xlim=c(-2,0),ylim=range(d$resultado),xlab="Tempo",ylab="Resultado sintético",main="Trajetórias fictícias")
for(g in levels(d$grupo)){a<-aggregate(resultado~tempo,subset(d,grupo==g),mean);lines(a$tempo,a$resultado,type="b",lty=if(g=="tratado")1 else 2)}
legend("topleft",legend=levels(d$grupo),lty=c(2,1),bty="n")
