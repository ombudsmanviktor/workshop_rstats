# Curso: Introdução à Análise de Pesquisa Quantitativa
# Professor: Viktor Chagas
# Semestre Letivo: 2020.2
# Aula: 5
# Programa de curso: https://rpubs.com/viktor/workshop_rstats

# Respostas dos exercícios

### EXERCÍCIO 1

# Considere a base de dados abaixo:

eleicao_candidato_nomes <- read.csv(
  "https://raw.githubusercontent.com/ombudsmanviktor/workshop_rstats/main/aula5/eleicao_candidato_nomes.csv"
)

# 1. Insira uma chave substituta para que as observações na tabela possuam um identificador único

eleicao_candidato_nomes <- eleicao_candidato_nomes %>% 
  mutate(id_candidato = row_number())

### EXERCÍCIO 2

# Considere as tabelas de dados relacionais abaixo:

eleicao_info <- read.csv("https://raw.githubusercontent.com/ombudsmanviktor/workshop_rstats/main/aula5/eleicao_info.csv")
eleicao_partido <- read.csv("https://raw.githubusercontent.com/ombudsmanviktor/workshop_rstats/main/aula5/eleicao_partido.csv")
eleicao_candidato <- read.csv("https://raw.githubusercontent.com/ombudsmanviktor/workshop_rstats/main/aula5/eleicao_candidato.csv")
eleicao_composicao <- read.csv("https://raw.githubusercontent.com/ombudsmanviktor/workshop_rstats/main/aula5/eleicao_composicao.csv")
eleicao_candidato_somentept <- read.csv("https://raw.githubusercontent.com/ombudsmanviktor/workshop_rstats/main/aula5/eleicao_candidato_somentept.csv")

# 1. Monte uma tabela com o nome do candidato na urna, o cargo que disputa, a sigla do estado 
# pelo qual disputa as eleições, a sigla de seu partido e os partidos em sua coligação

eleicao_final <- eleicao_info %>% 
  left_join(eleicao_candidato, by = c("candidato_id", "partido_id")) %>% 
  left_join(eleicao_partido, by = c("partido_id", "coligacao_id", "uf")) %>% 
  left_join(eleicao_composicao, by = c("coligacao_id", "uf")) %>% 
  select(nome_urna, candidato_cargo, uf, partido_sigla, coligacao_partido)

# 2. Monte uma tabela somente com as candidatas petistas mulheres que disputaram o cargo
# de deputadas federais e que apresente nome da candidata na urna e sigla do estado em que
# concorreu ordenado alfabeticamente

eleicao_pt_mulher <- eleicao_candidato_somentept %>% 
  inner_join(eleicao_candidato, by = c("candidato_id", "nome_urna", "nome")) %>%
  inner_join(eleicao_info, by = c("candidato_id", "partido_id")) %>% 
  filter(genero == "FEMININO" & candidato_cargo == "DEPUTADO FEDERAL") %>% 
  select(nome_urna, uf) %>% 
  arrange(nome_urna)

### EXERCÍCIO 3

# Considere as tabelas de dados relacionais abaixo:

eleicao_Norte <- read.csv("https://raw.githubusercontent.com/ombudsmanviktor/workshop_rstats/main/aula5/eleicao_Norte.csv")
eleicao_Nordeste <- read.csv("https://raw.githubusercontent.com/ombudsmanviktor/workshop_rstats/main/aula5/eleicao_Nordeste.csv")
eleicao_Sul <- read.csv("https://raw.githubusercontent.com/ombudsmanviktor/workshop_rstats/main/aula5/eleicao_Sul.csv")
eleicao_Sudeste <- read.csv("https://raw.githubusercontent.com/ombudsmanviktor/workshop_rstats/main/aula5/eleicao_Sudeste.csv")
eleicao_CentroOeste <- read.csv("https://raw.githubusercontent.com/ombudsmanviktor/workshop_rstats/main/aula5/eleicao_CentroOeste.csv")

# 1. Monte uma tabela somente com as candidaturas do PSL ao senado federal nas regiões
# Sul, Sudeste e Centro-Oeste

eleicao_psl <- eleicao_Sul %>% 
  bind_rows(eleicao_Sudeste) %>% 
  bind_rows(eleicao_CentroOeste) %>% 
  filter(candidato_cargo == "SENADOR" & partido_sigla == "PSL")

# 2. Indique quantos candidatos a deputado federal o PSOL lançou em todo o Brasil por estado

eleicao_psol <- eleicao_Sul %>% 
  bind_rows(eleicao_Sudeste) %>% 
  bind_rows(eleicao_CentroOeste) %>% 
  bind_rows(eleicao_Nordeste) %>%
  bind_rows(eleicao_Norte) %>%
  filter(candidato_cargo == "DEPUTADO FEDERAL" & partido_sigla == "PSOL") %>% 
  count(uf)