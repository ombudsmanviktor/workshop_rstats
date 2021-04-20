# Curso: Introdução à Análise de Pesquisa Quantitativa
# Professor: Viktor Chagas
# Semestre Letivo: 2020.2
# Aula: 11A
# Programa de curso: https://rpubs.com/viktor/workshop_rstats

# Solicitar pacotes -------------------------------------------------------
#install.packages("ggplot2")
library(ggplot2)
library(dplyr)
library(palmerpenguins)

# geom_line() ------------------------------------------------------------

# geom_line: O geom_line corresponde ao gráfico de linha simples.
# Para utilizá-lo, é preciso haver duas variáveis numéricas e
# sequenciais a serem relacionadas. Geralmente, é empregado para
# visualizar flutuações ao longo do tempo, mas não apenas.

# Importando os dados
pinguins <- penguins %>% tidyr::drop_na()

# Gerando um gráfico de linha simples com stat_count
pinguins %>% 
  ggplot() +
  geom_line(aes(x = year), stat = "count")

# Gerando um gráfico de linha simples com stat_identity
pinguins %>% 
  count(year) %>% 
  ggplot() +
  geom_line(aes(x = year, y = n), stat = "identity")

# Gerando um gráfico de linha agrupado
pinguins %>% 
  count(year, species) %>% 
  ggplot() +
  geom_line(aes(x = year, y = n, group = species, color = species))


# geom_area() -------------------------------------------------------------

# geom_area: Este geom funciona de modo similar ao geom_line, mas, ao
# invés de uma linha, ele plota uma área sólida. Além disso, é possível
# também empilhar as áreas.

# Gerando um gráfico de área simples
pinguins %>% 
  count(year) %>% 
  ggplot() +
  geom_area(aes(x = year, y = n))

# Gerando um gráfico de área empilhada
pinguins %>% 
  count(year, species) %>% 
  ggplot() +
  geom_area(aes(x = year, y = n, fill = species, color = species))

# Gerando um gráfico de área segmentado por facetas
pinguins %>% 
  count(year, species) %>% 
  ggplot() +
  geom_area(aes(x = year, y = n, fill = species, color = species)) +
  facet_wrap(~species)


# geom_histogram() --------------------------------------------------------

# geom_histogram: O geom_histogram apresenta uma visualização gráfica em
# que uma variável numérica e sequencial tem sua frequência calculada.

# Gerando um histograma simples
pinguins %>% 
  ggplot() +
  geom_histogram(aes(x = body_mass_g), binwidth = 100)

# Gerando um histograma segmentado por facetas
pinguins %>% 
  ggplot() +
  geom_histogram(aes(x = body_mass_g, fill = species), binwidth = 100) +
  facet_wrap(~species)


# geom_tile() -------------------------------------------------------------

# geom_tile: Este geom apresenta um mapa de calor (heatmap) a partir do
# cruzamento entre duas variáveis categóricas com uma terceira variável
# numérica sequencial.

# Gerando um mapa de calor
pinguins %>% 
  select(species, sex, body_mass_g) %>% 
  ggplot() +
  geom_tile(aes(x = species, y = sex, fill = body_mass_g))

