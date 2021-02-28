# Curso: Introdução à Análise de Pesquisa Quantitativa
# Professor: Viktor Chagas
# Semestre Letivo: 2020.2
# Aula: 4
# Programa de curso: https://rpubs.com/viktor/workshop_rstats

# Instalação de pacotes no R

# Para instalar pacotes, utilize o comando install.packages(""), indicando entre aspas
# o nome do pacote pretendido. É possível também proceder uma instalação pelo modo
# gráfico, no menu Packages > Install do R Studio.

# O R fornece uma série de pacotes com datasets para testar manipulação de dados.
# Alguns desses pacotes já estão integrados à R Base, como mtcars (pacote com dados sobre
# modelos de carros esportivos). Outros, precisam de instalação adicional, como palmerpenguins
# (pacote com dados sobre pinguins catalogados na Antártida). Vamos visualizar esses dados?

mtcars
carros <- mtcars
View(carros)

install.packages("palmerpenguins")
library(palmerpenguins)

penguins
dados_aves <- penguins
View(dados_aves)

# Para remover um pacote já requisitado, basta usar o comando detach(package:)

detach("package:palmerpenguins")

# Para utilizar as funções de um pacote, há duas maneiras. A primeira delas é
# requisitar o pacote, por meio da função library(). A segunda é indicar o nome
# do pacote imediatamente antes de executar a função. Veja os exemplos abaixo.

palmerpenguins::penguins

library(palmerpenguins)
penguins

# Vamos agora conhecer um pouco mais sobre manipulação de bancos de dados?

# Instalação do pacote dplyr
install.packages("dplyr")

# Utilização do pacote dplyr

library(dplyr)

# O dplyr é um dos pacotes do Tidyverse e é voltado especificamente para o trabalho
# de manipulação de dados. O dplyr se estrutura em torno de um conjunto de verbos,
# que operam como funções para a manipulação de grandes bancos de dados. Vamos conhecer
# os principais verbos:

# select(): seleciona uma ou mais colunas de um dataframe. Utilizado para reduzir o tamanho
# da base de dados que estamos manipulando. Por exemplo, vamos supor que, no dataframe que
# criamos anteriormente, dados_aves, não precisemos lidar com dados de extensão das nadadeiras
# ou massa corporal dos pinguins; queremos apenas saber a espécie, o local de habitação e o sexo.
# Vamos selecionar somente essas colunas?

select(dados_aves, species, island, sex) # O primeiro parâmetro é o dataframe, os demais são as colunas

# O dplyr possui uma sintaxe que facilita o trabalho e permite concatenar vários comandos dentro
# de uma só expressão. Para isso, vamos conhecer um pouquinho o "pipe" (ou %>%). O pipe é um
# operador que foi criado originalmente para o pacote magritrr. No dplyr, ele permite
# que você indique primeiro o banco de dados e depois estruture suas funções de modo encadeado.
# O mesmo comando anterior ficaria assim:

dados_aves %>% select(species, island, sex)

# Se eu quiser dispor desse resultado em um novo dataframe:

dados_aves_resumido <- dados_aves %>% 
  select(species, island, sex)

# Não se assuste: você pode digitar o pipe de forma simples com <CTRL+SHIFT+M>

# filter(): filtra um dataframe com vetores lógicos. Em outras palavras, deixa apenas as
# linhas que satisfazem a certo critério. Por exemplo: suponhamos que queiramos manter em
# nosso dataframe apenas os pinguins de sexo feminino e encontrados na ilha de Torgersen.
# Que comando executamos?

filter(dados_aves, sex == "female", island == "Torgersen") 

# Ou, usando o %>% 

dados_aves %>% filter(sex == "female", island == "Torgersen")

# Posso usar filter() e select() na mesma expressão? SIM! Basta encadear os %>% 

dados_aves_resumido <- dados_aves %>% 
  select(species, island, sex) %>% 
  filter(sex == "female", island == "Torgersen")

# mutate(): cria uma nova coluna com base nos parâmetros indicados. Por exemplo, vamos
# criar uma nova coluna com um operador lógico no nosso dataframe original dados_aves 
# para indicar se a ave é grande ou não. Sempre que o espécime pesar mais de 4kg ele
# será classificado como "grande". Adicionalmente, a massa corporal das aves está
# descrita em gramas (g) e nós gostaríamos de transpor esse valor para kg. Como fazemos?

