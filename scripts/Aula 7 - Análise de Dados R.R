library(poliscidata)
library(tidyverse)

banco <- nes

summary(banco$polknow_combined)

regressao <- lm(obama_therm ~ conservatism,
                data = banco)

summary(regressao)

confint(regressao)

regressao <- lm(obama_therm ~ conservatism + polknow_combined,
                data = banco)

summary(regressao)

library(sjPlot)

plot_model(regressao, type = "std")

regressao2 <- lm(obama_therm ~ conservatism + polknow_combined + gender,
                 data = banco)

summary(regressao2)


ggplot(banco, aes(conservatism, obama_therm))+
  geom_jitter(apha = 0.1) +
  geom_smooth(method = "lm")

# para mudar a categoria de referencia, categoria codificada como 0, precisa-se mudar a ordem do fator, fct_relevel().

banco2 <- banco %>% 
  mutate(gender = fct_relevel(gender, "Female"))


regressao3 <- lm(obama_therm ~ conservatism + polknow_combined + gender, banco2)
summary(regressao3)

regressao4 <- lm(obama_therm ~ conservatism + polknow_combined + gender + dem_raceeth, banco)
summary(regressao4)

#Interpretação: Os betas das categorias imprimem uma aumento(diminuição) da média da VD em relação à categoria de referência.
# O p-valor dá a significência da diferença entre a categoria de referência e a categoria analisada.

plot_model(reg4)

#####

banco2 <- banco %>% 
  mutate(dem_raceeth = fct_relevel(dem_raceeth, "3. Hispanic"))

regressao5 <- lm(obama_therm ~ conservatism + polknow_combined + gender + dem_raceeth, banco2)
summary(regressao5)

plot_model(regressao5)

library(moderndive)

ggplot(banco, aes(conservatism, obama_therm))+
  geom_jitter(apha = 0.1) +
  geom_parallel_slopes(aes(color=gender), se = F)


ggplot(banco, aes(conservatism, obama_therm))+
  geom_jitter(apha = 0.1) +
  geom_parallel_slopes(aes(color=dem_raceeth), se = F)

###########

regressao_interacao <- lm(obama_therm ~ conservatism + polknow_combined + gender + dem_raceeth + conservatism * gender, banco)
summary(regressao_interacao)

plot_model(regressao_interacao, type = "pred", # Type apresenta os valorer ´preditos da regressão para VD
           terms = c("conservatism", "gender"), # variaveis interagindo, numerica antes de categorica
           banco)


# Interação: numérica e numérica

regressao_interacao2 <- lm(obama_therm ~ conservatism + polknow_combined + gender + dem_raceeth + conservatism * polknow_combined, banco)
summary(regressao_interacao2)

# Interação: categórica e categórica

regressao_interacao3 <- lm(obama_therm ~ conservatism + polknow_combined + gender + dem_raceeth + gender * dem_raceeth, banco)
summary(regressao_interacao3)


plot_model(regressao_interacao3, type = "pred", # Type apresenta os valorer ´preditos da regressão para VD
           terms = c("gender", "dem_raceeth"), # variaveis interagindo, numerica antes de categorica
           banco)

plot_model(regressao_interacao3, type = "pred", # Type apresenta os valorer ´preditos da regressão para VD
           terms = c("dem_raceeth", "gender"), # variaveis interagindo, numerica antes de categorica
           banco)

#OBS: Parte desse script foi contribuição das anotações de Letícia Souza