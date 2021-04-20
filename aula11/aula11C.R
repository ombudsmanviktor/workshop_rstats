# Curso: Introdução à Análise de Pesquisa Quantitativa
# Professor: Viktor Chagas
# Semestre Letivo: 2020.2
# Aula: 11C
# Programa de curso: https://rpubs.com/viktor/workshop_rstats

# Solicitar pacotes -------------------------------------------------------
#install.packages("ggplot2")
#install.packages("plotly")
library(ggplot2)
library(plotly)
library(dplyr)
library(palmerpenguins)


# Gráficos interativos ----------------------------------------------------

# Importando os dados
pinguins <- penguins %>% tidyr::drop_na()

# Scatter plot interativo
grafico1 <- pinguins %>% 
  ggplot() +
  geom_point(aes(x = body_mass_g, y = flipper_length_mm, color = species))

ggplotly(grafico1)

# Line plot interativo
grafico2 <- pinguins %>% 
  count(year, species) %>% 
  ggplot() +
  geom_line(aes(x = year, y = n, group = species, color = species))

ggplotly(grafico2)

# Boxplot interativo
grafico3 <- pinguins %>% 
  ggplot() +
  geom_boxplot(aes(x = sex, y = body_mass_g))

ggplotly(grafico3)

# Barplot interativo
grafico4 <- pinguins %>% 
  ggplot() +
  geom_bar(aes(x = island), stat = "count")

ggplotly(grafico4)

