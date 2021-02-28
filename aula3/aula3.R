# Curso: Introdução à Análise de Pesquisa Quantitativa
# Professor: Viktor Chagas
# Semestre Letivo: 2020.2
# Aula: 3
# Programa de curso: https://rpubs.com/viktor/workshop_rstats

# Vetores

## Vetores são matrizes unidimensionais que podem conter números inteiros,
## números reais(ponto flutuante com dupla precisão), complexos, caracteres(strings) ou valores lógicos

notas <- (c(6.0, 7.1, 5.5, 3.0, 10.0, 100.0, 6.5, 8.2, 2.9, 3.5, 9.9, 
            9.1, 8.2, 7.6, 9.9, 10.0, 6.7, 4.9, 10.0, 6.8, 6.0))
View(notas)
names(notas) <- (c("João", "Maria", "Joaquim", "Ana", "Enzo", "Valentina", "Júlia", "Lucas", "Beatriz", "Carol", "José", 
                   "Daniela", "Daniel", "Manuela", "Luiz", "Fátima", "Gilberto", "Roberta", "Otávio", "Josias", "Helena"))
View(notas)
notas["João"]
notas >= 6.0
notas[notas >= 6.0]

notas <- (c(6.0, 7.1, 5.5, 3.0, 10.0, 100.0, 6.5, 8.2, 2.9, 3.5, 9.9, 
            9.1, 8.2, 7.6, 9.9, 10.0, 6.7, 4.9, 10.0, 6.8, 6.0))
nomes <- (c("João", "Maria", "Joaquim", "Ana", "Enzo", "Valentina", "Júlia", "Lucas", "Beatriz", "Carol", "José", 
            "Daniela", "Daniel", "Manuela", "Luiz", "Fátima", "Gilberto", "Roberta", "Otávio", "Josias", "Helena"))
boletim <- cbind(nomes,notas)
View(boletim)
boletim <- as.matrix(boletim) # Matrix
boletim_lista <- as.list(boletim) # List
boletim <- as.data.frame(boletim) # Dataframe
boletim <- tibble::as_tibble(boletim) # Tibble

# Tipos de variavel

## Aquino, 2014, p. 14

## Numéricas (numeric): Números inteiros ou reais, como idade, renda, número de filhos.

## Datas (Date): São um tipo especial de variável numérica.

## Categóricas (factor): Variáveis qualitativas, ou seja, características dos indivíduos para as quais
## não é possível atribuir um valor numérico, como sexo, religião, estado civil, opinião sobre algum tema.
## É possível agrupar os indivíduos em categorias e contar quantos indivíduos pertencem a cada categoria,
## mas se, por exemplo, um indivíduo afirma ser católico, e outro, protestante, não podemos, com base
## nessas afirmações, considerar um mais religioso do que o outro.

## Categóricas ordenáveis (ordered): Tipo de variável categórica cujas categorias podem ser hierarquizáveis,
## como grau de escolaridade, alguns tipos de respostas a perguntas de questionário. Se à pergunta “Qual o
## papel do governo?”, as opções de resposta forem “O governo deve mandar em tudo”, “O governo deve controlar
## algumas coisas” e “Não precisamos de governo”, poderíamos considerar aqueles que optaram pela primeira
## opção adeptos de uma ideologia mais estatizante do que aqueles que escolheram a terceira opção.

## Texto (character): Características puramente individuais que não podem ser utilizadas para categorizar
## os indivíduos. Geralmente aparecem nos bancos de dados apenas para ajudar em análises qualitativas
## e não estatísticas. Exemplo: o nome dos candidatos num banco de dados de resultados eleitorais. Em
## alguns casos, os textos são passíveis de categorização, como as respostas a uma pergunta aberta.
## Neste caso, seria preciso manualmente recodificar as respostas abertas numa nova variável contendo
## um número limitado de categorias.

## Booleanas (logical): Variáveis cujos valores podem ser VERDADEIRO ou FALSO; no R, TRUE ou FALSE.

summary(variavel)
class(variavel)
numero <- 1:10
class(numero)
summary(numero)
numero <- 1
class(numero)
numero <- "1"
class(numero)
summary(numero)
numero <- 1 == 1
class(numero)
numero <- 2021-02-09
numero
numero <- "2021-02-09"
class(numero)
numero <- as.Date("2021-02-09")
class(numero)
# Factor com três diferentes níveis
tamanho <- factor(c("pequeno", "grande", "grande", "pequeno", "medio"))
tamanho
class(tamanho)
# Determinando a ordem do fator
tamanho <- factor(c("pequeno", "grande", "grande", "pequeno", "medio"),
                  levels = c("pequeno", "medio", "grande"), ordered = TRUE)
tamanho
class(tamanho)

# Média e mediana

## Média: soma de todos os valores da amostra dividida pela quantidade de valores presentes.
## A média é influenciada por todos os valores.

## Mediana: valor que está no meio da amostra. É necessário ordenar os valores para reconhecer a mediana.
## A mediana ignora os outliers.

mean(c(1,7,3,2,4))
median(c(1,7,3,2,4))
mean(c(6.0, 7.1, 5.5, 3.0, 10.0, 100.0, 6.5, 8.2, 2.9, 3.5, 9.9, 
       9.1, 8.2, 7.6, 9.9, 10.0, 6.7, 4.9, 10.0, 6.8, 6.0))
median(c(6.0, 7.1, 5.5, 3.0, 10.0, 100.0, 6.5, 8.2, 2.9, 3.5, 9.9, 
         9.1, 8.2, 7.6, 9.9, 10.0, 6.7, 4.9, 10.0, 6.8, 6.0))
## 2.9, 3.0, 3.5, 4.9, 5.5, 6.0, 6.0, 6.5, 6.7, 6.8,
## 7.1, 7.6, 8.2, 8.2, 9.1, 9.9, 9.9, 10.0, 10.0, 10.0, 100.0

# Resumos de variáveis
notas <- c(6.0, 7.1, 5.5, 3.0, 10.0, 100.0, 6.5, 8.2, 2.9, 3.5, 9.9, 
           9.1, 8.2, 7.6, 9.9, 10.0, 6.7, 4.9, 10.0, 6.8, 6.0)
summary(notas)
head(notas)
dplyr::glimpse(notas)

#Instalando pacotes
install.packages("palmerpenguins")
library(palmerpenguins)
?penguins
?penguins_raw
penguins
View(penguins)
View(penguins_raw)
palmerpenguins::penguins

install.packages("dplyr")
install.packages(c("ggplot2","tidyr"))
install.packages("tidyverse")
library(tidyvere)

# Exportando dados em formato CSV
## Recriando o dataframe
notas <- (c(6.0, 7.1, 5.5, 3.0, 10.0, 100.0, 6.5, 8.2, 2.9, 3.5, 9.9, 
            9.1, 8.2, 7.6, 9.9, 10.0, 6.7, 4.9, 10.0, 6.8, 6.0))
nomes <- (c("João", "Maria", "Joaquim", "Ana", "Enzo", "Valentina", "Júlia", "Lucas", "Beatriz", "Carol", "José", 
            "Daniela", "Daniel", "Manuela", "Luiz", "Fátima", "Gilberto", "Roberta", "Otávio", "Josias", "Helena"))
boletim <- cbind(nomes,notas)
## Exportando dados
write.csv(boletim,"~/Downloads/boletim.csv", fileEncoding = "UTF-8")
## Importando dados
boletim2 <- read.csv("~/Downloads/boletim.csv", fileEncoding = "UTF-8")

