#Code for obtaining second dataset 
#Loading the required csv files

install.packages("reshape2")
library(reshape2)

area <- read.csv("Area.csv")
gdp <- read.csv("GDP.csv")
gpi <- read.csv("Gender_parity_index.csv")
exp_edu <- read.csv("Government_expendeture_on_education.csv")
mortality <- read.csv("Mortalityper1000birth.csv")
popfemale <- read.csv("Population_female.csv")
popmale <- read.csv("Population_men.csv")
population <- read.csv("Population.csv")
poverty <- read.csv("poverty_rate.csv")
poprural <- read.csv("Rural_population.csv")
debt <- read.csv("Debt(%of_GDP).csv")
popurban <- read.csv("Urban_Population.csv")
unemp <- read.csv("unemployment.csv")
militaryexp <- read.csv("MilitiaryExp.csv")
lifeexp <- read.csv("lifeExpectancy.csv")

#retreiving all the country names
country <- population[1]


library(dplyr)
#manually removing some of the extra entries that weren't important
population <- population %>% slice(c(1,3,5:34,36,38:49,51:61,67:74,76:95,98,100:102,107,110,112,113:128,131:134, 138,139,142,144,145,146,149:153,
                                     155,156,159,160,161,162:181,183,185:191, 193,195,196,201:215,221,223:225,227,228,229,230,233:236,238,240,244:249,251,252,253,
                                     258,266))

exp_edu <- exp_edu %>% slice(c(1,3,5:34,36,38:49,51:61,67:74,76:95,98,100:102,107,110,112,113:128,131:134, 138,139,142,144,145,146,149:153,
                               155,156,159,160,161,162:181,183,185:191, 193,195,196,201:215,221,223:225,227,228,229,230,233:236,238,240,244:249,251,252,253,
                               258,266))

debt <- debt %>% slice(c(1,3,5:34,36,38:49,51:61,67:74,76:95,98,100:102,107,110,112,113:128,131:134, 138,139,142,144,145,146,149:153,
                         155,156,159,160,161,162:181,183,185:191, 193,195,196,201:215,221,223:225,227,228,229,230,233:236,238,240,244:249,251,252,253,
                         258,266))

gpi <- gpi %>% slice(c(1,3,5:34,36,38:49,51:61,67:74,76:95,98,100:102,107,110,112,113:128,131:134, 138,139,142,144,145,146,149:153,
                       155,156,159,160,161,162:181,183,185:191, 193,195,196,201:215,221,223:225,227,228,229,230,233:236,238,240,244:249,251,252,253,
                       258,266))

gdp <- gdp  %>% slice(c(1,3,5:34,36,38:49,51:61,67:74,76:95,98,100:102,107,110,112,113:128,131:134, 138,139,142,144,145,146,149:153,
                        155,156,159,160,161,162:181,183,185:191, 193,195,196,201:215,221,223:225,227,228,229,230,233:236,238,240,244:249,251,252,253,
                        258,266))

mortality <- mortality %>% slice(c(1,3,5:34,36,38:49,51:61,67:74,76:95,98,100:102,107,110,112,113:128,131:134, 138,139,142,144,145,146,149:153,
                                   155,156,159,160,161,162:181,183,185:191, 193,195,196,201:215,221,223:225,227,228,229,230,233:236,238,240,244:249,251,252,253,
                                   258,266))
poverty<- poverty %>% slice(c(1,3,5:34,36,38:49,51:61,67:74,76:95,98,100:102,107,110,112,113:128,131:134, 138,139,142,144,145,146,149:153,
                              155,156,159,160,161,162:181,183,185:191, 193,195,196,201:215,221,223:225,227,228,229,230,233:236,238,240,244:249,251,252,253,
                              258,266))
popfemale <-popfemale  %>% slice(c(1,3,5:34,36,38:49,51:61,67:74,76:95,98,100:102,107,110,112,113:128,131:134, 138,139,142,144,145,146,149:153,
                                   155,156,159,160,161,162:181,183,185:191, 193,195,196,201:215,221,223:225,227,228,229,230,233:236,238,240,244:249,251,252,253,
                                   258,266))
poprural<-poprural %>% slice(c(1,3,5:34,36,38:49,51:61,67:74,76:95,98,100:102,107,110,112,113:128,131:134, 138,139,142,144,145,146,149:153,
                               155,156,159,160,161,162:181,183,185:191, 193,195,196,201:215,221,223:225,227,228,229,230,233:236,238,240,244:249,251,252,253,
                               258,266))
