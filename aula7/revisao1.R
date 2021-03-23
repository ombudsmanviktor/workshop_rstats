# Curso: Introdução à Análise de Pesquisa Quantitativa
# Professor: Viktor Chagas
# Semestre Letivo: 2020.2
# Aula: 7
# Programa de curso: https://rpubs.com/viktor/workshop_rstats

# Esta é uma aula apenas de revisão. Seu objetivo é treinar e fixar algumas funções dos pacotes
# do Tidyverse. O script abaixo serve como guia para os tutoriais em vídeo disponíveis nos
# seguintes links:

# Aula sobre pipe e piping: https://classroom.google.com/c/MjYxMjQ1MjQ3MDYy/p/MzAyNjQwODIwOTQ5/details

# Revisão dplyr: https://classroom.google.com/c/MjYxMjQ1MjQ3MDYy/p/MzAyNjQwODIwOTY0/details

# Revisão joins: https://classroom.google.com/c/MjYxMjQ1MjQ3MDYy/p/MzAyNjQwMzczNjc0/details

# Lembre-se de, antes de mais nada, requisitar os pacotes que pretende utilizar e importar o
# seu banco de dados.

library(dplyr)
library(stringr)

eleicao_candidato <- read.csv("https://raw.githubusercontent.com/ombudsmanviktor/workshop_rstats/main/aula5/eleicao_candidato.csv")

eleicao_candidato %>% 
  select(candidato_id, nome_urna, genero, raca, partido_id) %>% 
  filter(genero == "FEMININO") %>% 
  filter(raca == "PRETA") %>% 
  arrange(desc(nome_urna))

tabela <- eleicao_candidato %>% 
  select(candidato_id, nome_urna, genero, raca, partido_id) %>% 
  filter(genero == "FEMININO") %>% 
  filter(raca == "PRETA") %>% 
  arrange(desc(nome_urna))

tabela1 <- select(eleicao_candidato, candidato_id, nome_urna, genero, raca, partido_id)
tabela1 <- filter(eleicao_candidato, genero == "FEMININO")
tabela1 <- filter(eleicao_candidato, raca == "PRETA")
tabela1 <- arrange(eleicao_candidato, desc(nome_urna))

select(
  filter(
    filter(
      arrange(
        eleicao_candidato, desc(nome_urna)
      ), raca == "PRETA"
    ), genero == "FEMININO"
  ), candidato_id, nome_urna, genero, raca, partido_id
)

tabela1 <- eleicao_candidato %>% 
  select(candidato_id, nome_urna, genero, raca, partido_id)

tabela2 <- tabela1 %>% 
  filter(genero == "FEMININO") 

tabela3 <- tabela2 %>% 
  filter(genero == "FEMININO")

tabela4 <- tabela3 %>% 
  filter(genero == "FEMININO")

tabela5 <- tabela4 %>% 
  filter(raca == "PRETA")

tabela6 <- tabela5 %>% 
  arrange(desc(nome_urna))



bbb21_mensagens <- read.csv(
  "https://raw.githubusercontent.com/ombudsmanviktor/workshop_rstats/main/aula6/bbb21_mensagens.csv")

bbb21_mensagens$text %>% 
  str_detect("Juliete") %>% 
  sum(TRUE)

bbb21_mensagens %>% 
  mutate(new_text = str_detect(text, "Juliette")) %>% 
  filter(new_text == "TRUE") %>% 
  count()

bbb21_mensagens$text %>% 
  str_detect("Bolsonaro") %>% 
  str_detect("bolsonaro") %>% 
  str_detect("salnorabo") %>% 
  str_detect("genocida")

bbb21_mensagens %>% 
  filter(str_detect(text, "Bolsonaro|bolsonaro|salnorabo|genocida"))






