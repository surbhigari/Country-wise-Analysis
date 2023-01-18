#Code for obtaining the last dataset (Expenditure of government in different sectors)
library(reshape2)
library(tidyverse)

mil <- read.csv("military_stacked.csv")
colnames(mil) <- c("country", seq(2000,2020,1))
mil[is.na(mil)] = 0
military <- melt(mil)
military <- military[!(military$country == "Solomon Islands"),]
military <- military %>% arrange(country)
colnames(military) <- c("country", "year", "military")

health <- read.csv("health_stacked.csv")
health[is.na(health)] = 0
colnames(health) <- c("country", seq(2000,2020,1))
health <- melt(health)
health <- health[!(health$country == "Solomon Islands"),]
health <- health %>% arrange(country)
colnames(health) <- c("country", "year", "health")

education <- read.csv("education_stacked.csv")
education[is.na(education)] = 0
colnames(education) <- c("country", seq(2000,2020,1))
education <- melt(education)
education <- education[!(education$country == "Solomon Islands"),]
education <- education %>% arrange(country)
colnames(education) <- c("country", "year", "education")


research <- read.csv("research development.csv")
colnames(research) <- c("country", seq(2000,2021,1))
research[is.na(research)] <- 0
research <- melt(research)
research <- research[!(research$country == "Solomon Islands"),]
research <- research %>% arrange(country)
colnames(research) <- c("country", "year", "research")


country <- data.frame(military, health$health, education$education,  research$research)
colnames(country) <- c("country", "year", "military", "health", "education",  "research")

save(country, file = "stackedbarplotdata.Rdata")
