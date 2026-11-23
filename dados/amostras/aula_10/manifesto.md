# Manifesto de dados — Aula 10 (23/11/2026)

- Arquivo: `perfis_sinteticos.csv`; 16 unidades inteiramente **fictícias**; nenhuma observação real.
- Origem: geração manual determinística de perfis didáticos; script de reconstrução `gerar_perfis_10.R`; semente declarada `20261123` (sem sorteios necessários).
- Fonte pública: **não se aplica**; não afirmar proveniência oficial nem representatividade.
- Data de criação/versão: 2026-11-23, versão 1.0; formato UTF-8 CSV; separador vírgula.
- Transformações: variáveis categóricas armazenadas como texto; script de análise transforma em fatores com níveis ordenados alfabeticamente e cria matriz indicadora de uma coluna por modalidade.
- Dicionário: `dicionario.md`; sem identificadores pessoais, pesos ou desenho amostral.
- Reprodutibilidade: `source("aulas/semana_04/aula_10/exercicios_10.R")` na raiz; R base, nenhuma dependência adicional. Gerador opcional, **não** é pré-requisito.
- Limitações: amostra pequena, artificial, sem variabilidade amostral representativa; resultados só servem à compreensão geométrica, não a conclusões sobre NIB, produtividade ou PcD.
- Projeto final: usar fontes oficiais adequadas ao estimando, registrando URL, data de acesso, versão, pesos, desenho e transformações quando aplicável; não substituir microdados por agregados.
