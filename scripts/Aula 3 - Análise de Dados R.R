###Aula 3 da disciplina Análise de Dados - PPGCP UFPE 2021.1. Aula Gráficos###

library(tidyverse)
library(poliscidata)

banco <- nes


#aes abreviação de aesthetic, estatica do gráfico
#geom para o tipo de geometria, nesse caso, de barra
#pode fazer sem o X =
ggplot(banco, aes(x = libcon3)) + 
  geom_bar()

#frequencia

ggplot(banco, aes(x = fct_infreq(libcon3))) + 
  geom_bar()

####

install.packages("scales")
library(scales)

#usando labels

ggplot(banco, aes(x = fct_infreq(libcon3), ..count../sum(..count..))) + 
  geom_bar() +
  scale_y_continuous(labels = percent)

#variavel numerica se representa com histograma
banco$obama_therm

ggplot(banco, aes(obama_therm)) +
  geom_histogram()


# utilizando bins

ggplot(banco, aes(obama_therm)) +
  geom_histogram(bins = 10)

# especificando intervalo em cada bin

ggplot(banco, aes(obama_therm)) +
  geom_histogram(binwidth = 10)

# density

ggplot(banco, aes(obama_therm)) +
  geom_density()

# usando o adjust

ggplot(banco, aes(obama_therm)) +
  geom_density(adjust = 10)

ggplot(banco, aes(obama_therm)) +
  geom_density(adjust = 0.1) #adjust menor detalha, pode ser 10,
#depende de como a gente acha que fica melhor a comunicação dos dados

# juntando tipos de graficos

ggplot(banco, aes(obama_therm)) +
  geom_density(adjust = 1) +  
  geom_histogram(aes(y = ..density..),
                 bins = 30)  

#boxplot

ggplot(banco, aes(obama_therm)) +
  geom_boxplot()


# violin

ggplot(banco, aes("",obama_therm)) +
  geom_violin(draw_quantiles = c(0.25, 0.5, 0.75))
