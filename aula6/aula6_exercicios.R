# Curso: Introdução à Análise de Pesquisa Quantitativa
# Professor: Viktor Chagas
# Semestre Letivo: 2020.2
# Aula: 6
# Programa de curso: https://rpubs.com/viktor/workshop_rstats

library(dplyr)
library(tidyr)
library(stringr)
library(magick)
library(palmerpenguins)

### EXERCÍCIO 1

# Considere o conjunto de dados abaixo:

representatividade_2018 <- read.csv(
  "https://raw.githubusercontent.com/ombudsmanviktor/workshop_rstats/main/aula6/representatividade_2018.csv")

# Arrume os dados de modo a tornar a estrutura do banco tidy.
# DICA: Mantenha três colunas na tabela e transforme negros_pardos e mulheres em uma só variável.

representatividade_2018 %>% 
  gather(negros_pardos, mulheres, key = "candidatos_minorias", value = "quantidade") %>% 
  select(-X)

### EXERCÍCIO 2

# Considere o conjunto de dados abaixo:

bbb21_mensagens <- read.csv(
  "https://raw.githubusercontent.com/ombudsmanviktor/workshop_rstats/main/aula6/bbb21_mensagens.csv")

# A coluna métricas possui dois valores associados na mesma célula. Transforme esses dois
# valores em duas variáveis diferentes, considerando o primeiro valor como de RTs recebidos
# por um determinado tweet, e o segundo valor como o de vezes em que esse mesmo tweet foi
# favoritado.

bbb21_separate <- bbb21_mensagens %>% 
  separate(metricas, c("retweets", "favorites"), sep = "/")

### EXERCÍCIO 3

# Considere o mesmo dataframe anterior:

bbb21_mensagens

# Procure quantas vezes Juliette é mencionada nesse conjunto de mensagens.

bbb21_mensagens$text %>% 
  str_detect("Juliette|Juliete|juliette|juliete") %>% 
  sum(TRUE)

bbb21_mensagens %>% 
  mutate(new_text = str_detect(text, "Juliette|Juliete|juliette|juliete")) %>% 
  filter(new_text == "TRUE") %>% 
  count()

# Substitua todas as menções a Bolsonaro (ou bolsonaro ou BOLSONARO) por Bozo

bbb21_mensagens$text <- bbb21_mensagens$text %>% 
  str_replace("Bolsonaro|bolsonaro|BOLSONARO", "Bozo")

bbb21_mensagens$text <- bbb21_mensagens$text %>% 
  str_replace("Bolsonaro", "Bozo") %>% 
  str_replace("bolsonaro", "Bozo") %>% 
  str_replace("BOLSONARO", "Bozo")

# Transforme todos os caracteres das mensagens nos tweets em minúsculas.

bbb21_mensagens$text <- bbb21_mensagens$text %>% 
  str_to_lower()


