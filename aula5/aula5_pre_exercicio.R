# Curso: Introdução à Análise de Pesquisa Quantitativa
# Professor: Viktor Chagas
# Semestre Letivo: 2020.2
# Aula: 5
# Programa de curso: https://rpubs.com/viktor/workshop_rstats

# Preparando os dados para o exercício...

# As rotinas abaixo são necessárias apenas para criar os dataframes a serem utilizados
# nos exercícios da aula 5 deste curso.

candidatos_brasil <- electionsBR::candidate_fed(2018)


eleicao_info <- candidatos_brasil %>% 
  select(DESCRICAO_ELEICAO, ANO_ELEICAO, NOME_TIPO_ELEICAO, DATA_ELEICAO, ABRANGENCIA, 
         SIGLA_UF, DESCRICAO_CARGO, NUMERO_PARTIDO, 
         SEQUENCIAL_CANDIDATO) %>% 
  mutate(eleicao_descricao = DESCRICAO_ELEICAO) %>% 
  mutate(eleicao_ano = ANO_ELEICAO) %>% 
  mutate(eleicao_tipo = NOME_TIPO_ELEICAO) %>% 
  mutate(eleicao_data = DATA_ELEICAO) %>% 
  mutate(eleicao_abrangencia = ABRANGENCIA) %>% 
  mutate(uf = SIGLA_UF) %>% 
  mutate(candidato_cargo = DESCRICAO_CARGO) %>% 
  mutate(candidato_id = SEQUENCIAL_CANDIDATO) %>% 
  mutate(partido_id = NUMERO_PARTIDO) %>% 
  select(eleicao_ano, eleicao_descricao, eleicao_tipo, eleicao_data, eleicao_abrangencia,
         uf, candidato_cargo, candidato_id, partido_id) %>% 
  unique()

eleicao_candidato <- candidatos_brasil %>% 
  select(NOME_CANDIDATO, NOME_URNA_CANDIDATO, SIGLA_PARTIDO, DATA_NASCIMENTO, IDADE_DATA_POSSE,
         DESCRICAO_SEXO, DESCRICAO_GRAU_INSTRUCAO, DESCRICAO_ESTADO_CIVIL, DESCRICAO_COR_RACA,
         SEQUENCIAL_CANDIDATO, NUMERO_PARTIDO, CODIGO_LEGENDA) %>% 
  mutate(nome = NOME_CANDIDATO) %>% 
  mutate(nome_urna = NOME_URNA_CANDIDATO) %>% 
  mutate(partido_sigla = SIGLA_PARTIDO) %>% 
  mutate(data_nascimento = DATA_NASCIMENTO) %>% 
  mutate(idade = IDADE_DATA_POSSE) %>% 
  mutate(genero = DESCRICAO_SEXO) %>% 
  mutate(escolaridade = DESCRICAO_GRAU_INSTRUCAO) %>% 
  mutate(estado_civil = DESCRICAO_ESTADO_CIVIL) %>% 
  mutate(raca = DESCRICAO_COR_RACA) %>% 
  mutate(partido_id = NUMERO_PARTIDO) %>% 
  mutate(coligacao_id = CODIGO_LEGENDA) %>% 
  mutate(candidato_id = SEQUENCIAL_CANDIDATO) %>% 
  select(candidato_id, nome, nome_urna, data_nascimento, idade, genero, raca, escolaridade,
         estado_civil, partido_id, coligacao_id) %>% 
  unique()