popmale<- popmale %>% slice(c(1,3,5:34,36,38:49,51:61,67:74,76:95,98,100:102,107,110,112,113:128,131:134, 138,139,142,144,145,146,149:153,
                              155,156,159,160,161,162:181,183,185:191, 193,195,196,201:215,221,223:225,227,228,229,230,233:236,238,240,244:249,251,252,253,
                              258,266))

country <- country %>% slice(c(1,3,5:34,36,38:49,51:61,67:74,76:95,98,100:102,107,110,112,113:128,131:134, 138,139,142,144,145,146,149:153,
                               155,156,159,160,161,162:181,183,185:191, 193,195,196,201:215,221,223:225,227,228,229,230,233:236,238,240,244:249,251,252,253,
                               258,266))

area <- area %>% slice(c(1,3,5:34,36,38:49,51:61,67:74,76:95,98,100:102,107,110,112,113:128,131:134, 138,139,142,144,145,146,149:153,
                         155,156,159,160,161,162:181,183,185:191, 193,195,196,201:215,221,223:225,227,228,229,230,233:236,238,240,244:249,251,252,253,
                         258,266))
militaryexp <- militaryexp %>% slice(c(1,3,5:34,36,38:49,51:61,67:74,76:95,98,100:102,107,110,112,113:128,131:134, 138,139,142,144,145,146,149:153,
                                       155,156,159,160,161,162:181,183,185:191, 193,195,196,201:215,221,223:225,227,228,229,230,233:236,238,240,244:249,251,252,253,
                                       258,266))


popurban<- popurban %>% slice(c(1,3,5:34,36,38:49,51:61,67:74,76:95,98,100:102,107,110,112,113:128,131:134, 138,139,142,144,145,146,149:153,
                                155,156,159,160,161,162:181,183,185:191, 193,195,196,201:215,221,223:225,227,228,229,230,233:236,238,240,244:249,251,252,253,
                                258,266))

unemp <-unemp %>% slice(c(1,3,5:34,36,38:49,51:61,67:74,76:95,98,100:102,107,110,112,113:128,131:134, 138,139,142,144,145,146,149:153,
                          155,156,159,160,161,162:181,183,185:191, 193,195,196,201:215,221,223:225,227,228,229,230,233:236,238,240,244:249,251,252,253,
                          258,266))

lifeexp <- lifeexp %>% slice(c(1,3,5:34,36,38:49,51:61,67:74,76:95,98,100:102,107,110,112,113:128,131:134, 138,139,142,144,145,146,149:153,
                               155,156,159,160,161,162:181,183,185:191, 193,195,196,201:215,221,223:225,227,228,229,230,233:236,238,240,244:249,251,252,253,
                               258,266))


#creating individual matrices for columns
datarr1 <- matrix(0,nrow=198,ncol=27 )
datarr2 <- matrix(0,nrow = 198,ncol = 27 )
datarr3 <-  matrix(0,nrow = 198,ncol = 27 )
datarr4 <-  matrix(0,nrow = 198,ncol = 27 )
datarr5 <-  matrix(0,nrow = 198,ncol = 27 )
datarr6 <-  matrix(0,nrow = 198,ncol = 27 )
datarr7 <-  matrix(0,nrow = 198,ncol = 27 )
datarr8 <-  matrix(0,nrow = 198,ncol = 27 )
datarr9 <-  matrix(0,nrow = 198,ncol = 27 )
datarr10 <-  matrix(0,nrow = 198,ncol = 27 ) 
data11 <- area[2]
datarr12 <- matrix(0,nrow = 198,ncol = 27 )
datarr13 <- matrix(0,nrow = 198,ncol = 27 )
datarr14 <- matrix(0,nrow = 198,ncol = 27 )
datarr15 <- matrix(0,nrow = 198,ncol = 27 )

for(i in 3:29)   
{for(j in 1:198)
{datarr1[j,i-2] <- population[j,i]
datarr2[j,i-2] <- popmale[j,i] 
datarr3[j,i-2] <- popfemale[j,i]
datarr4[j,i-2] <- poprural[j,i]
datarr5[j,i-2] <- poverty[j,i] 
datarr6[j,i-2] <- mortality[j,i]
datarr7[j,i-2] <- gdp[j,i] 
datarr8[j,i-2] <- gpi[j,i]
datarr9[j,i-2] <- exp_edu[j,i]
datarr10[j,i-2]<- debt[j,i]
datarr12[j,i-2]<- popurban[j,i-1]
datarr13[j,i-2]<- unemp[j,i-1]
datarr14[j,i-2]<- militaryexp[j,i-1]
datarr15[j,i-2]<- lifeexp[j,i-1]

}}


country <- population[1]

#arranging all the matrices together

