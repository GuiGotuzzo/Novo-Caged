library("readxl")
library("dplyr")
library("ggplot2")
library("rstudioapi")

#Define o diretório de trabalho como o diretório onde o script está localizado
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))

data <- read_excel("tabela.xlsx", sheet = 8)

meses <- data %>%
  slice(45:57)%>%
  select(Meses = 1)

vetor_meses <- meses %>% #Transforma o DataSet "meses" em vetor
  pull(Meses)

saldo <- data %>%
  slice(45:57) %>%
  select(Meses = 1, Numeros = 5) %>%
  mutate(Meses = factor(Meses, levels = vetor_meses))

grafico <- ggplot(saldo, aes(x = Meses, y = Numeros)) +
  geom_bar(stat = "identity", fill = "steelblue") +
  labs(x = "Meses", y = "Números", title = "Saldo 06/23 - 06/24 (Admissões - Desligamentos = Saldo)") +
  theme_minimal() +
  geom_hline(yintercept = 0, color = "black") 

print(grafico)
