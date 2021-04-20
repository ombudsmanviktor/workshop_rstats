# Curso: Introdução à Análise de Pesquisa Quantitativa
# Professor: Viktor Chagas
# Semestre Letivo: 2020.2
# Aula: 10
# Programa de curso: https://rpubs.com/viktor/workshop_rstats

# EXERCÍCIOS --------------------------------------------------------------

# Para os exercícios a seguir, compartilhe no grupo da disciplina as imagens
# dos gráficos exportadas em formato PNG, e, somente com o professor, o seu
# script R utilizado para fazer os exercícios.

### EXERCÍCIO 1

# Com base nos dados que você coletou na aula anterior, crie um gráfico de
# dispersão que apresente os RTs de cada tweet coletado e o número de 
# seguidores do usuário que publicou o tweet.

coleta_teste %>% 
  ggplot() +
  geom_point(aes(x = followers_count, y = retweet_count))

### EXERCÍCIO 2

# Com base nos dados que você coletou na aula anterior, crie um gráfico de
# barras que apresente os cinco idiomas (lang) mais comumente
# empregados em sua amostra.
# Dica: Combine funções do dplyr com outra do ggplot2.

coleta_teste %>% 
  count(lang) %>% 
  arrange(desc(n)) %>% 
  top_n(n = 5) %>% 
  ggplot() +
  geom_bar(aes(x = lang, y = n), stat = "identity")

### EXERCÍCIO 3

# Com base nos dados que você coletou na aula anterior, crie um gráfico de
# caixa que apresente os tweets que obtiveram acima de 100 retweets na sua
# amostra, categorizados de acordo com os principais dispositivos (source)
# utilizados por usuários para acessar o Twitter.

coleta_teste %>% 
  arrange(desc(retweet_count)) %>% 
  filter(retweet_count > 100) %>% 
  ggplot() +
  geom_boxplot(aes(x = source, y = retweet_count))
