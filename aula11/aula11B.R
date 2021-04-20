# Curso: Introdução à Análise de Pesquisa Quantitativa
# Professor: Viktor Chagas
# Semestre Letivo: 2020.2
# Aula: 11B
# Programa de curso: https://rpubs.com/viktor/workshop_rstats

# Solicitar pacotes -------------------------------------------------------
#install.packages("ggplot2")
library(ggplot2)
library(dplyr)
library(palmerpenguins)
library(RColorBrewer)

# Customizações -----------------------------------------------------------

# Importando os dados
pinguins <- penguins %>% tidyr::drop_na()

# Títulos
pinguins %>% 
  ggplot() +
  geom_point(aes(x = body_mass_g, y = flipper_length_mm, color = species)) +
  labs(title = "Um título bem bonito", 
       subtitle = "Seguido de um subtítulo",
       x = "O eixo X",
       y = "O eixo Y",
       caption = "A sua legenda")

# Fundo
pinguins %>% 
  ggplot() +
  geom_point(aes(x = body_mass_g, y = flipper_length_mm, color = species)) +
  theme(panel.background = element_rect(fill="white", colour="red"))

# Limites dos eixos
pinguins %>% 
  ggplot() +
  geom_point(aes(x = body_mass_g, y = flipper_length_mm, color = species)) +
  ylim(0,300) +
  xlim(0,6500)

# Valores
pinguins %>%
  filter(species == "Adelie") %>% 
  ggplot() +
  geom_point(aes(x = body_mass_g, y = flipper_length_mm, color = species)) +
  geom_text(aes(label = body_mass_g, x = body_mass_g, y = flipper_length_mm), 
            color = "#000000", size = 2, hjust = -1, vjust = 0)

# Outras customizações em: https://www.r-graph-gallery.com/

# Cores -------------------------------------------------------------------

pinguins %>% 
  ggplot() +
  geom_point(aes(x = body_mass_g, y = flipper_length_mm, color = species)) +
  scale_color_manual(values=c("black", "red", "yellow"))

pinguins %>% 
  ggplot() +
  geom_bar(aes(x = sex, y = body_mass_g, fill = sex), stat = "identity") +
  coord_flip() +
  scale_fill_manual(values=c("black", "red"))

RColorBrewer::display.brewer.all()

pinguins %>% 
  ggplot() +
  geom_point(aes(x = body_mass_g, y = flipper_length_mm, color = species)) +
  scale_colour_brewer(palette = "Dark2", direction = 1)

pinguins %>% 
  ggplot() +
  geom_bar(aes(x = sex, y = body_mass_g, fill = sex), stat = "identity") +
  coord_flip() +
  scale_fill_brewer(palette = "Set2", direction = 1)


# Temas -------------------------------------------------------------------

pinguins %>% 
  ggplot() +
  geom_point(aes(x = body_mass_g, y = flipper_length_mm, color = species)) +
  theme_bw()

pinguins %>% 
  ggplot() +
  geom_point(aes(x = body_mass_g, y = flipper_length_mm, color = species)) +
  theme_classic()

pinguins %>% 
  ggplot() +
  geom_point(aes(x = body_mass_g, y = flipper_length_mm, color = species)) +
  theme_dark()

pinguins %>% 
  ggplot() +
  geom_point(aes(x = body_mass_g, y = flipper_length_mm, color = species)) +
  theme_light()

pinguins %>% 
  ggplot() +
  geom_point(aes(x = body_mass_g, y = flipper_length_mm, color = species)) +
  theme_minimal()

pinguins %>% 
  ggplot() +
  geom_point(aes(x = body_mass_g, y = flipper_length_mm, color = species)) +
  theme_void()

