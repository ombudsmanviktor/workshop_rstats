# Curso: Introdução à Análise de Pesquisa Quantitativa
# Professor: Viktor Chagas
# Semestre Letivo: 2020.2
# Aula: 6
# Programa de curso: https://rpubs.com/viktor/workshop_rstats

# Formantando o Exercício

library(rtweet)

bbb21 <- search_tweets(
  "#BBB21", n = 10000, include_rts = FALSE, retryonratelimit = TRUE, verbose = TRUE
)

bbb21_hashtag <- bbb21 %>% 
  select(status_id, created_at, screen_name, text, source, favorite_count, 
         retweet_count, media_url, media_type) %>% 
  unite(metricas, favorite_count, retweet_count, sep = "/")

bbb21_rts <- bbb21 %>% 
  select(screen_name, retweet_count) %>% 
  group_by(screen_name) %>% 
  mutate(rts = sum(retweet_count)) %>%
  select(screen_name, rts) %>% 
  unique()

bbb21_favs <- bbb21 %>% 
  select(screen_name, favorite_count) %>% 
  group_by(screen_name) %>% 
  mutate(favs = sum(favorite_count)) %>%
  select(screen_name, favs) %>% 
  unique()

bbb21_metricas <- left_join(bbb21_rts, bbb21_favs, by ="screen_name")

bbb21_metricas_gather <- bbb21_metricas %>% 
  gather(rts, favs, key = "metricas", value = "count")

bbb21_metricas_spread <- bbb21_metricas_gather %>% 
  spread(metricas, count)


candidatos_brasil <- electionsBR::candidate_fed(2018)

candidatos_brasil <- candidatos_brasil %>% 
  select(NOME_URNA_CANDIDATO, SIGLA_PARTIDO, DESCRICAO_COR_RACA, DESCRICAO_SEXO) %>% 
  mutate(id = row_number())

candidatos_raca <- candidatos_brasil %>% 
  filter(DESCRICAO_COR_RACA == "PARDA" | DESCRICAO_COR_RACA == "PRETA") %>% 
  group_by(SIGLA_PARTIDO) %>% 
  summarise(DESCRICAO_COR_RACA) %>% 
  count() %>% 
  arrange(desc(n)) %>% 
  mutate(negros_pardos = n) %>% 
  select(-n)

candidatos_genero <- candidatos_brasil %>% 
  filter(DESCRICAO_SEXO == "FEMININO") %>% 
  group_by(SIGLA_PARTIDO) %>% 
  summarise(DESCRICAO_SEXO) %>% 
  count() %>% 
  arrange(desc(n)) %>% 
  mutate(mulheres = n) %>% 
  select(-n)

representatividade_2018 <- left_join(candidatos_raca, candidatos_genero, by = "SIGLA_PARTIDO") %>% 
  rename(partido = SIGLA_PARTIDO)

write.csv(representatividade_2018, "~/Downloads/representatividade_2018.csv")
write.csv(bbb21_metricas_gather, "~/Downloads/bbb21_metricas.csv")
bbb21_hashtag <- apply(bbb21_hashtag,2,as.character)
bbb21 <- apply(bbb21,2,as.character)
write.csv(bbb21_hashtag, "~/Downloads/bbb21_mensagens.csv")
write.csv(bbb21, "~/Downloads/bbb21_original.csv")