dados_aves_massa <- dados_aves %>% 
  mutate(massa_kg = body_mass_g/1000) %>% # Transpor de g para kg
  mutate(especime_grande = massa_kg > 4) %>%  # Todos
  select(species, body_mass_g, massa_kg, especime_grande)

# arrange(): orderna o dataframe com base em uma coluna. Por exemplo, nós gostaríamos de
# ordenar o dataframe que criamos no exercício anterior com base na coluna massa_kg. Assim,
# podemos ver quais os espécimes mais pesados.

dados_aves_massa <- dados_aves_massa %>% 
  arrange(massa_kg) # Do mais leve ao mais pesado

dados_aves_massa <- dados_aves_massa %>% 
  arrange(desc(massa_kg)) # Do mais pesado ao mais leve

# Você notou que há dois pinguins sem informação de massa corporal? Vamos subtrai-los de
# nossos dados?

dados_aves_massa <- dados_aves_massa %>% 
  arrange(desc(massa_kg)) %>% # Do mais pesado ao mais leve
  tidyr::drop_na()  # Estamos chamando uma função que não está presente no pacote dplyr
                    # Por isso é necessário primeiro instalar o pacote tidyr se você ainda
                    # não tiver feito isso...

# group_by(): agrupa um data.frame segundo um vetor de categorias. “Agrupar” aqui quer dizer
# que todas as operações subsequentes serão feitas separadas por grupos. 

# summarise(): o summarise transforma um vetor com vários números em um único número de acordo
# com uma função.

# Geralmente os verbos group_by() e summarise() vêm combinados com outras funções. Por exemplo,
# qual a espécie de pinguim com maior média de massa corporal?

dados_aves_especies <- dados_aves_massa %>% 
  group_by(species) %>% 
  summarise(media = mean(massa_kg))

# Pense numa receita que tenha as seguintes instruções: junte os igredientes, misture e
# leve ao forno. Na forma usual do R, tais instruções provavelmente teriam a seguinte forma:
  
# forno(misture(junte(ingredientes)))

# Note que temos que pensar "de dentro para fora". O primeiro comando que lemos é forno que,
# na verdade, é a última operação que será realizada! Com o pipe operator, por outro lado,
# você escreveria algo mais ou menos assim:
  
# ingredientes %>% junte %>% misture %>% forno

# É quase igual a ler instruções verbais da receita. Parece mais intuitivo, não?

# Um outro verbo muito útil para tratamento e manipulação de dados é o count(). O resultado 
# de count() é geralmente uma outra tabela, com informações sobre a contagem. A coluna n
# expressa os valores da contagem.

# Vamos tentar descobrir quantos pinguins têm massa corporal superior a 4kg em toda a nossa amostra?

dados_aves %>% 
  filter(body_mass_g > 4000) %>% 
  count()

# E quantos pinguins têm massa corporal inferior a 4kg?

dados_aves %>% 
  filter(body_mass_g < 4000) %>% 
  count()

# E qual a média da massa corporal dos pinguins na nossa amostra?

dados_aves %>% 
  tidyr::drop_na() %>% 
  summarise(media = mean(body_mass_g))

# Vamos fazer exercícios com outro conjunto de dados agora??

### EXERCÍCIO 1

# Considere os dados do IBGE sobre a população brasileira dividida em municípios em 2019
install.packages("devtools")
devtools::install_github("tbrugz/ribge")
populacao2019 <- ribge::populacao_municipios(2019)

# 1. Quais os cinco municípios com maior população no estado do Rio de Janeiro?
# 2. Qual a média populacional dos municípios do Rio de Janeiro?
# 3. Quantos municípios do Rio de Janeiro estão acima dessa média?

### EXERCÍCIO 2

# Considere os dados oficiais do TSE a respeito dos candidatos nas eleições de 2018
install.packages("electionsBR")
candidato_brasil <- electionsBR::candidate_fed(2018)

# 1. Crie uma tabela somente com os dados dos nomes dos candidatos na urna, siglas dos partidos,
# estado por que se candidataram, estado em que nasceram, idade, sexo, raça e 
# grau de instrução, nessa ordem.
# 2. Quais partidos têm mais pretos ou pardos como candidatos?
# 3. Quais partidos têm mais mulheres como candidatas?
# 4. Quantos e quais candidatos se candidataram por um estado diferente daquele que nasceram?
# E qual a porcentagem de candidatos que se candidatam por um estado diferente do que nasceram?

