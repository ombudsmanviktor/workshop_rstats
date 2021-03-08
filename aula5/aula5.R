# Curso: Introdução à Análise de Pesquisa Quantitativa
# Professor: Viktor Chagas
# Semestre Letivo: 2020.2
# Aula: 5
# Programa de curso: https://rpubs.com/viktor/workshop_rstats

# Antes de mais nada, vamos requisitar alguns pacotes com os quais vamos trabalhar hoje:
#install.packages(magick)
library(dplyr)
library(magick)
library(palmerpenguins)

### Dados relacionais

# A análise de dados raramente envolve uma única tabela ou dataframe. Normalmente, o cientista
# de dados precisa lidar com múltiplas tabelas. E frequentemente os dados contidos em uma tabela
# criam relações com aqueles dispostos em outras. As relações são sempre constituídas a partir
# de um par de tabelas. Mesmo quando se trata de três ou mais tabelas de dados, essas relações
# são sempre definidas entre cada par. E, às vezes, os elementos de cada par podem integrar a
# mesma tabela.

# Softwares de análise de redes sociais trabalham com uma única tabela de dados relacionais,
# que contém pelo menos duas colunas: uma coluna chamada SOURCE (origem) e uma coluna chamada
# TARGET (destino). Ambas designam seguidores e seguidos, respectivamente.

# Para trabalhar com dados relacionais em tabelas pareadas é importante reconhecer e estabelecer
# essas relações. Por isso, alguns verbos são importantes no trabalho com esse tipo de dado.
# Vamos aprender hoje, principalmente, a família de verbos join, que nos permite operar entre
# duas diferentes tabelas.

# Mas, primeiro, vamos entender visualmente como as relações entre tabelas se dão:
magick::image_read(
  "https://raw.githubusercontent.com/ombudsmanviktor/workshop_rstats/main/aula5/dados_relacionais.png"
  ) %>% magick::image_scale("640") %>% print()

# Note que cada tabela possui atributos ou variáveis que são responsáveis por identificar
# os metadados de um determinado objeto. Alguns desses atributos criam relações entre uma
# tabela e outra.

### Chaves

# Para compreender o princípio das tabelas de dados relacionais, precisamos, antes, entender
# que cada par de tabelas é conectado entre si pelo que chamamos de chaves (keys). Uma chave é
# uma variável que identifica uma única observação, ou seja, um valor que não se repete. Só
# a partir das chaves podemos conectar diferentes tabelas.

# Existem diferentes tipos de chaves:

# Primary key (chave primária): identifica de modo único uma observação na sua própria tabela.
# P.ex., na imagem ao lado, LIVRO$ID_Livro é um identificar único para cada livro na tabela LIVRO.

# Foreign key (chave estrangeira): identifica de modo único uma observação em uma outra tabela.
# P.ex., na imagem ao lado, EMPRESTIMO$ID_Livro é um identificador único originário da tabela
# LIVRO e que aparece na tabela EMPRESTIMO como uma chave estrangeira.

# Em algumas tabelas, não há um identificador único presente. Nesses casos, pode ser necessário
# adicionar uma chave substituta (surrogate key) para criar relações com outras tabelas de dados.

# Vamos adicionar um identificador único numérico para os dados da tabela abaixo?

pinguins <- penguins %>% select(species, island, body_mass_g, sex)

count(pinguins) # Para saber quantas observações há
pinguins <- pinguins %>% 
  mutate(id_pinguim = seq(1:344)) # Com a sequência determinada

pinguins <- pinguins %>% 
  mutate(id_pinguim = row_number()) # Com base na contagem de linhas

# Agora, vamos aprender um pouquinho sobre como manipular esses dados relacionais e
# criar relações entre diferentes tabelas de dados

### Joins

# Existem dois tipos principais de operações com a família de verbos join do dplyr:

# Mutating joins: adicionam novas variáveis a um dataframe a partir das observações
# correspondentes em outro.