eleicao_candidato_somentept <- candidatos_brasil %>% 
  select(NOME_CANDIDATO, NOME_URNA_CANDIDATO, SIGLA_PARTIDO, DATA_NASCIMENTO, IDADE_DATA_POSSE,
         DESCRICAO_SEXO, DESCRICAO_GRAU_INSTRUCAO, DESCRICAO_ESTADO_CIVIL, DESCRICAO_COR_RACA,
         SEQUENCIAL_CANDIDATO, NUMERO_PARTIDO, CODIGO_LEGENDA) %>% 
  mutate(nome = NOME_CANDIDATO) %>% 
  mutate(nome_urna = NOME_URNA_CANDIDATO) %>% 
  mutate(partido_sigla = SIGLA_PARTIDO) %>% 
  mutate(data_nascimento = DATA_NASCIMENTO) %>% 
  mutate(idade = IDADE_DATA_POSSE) %>% 
  mutate(genero = DESCRICAO_SEXO) %>% 
  mutate(escolaridade = DESCRICAO_GRAU_INSTRUCAO) %>% 
  mutate(estado_civil = DESCRICAO_ESTADO_CIVIL) %>% 
  mutate(raca = DESCRICAO_COR_RACA) %>% 
  mutate(partido_id = NUMERO_PARTIDO) %>% 
  mutate(coligacao_id = CODIGO_LEGENDA) %>% 
  mutate(candidato_id = SEQUENCIAL_CANDIDATO) %>% 
  select(candidato_id, nome, nome_urna, partido_sigla) %>%
  filter(partido_sigla == "PT") %>% 
  unique()

eleicao_partido <- candidatos_brasil %>% 
  select(SIGLA_PARTIDO, NOME_PARTIDO, NUMERO_PARTIDO, CODIGO_LEGENDA, SIGLA_UF) %>% 
  mutate(partido_sigla = SIGLA_PARTIDO) %>% 
  mutate(partido = NOME_PARTIDO) %>% 
  mutate(partido_id = NUMERO_PARTIDO) %>% 
  mutate(coligacao_id = CODIGO_LEGENDA) %>%
  mutate(uf = SIGLA_UF) %>%
  select(partido_sigla, partido, partido_id, coligacao_id, uf) %>% 
  unique()

eleicao_composicao <- candidatos_brasil %>% 
  select(NOME_COLIGACAO, COMPOSICAO_LEGENDA, CODIGO_LEGENDA, SIGLA_UF) %>% 
  mutate(coligacao = NOME_COLIGACAO) %>% 
  mutate(coligacao_partido = COMPOSICAO_LEGENDA) %>% 
  mutate(coligacao_id = CODIGO_LEGENDA) %>% 
  mutate(uf = SIGLA_UF) %>% 
  select(coligacao_id, coligacao, coligacao_partido, uf) %>% 
  unique()

eleicao_Norte <- candidatos_brasil %>% 
  select(DESCRICAO_ELEICAO, SIGLA_UF, DESCRICAO_CARGO, NOME_URNA_CANDIDATO, SIGLA_PARTIDO) %>% 
  mutate(eleicao_descricao = DESCRICAO_ELEICAO) %>% 
  mutate(uf = SIGLA_UF) %>% 
  mutate(candidato_cargo = DESCRICAO_CARGO) %>% 
  mutate(nome_urna = NOME_URNA_CANDIDATO) %>% 
  mutate(partido_sigla = SIGLA_PARTIDO) %>% 
  select(eleicao_descricao, uf, candidato_cargo, nome_urna, partido_sigla) %>% 
  filter(uf == "AC" | uf == "AM" | uf == "AP" | uf == "PA" | uf == "RO" | uf == "RR" | 
           uf == "TO") %>% 
  unique()

eleicao_Nordeste <- candidatos_brasil %>% 
  select(DESCRICAO_ELEICAO, SIGLA_UF, DESCRICAO_CARGO, NOME_URNA_CANDIDATO, SIGLA_PARTIDO) %>% 
  mutate(eleicao_descricao = DESCRICAO_ELEICAO) %>% 
  mutate(uf = SIGLA_UF) %>% 
  mutate(candidato_cargo = DESCRICAO_CARGO) %>% 
  mutate(nome_urna = NOME_URNA_CANDIDATO) %>% 
  mutate(partido_sigla = SIGLA_PARTIDO) %>% 
  select(eleicao_descricao, uf, candidato_cargo, nome_urna, partido_sigla) %>% 
  filter(uf == "AL" | uf == "BA" | uf == "CE" | uf == "MA" | uf == "PB" | uf == "PE" | 
           uf == "PI" | uf == "RN" | uf == "SE") %>% 
  unique()

