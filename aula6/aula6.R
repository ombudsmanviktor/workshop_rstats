# Curso: Introdução à Análise de Pesquisa Quantitativa
# Professor: Viktor Chagas
# Semestre Letivo: 2020.2
# Aula: 6
# Programa de curso: https://rpubs.com/viktor/workshop_rstats

# Antes de mais nada, vamos requisitar alguns pacotes com os quais vamos trabalhar hoje:
#install.packages(magick)
#install.packages(tidyr)
#install.packages(stringr)
library(dplyr)
library(tidyr)
library(stringr)
library(magick)
library(palmerpenguins)

### Tidyr

# Frequentemente, os dados dispostos em bancos de dados precisam ser arrumados, antes de serem
# analisados. O Tidyverse considera que o modelo ideal de arrumação de dados é o modelo designado
# por tidy data. Os bancos de dados tidy obedecem a três regras:

# 1. Cada variável deve ter sua própria coluna
# 2. Cada observação deve ter sua própria linha
# 3. Cada valor deve ter sua própria célula

# Visualmente, as regras se apresentam dessa forma:

magick::image_read(
  "https://raw.githubusercontent.com/ombudsmanviktor/workshop_rstats/main/aula6/tidy_data.png"
) %>% magick::image_scale("640") %>% print()

# Ocorre que nem todos os bancos de dados, inicialmente, se encontram arrumados dessa forma.
# Por isso, muitas vezes, é necessário arrumar esses dados.

# Considere, por exemplo, os conjuntos de dados a seguir. Qual(quais) desse(s) conjunto(s)
# é(são) tidy? E por quê?

#> tabela 1 # A tibble: 6 x 4
#>   country      year  cases population
#>   <chr>       <int>  <int>      <int>
#> 1 Afghanistan  1999    745   19987071
#> 2 Afghanistan  2000   2666   20595360
#> 3 Brazil       1999  37737  172006362
#> 4 Brazil       2000  80488  174504898
#> 5 China        1999 212258 1272915272
#> 6 China        2000 213766 1280428583

#> tabela 2 # A tibble: 12 x 4
#>   country      year type           count
#>   <chr>       <int> <chr>          <int>
#> 1 Afghanistan  1999 cases            745
#> 2 Afghanistan  1999 population  19987071
#> 3 Afghanistan  2000 cases           2666
#> 4 Afghanistan  2000 population  20595360
#> 5 Brazil       1999 cases          37737
#> 6 Brazil       1999 population 172006362
#> # … with 6 more rows

#> tabela 3 # A tibble: 6 x 3
#>   country      year rate             
#> * <chr>       <int> <chr>            
#> 1 Afghanistan  1999 745/19987071     
#> 2 Afghanistan  2000 2666/20595360    
#> 3 Brazil       1999 37737/172006362  
#> 4 Brazil       2000 80488/174504898  
#> 5 China        1999 212258/1272915272
#> 6 China        2000 213766/1280428583

#> tabela4A casos # A tibble: 3 x 3
#>   country     `1999` `2000`
#> * <chr>        <int>  <int>
#> 1 Afghanistan    745   2666
#> 2 Brazil       37737  80488
#> 3 China       212258 213766

#> tabela4B população # A tibble: 3 x 3
#>   country         `1999`     `2000`
#> * <chr>            <int>      <int>
#> 1 Afghanistan   19987071   20595360
#> 2 Brazil       172006362  174504898
#> 3 China       1272915272 1280428583

# Os dois problemas mais comuns com bancos de dados não arrumados são:

# 1. Uma variável pode estar espalhada por várias colunas
# 2. Uma observação pode estar espalhada por várias linhas

# Para solucionar esses dois problemas comuns, utilizaremos o pacote tidyr e seus
# dois principais verbos: gather() e spread()

### Reunir

# gather() reúne duas ou mais colunas que representam a mesma variável. O resultado é um
# banco de dados mais vertical, com um número menor de colunas, e com colunas que representam,
# cada uma, uma variável diferente.

magick::image_read(
  "https://raw.githubusercontent.com/ombudsmanviktor/workshop_rstats/main/aula6/tidy_gather.png"
) %>% magick::image_scale("640") %>% print()

# A função gather() requer três parâmetros:

# 1. O conjunto de colunas que deve ser reunido (variáveis)
# 2. O nome da variável a ser criada (chave)
# 3. O nome da variável cujos valores estão espalhados (valores)

# Os parâmetros são informados segundo a seguinte sintaxe:

# tabela %>% gather(variavel1, variavel2, key = "chave", value = "valores")

pinguins1 <- penguins %>% 
  mutate(id = row_number()) %>% # Adicionar uma chave primária
  gather(bill_length_mm, bill_depth_mm, # Reunir colunas
         key = "bico", value = "medidas"
  ) %>% 
  select(id, species, island, sex, body_mass_g, bico, medidas) # Selecionar colunas

### Espalhar

# spread() espalha duas ou mais colunas que representam variáveis diferentes e encontram-se
# reunidas. O resultado é um banco de dados mais horizontal, com um número maior de colunas,
# e com colunas que representam, cada uma, uma variável diferente.

