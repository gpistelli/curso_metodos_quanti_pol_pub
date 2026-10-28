# Protocolo de dados

## Uso nos encontros intermediários
Preferir pequenas amostras didáticas, dados simulados e conjuntos públicos reduzidos.
Publicar as amostras permitidas junto de **manifesto de procedência**, **dicionário de variáveis**,
regras de filtragem e semente de sorteio fixa. Os scripts de análise devem funcionar
diretamente sobre as amostras versionadas, sem downloads pesados.

## Preparação original
Os scripts de obtenção e construção de amostras ficam em `preparacao/`,
separados e **nunca executados automaticamente** pelas aulas ou pela integração contínua.
Documentar fonte exata, data, versão, tratamento dos dados e processos aleatórios.
Não incluir microdados restritos, identificadores pessoais ou dados sem autorização de redistribuição.

## Inferência populacional e relatório final
**Somente o relatório/projeto final** demanda bases completas. Priorizar fontes oficiais online,
APIs e consultas remotas **quando respondam ao estimando**; se dados agregados não bastarem,
obter os microdados oficiais completos sob demanda, processando em cache local fora do Git.
Pesquisas por amostragem complexa exigem tratamento dos pesos, conglomerados e estratos.
Subamostras didáticas arbitrárias não autorizam inferências representativas.

## Integridade e versões
Documentar `SHA-256` das amostras, versões dos dados de origem e ambiente R.
Não guardar informações protegidas por direitos ou privacidade.
