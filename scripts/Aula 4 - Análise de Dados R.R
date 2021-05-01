###Aula 4 - Análise de Dados - Testes de hipóteses

library(tidyverse)
library(poliscidata)

# Correlação - Importante antes de calcular fazer gráfico de dispersão

banco_nes <- nes

cor(banco_nes$obama_therm, 
    banco_nes$conservatism, use = "complete")

cor.test(banco_nes$obama_therm, 
         banco_nes$conservatism)

# Teste-t

banco_nes %>% 
  group_by(gender) %>% 
  summarise(media = mean(obama_therm, na.rm = T))

t.test(obama_therm ~ gender, data = banco_nes)  #primeiro variável numérica, depois a categórica

# ANOVA. caso de variaveis categoricas

teste_anova <-aov(obama_therm ~ dem_raceeth4, data = banco_nes)
summary(teste_anova)

#Teste Tukey

TukeyHSD(teste_anova)

# qui-quadrado para teste entre variáveis categóricas

chisq.test(banco_nes$obama_vote, banco_nes$gender)


# Gráficos bivariados

banco_nes <- banco_nes %>% 
  remove_missing(vars = "pres_vote12") # tirar os missing/NA

#gráfico de barras com cores (duas variaveis categoricas)

ggplot(banco_nes, aes(gender, fill = pres_vote12)) + 
  geom_bar(position = "fill")


ggplot(banco_nes, aes(pres_vote12, fill = gender)) + 
  geom_bar(position = "fill")

# variáveis categorica(2 ou mais) e contínua
ggplot(banco_nes, aes(conservatism, fill = pres_vote12)) + # fill é a categórica
  geom_density()

#Para resolver se as curvas estao em cima da outra

ggplot(banco_nes, aes(conservatism, fill = pres_vote12)) + # fill é a categórica
  geom_density(alpha = 0.3) # quanto mais perto de 0, mais transparente


ggplot(banco_nes, aes(conservatism, pres_vote12)) +
  geom_boxplot()

ggplot(banco_nes, aes(pres_vote12, conservatism)) +
  geom_boxplot()

ggplot(banco_nes, aes(pres_vote12, conservatism)) +
  geom_violin(draw_quantiles = c(0.25, 0.5, 0.75))

# gráfico de dispersão (com variaveis numericas)

ggplot(banco_nes, aes(obama_therm, conservatism)) +
  geom_point()

# alguns pontos estarão em cima de outros. Para resolver isso:

ggplot(banco_nes, aes(obama_therm, conservatism)) +
  geom_point(alpha = 0.1) #deixar os pontos mais transparentes.


ggplot(banco_nes, aes(obama_therm, conservatism)) +
  geom_jitter(alpha = 0.1) 

# Melhorando os graficos

library(ggthemes)

ggplot(banco_nes, aes(obama_therm, conservatism)) +
  geom_jitter(alpha = 0.1) +
  theme_minimal() + 
  theme_classic() 


ggplot(banco_nes, aes(obama_therm, conservatism)) +
  geom_jitter(alpha = 0.1) +
  theme_tufte() 


ggplot(banco_nes, aes(pres_vote12, conservatism)) +
  geom_tufteboxplot() 


ggplot(banco_nes, aes(pres_vote12, conservatism)) +
  geom_tufteboxplot(median.type = "line",
                    whisker.type = "line",
                    hoffset = 0, width = 3)


ggplot(banco_nes, aes(conservatism, fill = pres_vote12)) + #fill é a variavel categórica
  geom_density(alpha = 0.3) +
  scale_fill_ptol() + #mudando cores default
  labs(title = "figura 1",
       subtitle = "gráfico de curva de densidade",
       x = "Conservadorismo",
       y = "densidade",
       caption = "Elaborado pelos autores a partir do banco NES") +
  theme(axis.text.x = element_text(angle = 45)) #mudando texto eixo x