# Filtering joins: filtram observações em um dataframe com base caso elas combinem
# com observações contidas em outra tabela.

magick::image_read(
  "https://raw.githubusercontent.com/ombudsmanviktor/workshop_rstats/main/aula5/joins.png"
) %>% magick::image_scale("200") %>% print()

### Mutating joins

# Os mutating joins podem ser inner join ou outer joins. O inner join mantém as
# as observações que aparecem em ambas as tabelas, enquanto os outer joins mantêm
# as observações que aparecem em pelo menos uma das tabelas. Outer joins podem ser
# left join (mantém todas as observações em X), right join (mantém todas as observações
# em y) e full join (mantém todas as observações em x e y), conforme a ilustração
# a seguir:

magick::image_read(
  "https://raw.githubusercontent.com/ombudsmanviktor/workshop_rstats/main/aula5/joins_mutating.png"
) %>% magick::image_scale("450") %>% print()

# Vamos testar as diferenças?

# Primeiro, vamos criar as bases de exemplo:

# Primeiro dataframe: somente os pinguins encontrados na ilha Torgersen
pinguins1 <- pinguins %>% 
  select(id_pinguim, species, island) %>% 
  filter(island == "Torgersen")

# Segundo dataframe: somente os pinguins machos
pinguins2 <- pinguins %>% 
  select(id_pinguim, body_mass_g, sex) %>% 
  filter(sex == "male")

# Inner join: somente os pinguins machos (df2) E encontrados na ilha Torgersen (df1)

pinguins_innerjoin <- pinguins1 %>% inner_join(pinguins2, by = "id_pinguim")

# Left join: somente os pinguins encontrados na ilha Torgersen (df1), machos (df2) ou não

pinguins_leftjoin <- pinguins1 %>% left_join(pinguins2, by = "id_pinguim")

# Right join: somente os pinguins machos (df2), encontrados na ilha Torgersen (df1) ou não

pinguins_rightjoin <- pinguins1 %>% right_join(pinguins2, by = "id_pinguim")

# Full join: pinguins machos (df2) ou não, encontrados na ilha Torgersen (df1) ou não

pinguins_fulljoin <- pinguins1 %>% full_join(pinguins2, by = "id_pinguim")

### Filtering joins

# Filtering joins combinam as observações do mesmo modo que mutating joins, mas não
# incorporam novas variáveis, apenas filtram as observações. Há dois tipos de filtering
# joins: semi join (mantém as observações em x que tenham combinação em y) e anti join
# (descarta as observações em x que tenham combinação em y). Visualmente, as operações
# podem ser ilustradas da seguinte forma:

magick::image_read(
  "https://raw.githubusercontent.com/ombudsmanviktor/workshop_rstats/main/aula5/joins_filtering.png"
) %>% magick::image_scale("450") %>% print()

# Vamos aos testes?

# Semi join: somente os pinguins machos (df2) E encontrados na ilha Torgersen (df1),
# mas sem adicionar novas variáveis ao df1

pinguins_semijoin <- pinguins1 %>% semi_join(pinguins2, by = "id_pinguim")

# Anti join: somente os pinguins NÃO machos (!= df2) E encontrados na ilha Torgersen (df1),
# mas sem adicionar novas variáveis ao df1

pinguins_antijoin <- pinguins1 %>% anti_join(pinguins2, by = "id_pinguim")

### Binds

# Existem ainda duas formas úteis de combinar dados de diferentes dataframes: uni-los pelas
# suas linhas (bind_rows) ou pelas suas colunas (bind_cols). Graficamente, essas operações
# podem ser representadas da seguinte maneira:

magick::image_read(
  "https://raw.githubusercontent.com/ombudsmanviktor/workshop_rstats/main/aula5/joins_bind.png"
) %>% magick::image_scale("450") %>% print()

# Vamos, primeiro, criar as bases de exemplo, mais uma vez:

# Terceiro dataframe: somente os pinguins encontrados na ilha Biscoe
pinguins3 <- pinguins %>% 
  select(id_pinguim, species, island) %>% 
  filter(island == "Biscoe")

# Quarto dataframe: todos os pinguins somente por id e espécie
pinguins4 <- pinguins %>% 
  select(id_pinguim, species)

# Quinto dataframe: todos os pinguins somente por ilha e sexo
pinguins5 <- pinguins %>% 
  select(island, sex)

# Testando as funções:

# Bind_rows: adiciona aos pinguins encontrados na ilha Torgersen (df1) os pinguins
# encontrados na ilha Biscoe (df3)

pinguins_bindrows <- pinguins1 %>% 
  bind_rows(pinguins3)

# Bind_cols: justapõe as tabelas de pinguins com categorias diferentes lado a lado (df4 e df5)

pinguins_bindcols <- pinguins4 %>% 
  bind_cols(pinguins5)

# Vamos agora fazer alguns exercícios?

### EXERCÍCIO 1

# Considere a base de dados abaixo:

eleicao_candidato_nomes <- read.csv(
  "https://raw.githubusercontent.com/ombudsmanviktor/workshop_rstats/main/aula5/eleicao_candidato_nomes.csv"
  )

# 1. Insira uma chave substituta para que as observações na tabela possuam um identificador único

### EXERCÍCIO 2

# Considere as tabelas de dados relacionais abaixo:

eleicao_info <- read.csv("https://raw.githubusercontent.com/ombudsmanviktor/workshop_rstats/main/aula5/eleicao_info.csv")
eleicao_partido <- read.csv("https://raw.githubusercontent.com/ombudsmanviktor/workshop_rstats/main/aula5/eleicao_partido.csv")
eleicao_candidato <- read.csv("https://raw.githubusercontent.com/ombudsmanviktor/workshop_rstats/main/aula5/eleicao_candidato.csv")
eleicao_composicao <- read.csv("https://raw.githubusercontent.com/ombudsmanviktor/workshop_rstats/main/aula5/eleicao_composicao.csv")
eleicao_candidato_somentept <- read.csv("https://raw.githubusercontent.com/ombudsmanviktor/workshop_rstats/main/aula5/eleicao_candidato_somentept.csv")

# 1. Monte uma tabela com o nome do candidato na urna, o cargo que disputa, a sigla do estado 
# pelo qual disputa as eleições, a sigla de seu partido e os partidos em sua coligação

# 2. Monte uma tabela somente com as candidatas petistas mulheres que disputaram o cargo
# de deputadas federais e que apresente nome da candidata na urna e sigla do estado em que
# concorreu ordenado alfabeticamente

### EXERCÍCIO 3

# Considere as tabelas de dados relacionais abaixo:

eleicao_Norte <- read.csv("https://raw.githubusercontent.com/ombudsmanviktor/workshop_rstats/main/aula5/eleicao_Norte.csv")
eleicao_Nordeste <- read.csv("https://raw.githubusercontent.com/ombudsmanviktor/workshop_rstats/main/aula5/eleicao_Nordeste.csv")
eleicao_Sul <- read.csv("https://raw.githubusercontent.com/ombudsmanviktor/workshop_rstats/main/aula5/eleicao_Sul.csv")
eleicao_Sudeste <- read.csv("https://raw.githubusercontent.com/ombudsmanviktor/workshop_rstats/main/aula5/eleicao_Sudeste.csv")
eleicao_CentroOeste <- read.csv("https://raw.githubusercontent.com/ombudsmanviktor/workshop_rstats/main/aula5/eleicao_CentroOeste.csv")

# 1. Monte uma tabela somente com as candidaturas do PSL ao senado federal nas regiões
# Sul, Sudeste e Centro-Oeste

# 2. Indique quantos candidatos a deputado federal o PSOL lançou em todo o Brasil por estado