datarr <- array(0,dim = c(198,14,27) )
for(i in 3:29)   
{for(j in 1:198)
{datarr[j,1,i-2] <- population[j,i]
datarr[j,2,i-2] <- popmale[j,i] 
datarr[j,3,i-2] <- popfemale[j,i]
datarr[j,4,i-2] <- poprural[j,i]
datarr[j,5,i-2] <- poverty[j,i] 
datarr[j,6,i-2] <- mortality[j,i]
datarr[j,7,i-2] <- gdp[j,i] 
datarr[j,8,i-2] <- gpi[j,i]
datarr[j,9,i-2] <- exp_edu[j,i]
datarr[j,10,i-2]<- debt[j,i]
datarr[j,9,i-2] <- popurban[j,i-1]
datarr[j,9,i-2] <- unemp[j,i-1]
datarr[j,9,i-2] <- militaryexp[j,i-1]
datarr[j,9,i-2] <- lifeexp[j,i-1]

}}



data1 <- data.frame(country,area[2],datarr)

coun <- vector(mode="character", length= 5346)
for(i in 1:198)
{
  for(j in (27*(i - 1) + 1):(27*i))
  { k = as.character(country[i,1])
  coun[j] = k
  }
}


count = 1
year = vector(mode="integer", length = 5346)
for(i in 1:198)
{ k= 1995:2021
for(j in (27*(i - 1) + 1):(27*i))
{ if(count >27)
{
  count = 1
}
  year[j] = k[count]
  count = count + 1
  
}
}


c = 3
dat <- matrix(NA, nrow = 5346, ncol = 16)
for(i in 1:198)
{ 
  for(j in (27*(i - 1) + 1):(27*i))
  { if(c>29)
  {
    c = 3
  }
    
    dat[j,1] <- population[i,c]/var(population[,c])
    dat[j,2] <- popmale[i,c]/var(popmale[,c]) 
    dat[j,3] <- popfemale[i,c]/var(popfemale[,c])
    dat[j,4] <- poprural[i,c]/var(poprural[,c])
    dat[j,5] <- poverty[i,c]/var(poverty[,c])
    dat[j,6] <- mortality[i,c]/var(mortality[,c])
    dat[j,7] <- gdp[i,c] /var(gdp[,c])
    dat[j,8] <- gpi[i,c]/var(gpi[ ,c])
    dat[j,9] <- exp_edu[i,c]/var(exp_edu[,c])
    dat[j,10]<- debt[i,c]/var(debt[,c])
    dat[j,11] <- area[i,2]/var(area[ ,2])
    dat[j,12] <- (population[i,c]/area[i,2])/var(population[ ,c]/area[,2])
    dat[j,13] <- popurban[i,c-1]/var(popurban[ ,c-1])
    dat[j,14] <- unemp[i,c-1]/var(unemp[ ,c-1])
    dat[j,15] <- militaryexp[i,c-1]/var(militaryexp[ ,c-1])
    dat[j,16] <- lifeexp[i,c-1]/var(lifeexp[ ,c-1])
    c = c + 1
  }
}


Normalised_data <- data.frame(coun,year,dat)
colnames(Normalised_data) <- c("country","year","population","male_population","female_population", "rural_population","poverty","mortality","GDP","GPI","Expendeture_on_education","Debt","Area","Population_Density",
                               "Urban_Population","Unemployment","Military_Expenditure","Life_Expectancy")

vec = vector(mode="character",length = 379)
vec[1] = "country"
vec[2] = "Area"
for(i in 1:27)
{ y = as.character(1994 + i)

n = paste("population",y,sep = "")
vec[10*(i-1) + 3] = n
n = paste("male_population",y,sep = "")
vec[10*(i-1) + 4] = n
n = paste("female_population",y, sep = "")
vec[10*(i-1) + 5] = n
n = paste("rural_population",y,sep = "")
vec[10*(i-1) + 6] = n
n = paste("poverty",y,sep = "")
vec[10*(i-1) + 7] = n
n = paste("mortality",y,sep ="")
vec[10*(i-1) + 8] = n
n = paste("GDP",y,sep ="")
vec[10*(i-1) + 9] = n
n = paste("GPI",y,sep ="")
vec[10*(i-1) + 10] = n
n = paste("Expenditure_on _education",y,sep ="")
vec[10*(i-1) + 11] = n
n = paste("Debt",y,sep ="")
vec[10*(i-1) + 12] = n
n = paste("Urban_Population",y,sep ="")
vec[10*(i-1) + 13] = n
n = paste("Unemployment",y,sep ="")
vec[10*(i-1) + 14] = n
n = paste("Military_Expenditure",y,sep ="")
vec[10*(i-1) + 15] = n
n = paste("",y,sep ="Life_Expectancy")
vec[10*(i-1) + 16] = n

}