eleicao_Sul <- candidatos_brasil %>% 
  select(DESCRICAO_ELEICAO, SIGLA_UF, DESCRICAO_CARGO, NOME_URNA_CANDIDATO, SIGLA_PARTIDO) %>% 
  mutate(eleicao_descricao = DESCRICAO_ELEICAO) %>% 
  mutate(uf = SIGLA_UF) %>% 
  mutate(candidato_cargo = DESCRICAO_CARGO) %>% 
  mutate(nome_urna = NOME_URNA_CANDIDATO) %>% 
  mutate(partido_sigla = SIGLA_PARTIDO) %>% 
  select(eleicao_descricao, uf, candidato_cargo, nome_urna, partido_sigla) %>% 
  filter(uf == "RS" | uf == "PR" | uf == "SC") %>% 
  unique()


eleicao_Sudeste <- candidatos_brasil %>% 
  select(DESCRICAO_ELEICAO, SIGLA_UF, DESCRICAO_CARGO, NOME_URNA_CANDIDATO, SIGLA_PARTIDO) %>% 
  mutate(eleicao_descricao = DESCRICAO_ELEICAO) %>% 
  mutate(uf = SIGLA_UF) %>% 
  mutate(candidato_cargo = DESCRICAO_CARGO) %>% 
  mutate(nome_urna = NOME_URNA_CANDIDATO) %>% 
  mutate(partido_sigla = SIGLA_PARTIDO) %>% 
  select(eleicao_descricao, uf, candidato_cargo, nome_urna, partido_sigla) %>% 
  filter(uf == "RJ" | uf == "SP" | uf == "ES" | uf == "MG") %>% 
  unique()

eleicao_CentroOeste <- candidatos_brasil %>% 
  select(DESCRICAO_ELEICAO, SIGLA_UF, DESCRICAO_CARGO, NOME_URNA_CANDIDATO, SIGLA_PARTIDO) %>% 
  mutate(eleicao_descricao = DESCRICAO_ELEICAO) %>% 
  mutate(uf = SIGLA_UF) %>% 
  mutate(candidato_cargo = DESCRICAO_CARGO) %>% 
  mutate(nome_urna = NOME_URNA_CANDIDATO) %>% 
  mutate(partido_sigla = SIGLA_PARTIDO) %>% 
  select(eleicao_descricao, uf, candidato_cargo, nome_urna, partido_sigla) %>% 
  filter(uf == "MT" | uf == "MS" | uf == "GO" | uf == "DF") %>% 
  unique()

eleicao_candidato_nomes <- eleicao_candidato %>% 
  select(nome, data_nascimento)

write.csv(eleicao_info, "~/Downloads/eleicao_info.csv", row.names = FALSE)
write.csv(eleicao_candidato_somentept, "~/Downloads/eleicao_candidato_somentept.csv", row.names = FALSE)
write.csv(eleicao_candidato, "~/Downloads/eleicao_candidato.csv", row.names = FALSE)
write.csv(eleicao_partido, "~/Downloads/eleicao_partido.csv", row.names = FALSE)
write.csv(eleicao_composicao, "~/Downloads/eleicao_composicao.csv", row.names = FALSE)
write.csv(eleicao_Norte, "~/Downloads/eleicao_Norte.csv", row.names = FALSE)
write.csv(eleicao_Nordeste, "~/Downloads/eleicao_Nordeste.csv", row.names = FALSE)
write.csv(eleicao_Sul, "~/Downloads/eleicao_Sul.csv", row.names = FALSE)
write.csv(eleicao_Sudeste, "~/Downloads/eleicao_Sudeste.csv", row.names = FALSE)
write.csv(eleicao_CentroOeste, "~/Downloads/eleicao_CentroOeste.csv", row.names = FALSE)
write.csv(eleicao_candidato_nomes, "~/Downloads/eleicao_candidato_nomes.csv", row.names = FALSE)

