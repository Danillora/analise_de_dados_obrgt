#Aula 2 - Analise de Dados - Manipulação de Banco de Dados

install.packages("tidyverse")
library(tidyverse)

install.packages("poliscidata")
library(poliscidata)

banco <- gss

#Ver primeiras linhas do banco, sumário e final do banco respectivamente (funcoes base R)
head(banco)
summary (banco)
tail(banco)

#Ver mostra info do banco de dados (comando do tidyverse, CRAN R)
glimpse(banco)

######################################################
# %>% pipe - selecionando variaveis do banco

banco_selecionado <- banco %>% 
  select(age, born, degree, sex, authoritarianism)

#selecionando colunas começam com ab
banco_selecionado <- banco %>%
  select(starts_with("ab"))

#######################################################
#selecionando linhas
## dois = para filtrar

banco_filtrado$born
summary(banco_filtrado$born)

banco_filtrado <- banco %>%
  filter(born == "YES",
         sex == "Female",
         age > 30)
    
########################################################
#adicionando ano de nascimento das pessoas que responderam a pesquisa (gss)

banco_adicionado <- banco %>%
  mutate(ano_nascimento = 2012 - age)

########################################################
#renomeando a variavel

banco_renomeado <- banco %>%
  rename(voto_presidencial = pres08)

banco_renomearo <- banco %>%
  select(age, born, degree, sex, authoritarianism,
         voto_presidencial = pres08)
  
########################################################

banco$polviews

banco_recodificado <- banco %>%
  mutate(polviews = recode(polviews,
                           ExtremLib = "Extremely Liberal",
                           SlghtLib = "Slightly Liberal",
                           SlghtCons = "Slightly Conservative",
                           Conserv = "Conservative",
                           ExtremCons = "Extremely Conservative"))

#para ver como ficou
banco_recodificado$polviews

########
#~significa "entao"

#modificando variavel e alterando numero para texto
banco_recodificado <- banco %>%
  mutate(age = case_when(age <20 ~ "Menos de 20",
                         age >= 20 & age < 30 ~ "De 20 a 29",
                         age >= 30 & age < 40 ~ "De 30 a 39",
                         age >= 40 & age < 50 ~ "De 40 a 49",
                         age >= 50 & age < 60 ~ "De 50 a 59",
                         age >= 60 ~ "Idoso"))

banco_recodificado$age
banco$age

###################################

banco_novo <- banco %>%
  select(age, born, degree, sex, authoritarianism, polviews, pres08) %>%
  filter(born == "YES") %>%
  mutate(ano_nascimento = 2012 - age,
         polviews  = recode(polviews,
                            ExtrmLib = "Extremely Liberal",
                            SlghtLib = "Slightly Liberal",
                            SlghtCons = "Slightly Conservative",
                            Conserv = "Conservative",
                            ExtremCons = "Extremely Conservative")) %>%
  rename(voto_presidencial = pres08)

###########################################################

banco_novo$degree
###### para mostrar as categorias do degree (com variavel categorica, variavel numero nao)
banco_novo %>%
  count(degree)

#######
#vendo o grau de educacao e o grau de autoritarismo das pessoas

banco_novo %>%
  summarise(media = mean(authoritarianism, na.rm = T),
            mediana = median(authoritarianism, na.rm = T),
            desvio_padrao = sd(authoritarianism, na.rm = T),
            minimo = min(authoritarianism, na.rm = T),
            maximo = max(authoritarianism, na.rm = T))

banco_novo %>%
  group_by(degree) %>%
  summarise(media = mean(authoritarianism, na.rm = T),
            mediana = median(authoritarianism, na.rm = T),
            desvio_padrao = sd(authoritarianism, na.rm = T),
            maximo = max(authoritarianism, na.rm = T))


