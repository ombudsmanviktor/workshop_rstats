install.packages("rtweet")
library(rtweet)
library(dplyr)

api_key <- "x7dRwr3tRI7oOBeDIaKta49Ga"
api_secret_key <- "jicCkpplw7eBEi8kLISgAxFllHgoUuRKYObFbggSaVPnCNPpFU"
access_token <- "1023273924040249346-EVAZ48KEfgZzbAIzai5hVMiOHHaLcu"
access_token_secret <- "M2BAizbOwBoZzGycDwHt4alYOZf1OBBJrUEBs5e7xhUq7"

token <- create_token(
  app = "rstatsworkshop",
  consumer_key = api_key,
  consumer_secret = api_secret_key,
  access_token = access_token,
  access_secret = access_token_secret
)

bolsonaro <- stream_tweets(
  "bolsonaro", timeout = 60
)

rodolffo <- search_tweets(
  "#ForaRodolffo", n = 200, retryonratelimit = FALSE, verbose = TRUE, include_rts = FALSE
)

arrobas <- rodolffo %>% 
  group_by(screen_name) %>% 
  summarise(screen_name) %>% 
  count(screen_name) %>% 
  arrange(desc(n)) %>% 
  head(10) %>% 
  ggplot2::ggplot(ggplot2::aes(x = screen_name, y = n)) +
    ggplot2::geom_bar(stat = "identity", width = .9)
plot(arrobas)

rodolffo %>% 
  mutate(min = lubridate::floor_date(created_at, "minute")) %>% 
  count(min) %>% 
  ggplot2::ggplot(ggplot2::aes(x = min, y = n)) +
  ggplot2::geom_line(stat = "identity")

viih <- search_tweets(
  "#ForaViihTube", n = 10000, include_rts = FALSE, verbose = TRUE
)

viih %>% 
  mutate(tempo = lubridate::floor_date(created_at, "minute")) %>% 
  count(tempo) %>% 
  ggplot2::ggplot(ggplot2::aes(x = tempo, y = n)) +
  ggplot2::geom_line(stat = "identity")

viih %>% 
  count(screen_name) %>% 
  arrange(desc(n)) %>% 
  head(20) %>% 
  ggplot2::ggplot(ggplot2::aes(x = screen_name, y = n)) +
  ggplot2::geom_bar(stat = "identity", width = .6)

tweets_bbb <- rodolffo %>% 
  select(user_id, status_id, text) %>% 
  full_join(viih)

#

rede_seguidores <- get_followers(
  "museudememes", n = 100, parse = TRUE
)

rede_seguidos <- get_friends(
  "museudememes", n = 100, parse = TRUE
)

library(igraph)

nodes <- rede_seguidores %>% 
  mutate(nodes = unique(user_id)) %>% 
  select(nodes) %>% 
  add_row(nodes = "museudememes")

edges <- rede_seguidores %>% 
  mutate(source = "museudememes") %>% 
  mutate(target = user_id) %>% 
  select(source, target)

grafo <- igraph::graph_from_data_frame(d = edges,
                                       direct = FALSE,
                                       vertices = nodes)

plot(grafo, vertex.label = NA, layout = layout_nicely(grafo))




