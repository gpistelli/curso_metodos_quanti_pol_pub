# Gerador OPCIONAL, não executar para acompanhar a aula.
set.seed(20261113)
d <- expand.grid(j=1:4,tratado=0:1,tempo=c(-2L,-1L,0L))
d$id <- paste0(ifelse(d$tratado==1,"T","C"),d$j)
d$grupo <- ifelse(d$tratado==1,"tratado","controle")
d$resultado <- ifelse(d$tratado==1,50,40)+2*(d$tempo+2)+c(-3,-1,1,3)[d$j]+8*as.integer(d$tratado==1 & d$tempo==0)
d$post <- as.integer(d$tempo==0)
d <- d[order(d$tratado,d$j,d$tempo),c("id","grupo","tempo","tratado","post","resultado")]
write.csv(d,"dados/amostras/aula_06/painel_ficticio.csv",row.names=FALSE,quote=FALSE)
