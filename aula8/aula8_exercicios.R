# Curso: Introdução à Análise de Pesquisa Quantitativa
# Professor: Viktor Chagas
# Semestre Letivo: 2020.2
# Aula: 8
# Programa de curso: https://rpubs.com/viktor/workshop_rstats

# EXERCÍCIOS --------------------------------------------------------------

### EXERCÍCIO 1

# Faça uma coleta de dados no Twitter a partir de palavras-chaves específicas,
# sobre um tema de seu interesse, e envie, em formato CSV, para o restante do
# grupo no WhatsApp, indicando os parâmetros de sua busca (data, horário,
# palavras-chaves ou demais argumentos).

rtweet::write_as_csv(bolsonaro1, "~/Downloads/coleta_teste.csv")

### EXERCÍCIO 2

# A partir dos dados que você coletou no exercício anterior,
# A. Monte uma tabela indicando quais os tweets com maior quantidade de retweets.
# B. Monte uma tabela indicando quais as fontes (sources) de tweets mais frequentes.
# C. Monte uma tabela indicando quais os perfis criaram mais tweets.

screen_name <- bolsonaro1 %>%
  select(screen_name) %>% 
  group_by(screen_name) %>% 
  summarise(screen_name) %>% 
  count(screen_name) %>% 
  arrange(desc(n))

source <- bolsonaro1 %>%
  select(source) %>% 
  group_by(source) %>% 
  summarise(source) %>% 
  count(source) %>% 
  arrange(desc(n))

rts <- bolsonaro1 %>%
  select(text,retweet_count) %>% 
  group_by(text) %>% 
  arrange(desc(retweet_count))

### EXERCÍCIO 3

# Com base nos dados disponíveis no gitHUB e exportados do WhatsApp,
# disponíveis no seguinte link: 
# https://raw.githubusercontent.com/ombudsmanviktor/workshop_rstats/main/aula8/Conversa%20do%20WhatsApp%20com%20Rstats.txt

# A. Monte uma tabela indicando que são os usuários que mais enviam mensagens para o grupo.
# B. Monte uma tabela indicando quais são os emojis mais utilizados em mensagens.

sender <- grupo_rstats %>%
  filter(!is.na(author)) %>% 
  select(author) %>% 
  summarise(author) %>%
  group_by(author) %>%
  count(author) %>% 
  arrange(desc(n))

emoji <- grupo_rstats %>%
  filter(!is.na(emoji)) %>% 
  select(emoji) %>% 
  summarise(emoji) %>%
  group_by(emoji) %>%
  count(emoji) %>% 
  arrange(desc(n))