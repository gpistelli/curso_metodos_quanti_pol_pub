# Gerador opcional — Aula 10. Nao executar como pre-requisito.
# Reconstroi exatamente a amostra sintetica didatica versionada.
set.seed(20261123)
d <- data.frame(
  id=1:16,
  vinculo=c("formal","formal","formal","formal","formal","informal",
            "informal","informal","formal","formal","informal","formal",
            "informal","formal","informal","formal"),
  qualificacao=c("alta","alta","alta","baixa","baixa","baixa",
                  "baixa","alta","alta","baixa","baixa","alta",
                  "alta","baixa","baixa","alta"),
  remuneracao=c("alta","alta","baixa","alta","baixa","baixa",
                "baixa","baixa","alta","baixa","baixa","alta",
                "alta","alta","alta","baixa"),
  setor=c("industria","industria","servicos","industria","servicos",
          "servicos","agro","servicos","servicos","industria",
          "agro","industria","servicos","industria","agro","servicos"),
  exposicao_politica=c("sim","sim","nao","sim","nao","nao","nao",
                       "nao","sim","sim","nao","sim","nao","nao",
                       "nao","sim")
)
dir.create("dados/amostras/aula_10",recursive=TRUE,showWarnings=FALSE)
write.csv(d,"dados/amostras/aula_10/perfis_sinteticos.csv",row.names=FALSE)