colnames(data1) <- vec





coun <- vector(mode="character", length= 5346)
for(i in 1:198)
{
  for(j in (27*(i - 1) + 1):(27*i))
  { k = as.character(country[i,1])
  coun[j] = k
  }
}


count = 1
year = vector(mode="integer", length = 5346)
for(i in 1:198)
{ k= 1995:2021
for(j in (27*(i - 1) + 1):(27*i))
{ if(count >27)
{
  count = 1
}
  year[j] = k[count]
  count = count + 1
  
}
}


c = 3
dat <- matrix(NA, nrow = 5346, ncol = 16)
for(i in 1:198)
{ 
  for(j in (27*(i - 1) + 1):(27*i))
  { if(c>29)
  {
    c = 3
  }
    
    dat[j,1] <- population[i,c]
    dat[j,2] <- popmale[i,c] 
    dat[j,3] <- popfemale[i,c]
    dat[j,4] <- poprural[i,c]
    dat[j,5] <- poverty[i,c] 
    dat[j,6] <- mortality[i,c]
    dat[j,7] <- gdp[i,c] 
    dat[j,8] <- gpi[i,c]
    dat[j,9] <- exp_edu[i,c]
    dat[j,10]<- debt[i,c]
    dat[j,11] <- area[i,2]
    dat[j,12] <- population[i,c]/area[i,2]
    dat[j,13] <- popurban[i,c-1]
    dat[j,14] <- unemp[i,c-1]
    dat[j,15] <- militaryexp[i,c-1]
    dat[j,16] <- lifeexp[i,c-1]
    c = c + 1
  }
}


data2 <- data.frame(coun,year,dat)
colnames(data2) <- c("country","year","population","male_population","female_population", "rural_population","poverty","mortality","GDP","GPI","Expendeture_on_education","Debt","Area","Population_Density",
                     "Urban_Population","Unemployment","Military_Expenditure","Life_Expectancy")


save(data2, file = "data2.Rdata")
save(data1, file = "data1.Rdata")



library(dplyr)
library(tidyverse)

data2 <- data2 %>% dplyr::arrange(as.character(country))
data2 <- data2 %>% filter(year %in% seq(2000,2020,1))
data2 <- data2 %>% dplyr::select(-Expendeture_on_education, -Debt, -Area)
#adding some more variables to the previous dataframe
unemployment <- read.csv("unemploy.csv")
unemployment <- unemployment %>% select(-World.Development.Indicators, -X, -X.1, -X2021)
unemployment <- unemployment[!(unemployment$Data.Source == "Czechia"),]
colnames(unemployment) <- c("country", seq(2000,2020,1))
unemployment <- melt(unemployment) 
unemployment <- unemployment %>% arrange(country)
colnames(unemployment) <- c("country","year","unemployment")
data2 <- data2 %>% filter(country %in% unemployment$country) 
data2 <- data.frame(data2, unemployment$unemployment)


education <- read.csv("primaryedu.csv")
colnames(education) <- c("country", seq(2000,2021,1))
education <- education %>% filter(country %in% data2$country)
education <- education[,1:22]
education <- melt(education)
edu <- education %>% arrange(country)
colnames(edu) <- c("country","year","education")
data2 <- data.frame(data2, edu$education)

f <- read.csv("expectancy.csv")
f <- f %>% arrange(country)
f <- f %>% filter(country %in% data2$country)
f <- f %>% filter(year %in% seq(2000, 2020,1))
data2 <- data.frame(data2, f$Urban.Population, f$Life.Expectancy)

data2 <- data.frame(data2$country,data2$year,data2$population, data2$male_population, data2$female_population, data2$rural_population, data2$poverty, data2$mortality, data2$GDP, data2$GPI, data2$Population_Density, data2$f.Urban.Population, data2$f.Life.Expectancy, data2$unemployment.unemployment, data2$edu.education)
colnames(data2) <- c("country", "year", "population", "male_population", "female_population", "rural_population", "poverty", "mortality", "GDP", "GPI", "Population_Density", "Urban_population", "Life_expectancy", "Unemployment", "Education")
pov_edu <- read.csv("pov_edu.csv")
data2['poverty'] <- pov_edu['poverty']
data2['Education'] <- pov_edu['Education']

#making the final dataset 
heatm <- data2
save(heatm ,file = "final_heatmap_dataset.Rdata") #this is the final dataset that we've used primarily.


#creating dataset for correlation heatmap.
cor <- heatm %>% dplyr::select(-male_population, -female_population, -GPI, -mortality)
cor <- cor %>% filter(year %in% seq(2015,2020,1))
cor <- na.omit(cor)
save(cor, file = "final_correlatedheatmap_dataset.Rdata")
