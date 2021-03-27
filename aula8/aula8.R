# Curso: Introdução à Análise de Pesquisa Quantitativa
# Professor: Viktor Chagas
# Semestre Letivo: 2020.2
# Aula: 8
# Programa de curso: https://rpubs.com/viktor/workshop_rstats

# Solicitar pacotes -------------------------------------------------------
#install.packages("rtweet")
#install.packages("rwhatsapp")
library(rtweet)
library(rwhatsapp)

# rtweet ------------------------------------------------------------------

# O rtweet é um pacote desenvolvido por Michael W. Kearney, e que conta
# com colaborações de Andrew Heiss e Francois Briatte. Para mais informações,
# consulte: https://docs.ropensci.org/rtweet/

# Inserir chaves de autenticação do Twitter -------------------------------

# API Key: x7dRwr3tRI7oOBeDIaKta49Ga
# API Key Secret: jicCkpplw7eBEi8kLISgAxFllHgoUuRKYObFbggSaVPnCNPpFU
# Access Token: 1023273924040249346-EVAZ48KEfgZzbAIzai5hVMiOHHaLcu
# Access Token Secret: M2BAizbOwBoZzGycDwHt4alYOZf1OBBJrUEBs5e7xhUq7

api_key <- "x7dRwr3tRI7oOBeDIaKta49Ga"
api_secret_key <- "jicCkpplw7eBEi8kLISgAxFllHgoUuRKYObFbggSaVPnCNPpFU"
access_token <- "1023273924040249346-EVAZ48KEfgZzbAIzai5hVMiOHHaLcu"
access_token_secret <- "M2BAizbOwBoZzGycDwHt4alYOZf1OBBJrUEBs5e7xhUq7"

# Autenticar via create_token ---------------------------------------------

token <- create_token(
  app = "rstatsworkshop",
  consumer_key = api_key,
  consumer_secret = api_secret_key,
  access_token = access_token,
  access_secret = access_token_secret)

# Pesquisar tweets por palavras-chaves ------------------------------------

# Coleta simples
# Os argumentos de search_tweets são:
# n: indica a quantidade de tweets a serem coletados.
# include_rts: valores TRUE ou FALSE para incluir retweets na coleta.
# retryonratelimit: repete a coleta após 15min e busca por mais 18 mil tweets.
# verbose: apresenta os erros em modo textual.
bolsonaro1 <- search_tweets(
  "Bolsonaro", n = 10, include_rts = FALSE, retryonratelimit = TRUE, verbose = TRUE
)

# Coleta com múltiplas palavras-chaves
bolsonaro2 <- search_tweets(
  "Bolsonaro OR Bozo", n = 10, include_rts = FALSE, retryonratelimit = TRUE, verbose = TRUE
)

# Pesquisar tweets em tempo real ------------------------------------------

bolsonaro3 <- stream_tweets("Bolsonaro, Bozo", timeout = 60)

# Pesquisar tweets na timeline de um usuário ------------------------------

karolconka <- get_timeline("karolconka", n = 10)

# Pesquisar dados pessoais de usuários (lookup) ---------------------------

partidos <- c("180500907", "39931528","1202130601","1011297899463041028",
              "39522911","1151011908","86320511","2734700584","868487844595212288",
              "83835435","26250547","73144615")

infopartidos <- lookup_users(partidos)

# Pesquisar seguidores e seguidos -----------------------------------------

# A Twitter API considera followers como seguidores e friends como seguidos.
# A função get_followers suporta apenas um usuário. A função get_friends suporta
# mais de um usuário.
museudememes_followers <- get_followers("museudememes", n = 10,
                                        retryonratelimit = TRUE, parse = TRUE)

museudememes_friends <- get_friends(c("museudememes", "ombudsmanviktor"), n = 10,
                                        retryonratelimit = TRUE, parse = TRUE)

# Pesquisar tweets favoritados por usuário --------------------------------

museudememes <- get_favorites("museudememes", n = 20)

# Pesquisar trending topics -----------------------------------------------

# Para pesquisar WOEIDs, utilize o site https://nations24.com/world-wide
# WOEID Brasil: 23424768
# WOEID Rio de Janeiro: 455825
# WOEID Brasília: 455819
# WOEID Estados Unidos: 23424977

trends_br <- get_trends("23424768")

# Exportar dados coletados no Twitter -------------------------------------

# O rtweet tem uma função nativa para exportação dos dados que já realiza
# o parse do dataframe coletado. A função é semelhante à write.csv, presente
# no R Base, mas transforma os dados em formato de lista para tabela.
rtweet::write_as_csv(bolsonaro1, "~/Downloads/coleta_teste.csv")

# YouTube Data Tools ------------------------------------------------------

# O YouTube Data Tools é uma coleção de ferramentas de extração de dados
# da plataforma do YouTube via YouTube API v3, desenvolvida por 
# Bernhard Rieder. Para mais informações, consulte:
# https://github.com/bernorieder/YouTube-Data-Tools

# Importar dados do YouTube -----------------------------------------------

# Acesse o site https://tools.digitalmethods.net/netvizz/youtube/

# Acesse a opção Video List https://tools.digitalmethods.net/netvizz/youtube/mod_videos_list.php

# Informe a ID de algum canal (p.ex. Felipe Neto: UCV306eHqgo0LvBf3Mh36AHg) e baixe os dados

# Importe o arquivo .tab para o R Studio
youtube_data <- file.choose()

# rwhatsapp ---------------------------------------------------------------

# O rwhatsapp é um script desenvolvido por Johannes Gruber para manipulação
# e parse de dados exportados a partir de chats do WhatsApp. Para mais
# informações, consulte: https://github.com/JBGruber/rwhatsapp

# Importar dados do WhatsApp ----------------------------------------------

# Salve, no seu computador, o arquivo de texto disponível em: 
# https://raw.githubusercontent.com/ombudsmanviktor/workshop_rstats/main/aula8/Conversa%20do%20WhatsApp%20com%20Rstats.txt

# Selecione o arquivo salvo no computador local:
grupo_rstats <- rwa_read(file.choose())

# Ou indique o path diretamente no próprio comando:
grupo_rstats <- rwa_read(
  "~/Downloads/Conversa do WhatsApp com Rstats.txt")


# EXERCÍCIOS --------------------------------------------------------------

### EXERCÍCIO 1

# Faça uma coleta de dados no Twitter a partir de palavras-chaves específicas,
# sobre um tema de seu interesse, e envie, em formato CSV, para o restante do
# grupo no WhatsApp, indicando os parâmetros de sua busca (data, horário,
# palavras-chaves ou demais argumentos).

### EXERCÍCIO 2

# A partir dos dados que você coletou no exercício anterior,
# A. Monte uma tabela indicando quais os tweets com maior quantidade de retweets.
# B. Monte uma tabela indicando quais as fontes (sources) de tweets mais frequentes.
# C. Monte uma tabela indicando quais os perfis criaram mais tweets.

### EXERCÍCIO 3

# Com base nos dados disponíveis no gitHUB e exportados do WhatsApp,
# disponíveis no seguinte link: 
# https://raw.githubusercontent.com/ombudsmanviktor/workshop_rstats/main/aula8/Conversa%20do%20WhatsApp%20com%20Rstats.txt

# A. Monte uma tabela indicando que são os usuários que mais enviam mensagens para o grupo.
# B. Monte uma tabela indicando quais são os emojis mais utilizados em mensagens.

