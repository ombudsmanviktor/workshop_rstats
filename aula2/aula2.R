# Curso: Introdução à Análise de Pesquisa Quantitativa
# Professor: Viktor Chagas
# Semestre Letivo: 2020.2
# Aula: 2
# Programa de curso: https://rpubs.com/viktor/workshop_rstats

# Introdução e instalação do R e R Studio

# Inserindo novas variáveis
1
print(1)
texto
print(texto)
"texto"
variavel = "texto"
variavel
print(variavel)
View(variavel)
variavel <- "um novo texto"
variavel
1:60
seq(from = 1, to = 60)
seq(1,60)
seq(1,60,3)
seq(1,60,.5)
letters
letters[3]
seq(1,60,3)[5]
rep("texto",10)
variavel <- seq(1,60)
length(variavel)

# Operadores matemáticos ou lógicos
1+1
3-1
1-2
9 / 3
2 * 3
4 ^ 2
(3 + 1) * (6 - 1) ^ 2
3 + 1 * 6 - 1 ^ 2
(1 + (2 * 3)) * 5
sqrt(16) # raiz quadrada de 16
log(10,10) # log de 10 na base 10
# Boolean
3 > 2
5 < 2
2 == 2
2 != 2
(6 > 5) & (7 > 8) # AND
(6 > 5) | (7 > 8) # OR

# Inserindo múltiplas variáveis

## Função c() de combinação
c(1, 2, 3, 4, 5, 6,
  7, 8, 9, 10, 11)
c("banana", "laranja", "abacate")
vetor <- c("banana", "laranja", "abacate")
print(vetor)
View(vetor)
vetor1 <- c(1, 2, 3)
vetor2 <- c(2,4,5)
vetor1 + vetor2
vetor1 * vetor2
sum(vetor1) # Soma
prod(vetor2) # Produto (Multiplicação)
max(vetor2)
min(vetor2)
