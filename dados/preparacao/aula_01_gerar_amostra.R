# CONSTRUCAO OPCIONAL da amostra da Aula 01
# Nao executar como pre-requisito para aulas ou CI.
# Fonte: dados inteiramente inventados para fins didaticos.
# Nenhum download, API ou microdado oficial e utilizado.
# Executar da raiz do projeto apenas para reconstruir o CSV versionado.

set.seed(20261102)  # semente registrada; nenhum sorteio ocorre neste script
d <- data.frame(
  territorio = sprintf("T%02d", 1:8),
  exposicao = c(rep("alta", 4), rep("baixa", 4)),
  ocupados = rep(100L, 8),
  formais = c(70L, 80L, 75L, 85L, 60L, 65L, 55L, 70L),
  pcd_ocupados = c(6L, 8L, 7L, 9L, 4L, 5L, 3L, 6L),
  stringsAsFactors = FALSE
)
destino <- file.path("dados", "amostras", "aula_01",
                     "territorios_ficticios.csv")
dir.create(dirname(destino), recursive = TRUE, showWarnings = FALSE)
write.csv(d, destino, row.names = FALSE, quote = FALSE)
cat("CSV reconstruido em", destino, "\n")
# Para registrar integridade: tools::md5sum(destino) (MD5) ou
# sha256sum dados/amostras/aula_01/territorios_ficticios.csv (SHA-256)
