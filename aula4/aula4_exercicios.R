# Curso: Introdução à Análise de Pesquisa Quantitativa
# Professor: Viktor Chagas
# Semestre Letivo: 2020.2
# Aula: 4
# Programa de curso: https://rpubs.com/viktor/workshop_rstats

### RESPOSTAS

### EXERCÍCIO 1

# Considere os dados do IBGE sobre a população brasileira dividida em municípios em 2019
install.packages("devtools")
devtools::install_github("tbrugz/ribge")
populacao2019 <- ribge::populacao_municipios(2019)

# 1. Quais os cinco municípios com maior população no estado do Rio de Janeiro?

# Três alternativas de resposta

# Alternativa 1
populacao2019 %>% 
  select(uf, nome_munic, populacao) %>% 
  filter(uf == "RJ") %>% 
  arrange(desc(populacao)) %>% 
  head(5)

# Alternativa 2
populacao2019 %>% 
  select(uf, nome_munic, populacao) %>% 
  filter(uf == "RJ") %>% 
  arrange(desc(populacao)) %>% 
  top_n(n = 5)

# Alternativa 3
populacao_rj <- populacao2019 %>% 
  select(uf, nome_munic, populacao) %>% 
  filter(uf == "RJ") %>% 
  arrange(desc(populacao))
populacao_rj[1:5,] # Seleciona somente as linhas de 1 a 5 do dataframe

# 2. Qual a média populacional dos municípios do Rio de Janeiro?

populacao2019 %>% 
  group_by(uf) %>% 
  summarise(media = mean(populacao)) %>% 
  filter(uf == "RJ")

# 3. Quantos municípios do Rio de Janeiro estão acima dessa média?

populacao2019 %>% 
  filter(uf == "RJ") %>% 
  filter(populacao >= mean(populacao)) %>% 
  count()

### EXERCÍCIO 2

# Considere os dados oficiais do TSE a respeito dos candidatos nas eleições de 2018
install.packages("electionsBR")
candidatos_brasil <- electionsBR::candidate_fed(2018)

# 1. Crie uma tabela somente com os dados dos nomes dos candidatos na urna, siglas dos partidos,
# estado por que se candidataram, estado em que nasceram, idade, sexo, raça e 
# grau de instrução, nessa ordem.

# Em alguns casos, o dataframe importado pelo pacote electionsBR pode diferir quanto
# ao nome das variáveis. SIGLA_PARTIDO pode aparecer como SG_PARTIDO e DESCRICAO_SEXO
# como DS_GENERO. O comando, no entanto, é idêntico, guardadas essas variações.

candidatos_resumo <- candidatos_brasil %>% 
  select(NOME_URNA_CANDIDATO, SIGLA_PARTIDO, SIGLA_UF, SIGLA_UF_NASCIMENTO, IDADE_DATA_POSSE,
         DESCRICAO_SEXO, DESCRICAO_COR_RACA, DESCRICAO_GRAU_INSTRUCAO)

# 2. Quais partidos têm mais pretos ou pardos como candidatos?

candidatos_resumo %>% 
  filter(DESCRICAO_COR_RACA == "PARDA" | DESCRICAO_COR_RACA == "PRETA") %>% 
  group_by(SIGLA_PARTIDO) %>% 
  summarise(DESCRICAO_COR_RACA) %>% 
  count() %>% 
  arrange(desc(n))

# 3. Quais partidos têm mais mulheres como candidatas?

candidatos_resumo %>% 
  filter(DESCRICAO_SEXO == "FEMININO") %>% 
  group_by(SIGLA_PARTIDO) %>% 
  summarise(DESCRICAO_SEXO) %>% 
  count() %>% 
  arrange(desc(n))

# 4. Quantos e quais candidatos se candidataram por um estado diferente daquele que nasceram?
# E qual a porcentagem de candidatos que se candidatam por um estado diferente do que nasceram?

quais <- candidatos_resumo %>% 
  filter(SIGLA_UF != SIGLA_UF_NASCIMENTO)

quantos <- candidatos_resumo %>% 
  filter(SIGLA_UF != SIGLA_UF_NASCIMENTO) %>% 
  count()
quantos/count(candidatos_resumo)

scales::percent(as.numeric(quantos/count(candidatos_resumo))) # Se quisermos transformar em
                                                              # um percentual de fato, é
                                                              # necessário utilizar o pacote
                                                              # scales ou multiplicar o resultado
                                                              # por 100