magick::image_read(
  "https://raw.githubusercontent.com/ombudsmanviktor/workshop_rstats/main/aula6/tidy_spread.png"
) %>% magick::image_scale("640") %>% print()

# A função spread() requer dois parâmetros:

# 1. A coluna que contém os nomes das variáveis a serem criadas (chave)
# 2. A coluna que contém os valores das variáveis (valores)

# Os parâmetros são informados segundo a seguinte sintaxe:

# tabela %>% spread(chave, valores)

pinguins2 <- pinguins1 %>% 
  spread(
    bico, medidas # Espalhar colunas
    ) 

### Unir

# unite() combina várias colunas em uma única.

magick::image_read(
  "https://raw.githubusercontent.com/ombudsmanviktor/workshop_rstats/main/aula6/tidy_unite.png"
) %>% magick::image_scale("640") %>% print()

# A função unite() requer até três parâmetros:

# 1. A nova coluna resultante da união das variáveis selecionadas
# 2. As variáveis a serem unidas
# 3. O separador, se houver (parâmetro opcional)

# Os parâmetros são informados segundo a seguinte sintaxe:

# tabela %>% unite(coluna, variavel1, variavel2, sep = "")

pinguins3 <- penguins %>% 
  mutate(id = row_number()) %>% # Adicionar uma chave primária
  unite(bico, bill_length_mm, bill_depth_mm, # Unir colunas
         sep = "/"
  ) %>% 
  select(id, species, island, sex, body_mass_g, bico) # Selecionar colunas

### Separar

# separate() separa uma coluna em duas ou mais.

magick::image_read(
  "https://raw.githubusercontent.com/ombudsmanviktor/workshop_rstats/main/aula6/tidy_separate.png"
) %>% magick::image_scale("640") %>% print()

# A função separate() requer até três parâmetros:

# 1. A variável a ser separada
# 2. As novas colunas resultantes da separação da variável selecionada
# 3. O separador, se houver (parâmetro opcional)

# Os parâmetros são informados segundo a seguinte sintaxe:

# tabela %>% separate(coluna, into = c("variavel1", "variavel2"), sep = "")

pinguins4 <- pinguins3 %>% 
  separate(bico, c("comprimento (mm)", "largura (mm)"), # Separar colunas
        sep = "/"
  ) %>% 
  select(id, species, island, sex, body_mass_g, 
         `comprimento (mm)`, `largura (mm)`) # Selecionar colunas

### Stringr: algumas funções básicas

# Muitas vezes, os valores dispostos em nosso banco de dados se apresentam como
# variáveis de texto (strings). Algumas dessas variáveis textuais precisam
# ser remodeladas ou transformadas, a fim de facilitar nossa interpretação.
# Vamos aprender algumas funções de manipulação de strings a seguir.

# Convertendo strings em minúsculas e em maiúsculas:

# str_to_upper
pinguins5 <- pinguins1 %>% 
  mutate(maiuscula = str_to_upper(island))

# str_to_lower
pinguins6 <- pinguins5 %>% 
  mutate(minuscula = str_to_lower(species))

# str_to_title
pinguins7 <- pinguins6 %>% 
  mutate(titulo = str_to_title(sex))

# Detectando padrões textuais em um vetor de strings

pinguins7 <- pinguins7 %>% 
  mutate(string_teste = sex)

pinguins7$string_teste <- pinguins7$string_teste %>% 
  str_detect("ale")

# Substituindo padrões textuais em um vetor de strings

pinguins7$sex <- pinguins7$sex %>% 
  str_replace("female", "fêmea") %>% 
  str_replace("male", "macho")

# Vamos agora fazer alguns exercícios?

### EXERCÍCIO 1

# Considere o conjunto de dados abaixo:

representatividade_2018 <- read.csv(
  "https://raw.githubusercontent.com/ombudsmanviktor/workshop_rstats/main/aula6/representatividade_2018.csv")

# Arrume os dados de modo a tornar a estrutura do banco tidy.
# DICA: Mantenha três colunas na tabela e transforme negros_pardos e mulheres em uma só variável.


### EXERCÍCIO 2

# Considere o conjunto de dados abaixo:

bbb21_mensagens <- read.csv(
  "https://raw.githubusercontent.com/ombudsmanviktor/workshop_rstats/main/aula6/bbb21_mensagens.csv")

# A coluna métricas possui dois valores associados na mesma célula. Transforme esses dois
# valores em duas variáveis diferentes, considerando o primeiro valor como de RTs recebidos
# por um determinado tweet, e o segundo valor como o de vezes em que esse mesmo tweet foi
# favoritado.


### EXERCÍCIO 3

# Considere o mesmo dataframe anterior:

bbb21_mensagens

# Procure quantas vezes Juliette é mencionada nesse conjunto de mensagens.

# Substitua todas as menções a Bolsonaro (ou bolsonaro ou BOLSONARO) por Bozo

# Transforme todos os caracteres das mensagens nos tweets em minúsculas.


