# Aula 01 — Exercícios e laboratório em R
# Execução: a partir da raiz do repositório:
# Rscript aulas/semana_01/aula_01/exercicios_01.R
# Fonte: conjunto 100% FICTÍCIO e versionado em
# dados/amostras/aula_01/territorios_ficticios.csv
# Sem acesso à internet, sem pacotes externos e sem inferência populacional.
# R 4.5.1 registrado no renv.lock; funciona também com R base recente.

arquivo <- file.path("dados", "amostras", "aula_01", "territorios_ficticios.csv")
stopifnot(file.exists(arquivo))
d <- read.csv(arquivo, stringsAsFactors = FALSE, check.names = FALSE)

# Auditoria da estrutura e consistência dos denominadores
stopifnot(nrow(d) == 8L, !anyNA(d),
          setequal(unique(d$exposicao), c("alta", "baixa")),
          all(d$ocupados > 0),
          all(d$formais >= 0 & d$formais <= d$ocupados),
          all(d$pcd_ocupados >= 0 & d$pcd_ocupados <= d$ocupados),
          !anyDuplicated(d$territorio))

# Agregar contagens antes de calcular razões (denominador correto)
ag <- aggregate(cbind(formais, ocupados, pcd_ocupados) ~ exposicao,
                data = d, FUN = sum)
ag$proporcao_formal <- ag$formais / ag$ocupados
ag$participacao_pcd <- ag$pcd_ocupados / ag$ocupados
ag <- ag[order(ag$exposicao), ]
print(ag, row.names = FALSE)

p_a <- ag$proporcao_formal[ag$exposicao == "alta"]
p_b <- ag$proporcao_formal[ag$exposicao == "baixa"]
diferenca_pp <- 100 * (p_a - p_b)
diferenca_relativa <- p_a / p_b - 1

cat(sprintf("Diferença descritiva: %.1f pontos percentuais\n", diferenca_pp))
cat(sprintf("Diferença relativa: %.1f%%\n", 100 * diferenca_relativa))
stopifnot(isTRUE(all.equal(diferenca_pp, 15)),
          isTRUE(all.equal(diferenca_relativa, 0.24)))

# Verificação de que não estamos confundindo indicadores:
# participacao_pcd = PcD ocupadas / todos os ocupados
# nivel_ocupacao_pcd exigiria total de PcD em idade de trabalhar.
stopifnot(isTRUE(all.equal(
  ag$participacao_pcd[ag$exposicao == "alta"], 0.075
)))
stopifnot(isTRUE(all.equal(
  ag$participacao_pcd[ag$exposicao == "baixa"], 0.045
)))

# Exercício 1: classifique perguntas por finalidade analítica.
# Exercício 2: descreva a unidade e o denominador de cada indicador.
# Exercício 3: refaça os cálculos manualmente e interprete escalas.
# Exercício 4: construa uma matriz de indicadores de qualidade do emprego.
# Exercício 5: critique a interpretação causal de um contraste territorial.
# Exercício 6: escreva um protocolo descritivo e outro causal para a NIB.
# Soluções: resolucoes_01.qmd

cat("\nSessão do R:\n")
print(sessionInfo())
