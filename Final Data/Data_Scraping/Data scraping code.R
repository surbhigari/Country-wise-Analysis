#Code for the scraped data 
#Site used was Worldometer
#Note : This data was scraped on October 6. Since then, the site has underwent some changes.
# The ordering of the countries in the main table that we extracted at that time has changed now, so running this code now may not create the same dataset as ours.

library(tidyverse)
library(rvest)

pop <- read_html("https://www.worldometers.info/world-population/population-by-country/")
pop_table <- html_table(pop) #extracting data in the form of tables
pop_codes <- pop %>% html_elements("table.table-striped.table-bordered a") %>% html_attr("href")
pop_links <- numeric(length = 235)
countries <- pop %>% html_elements(".table.table-striped.table-bordered a") %>% html_text()

#Manually removing some of the countries with missing information
#Note : This is the part which will create some problems while scraping the updated site.
countries <- countries[c(-4,-20,-25,-28,-32,-41,-48,-49,-55,-58,-60,-61,-64,-66,-72,-79,-81,-94,-103,-105,-106,-107,-114,-117,-118,-129,-148,-176,-179,-190,-192,-198,-211,-219,-224)]

#obtaining links for each individual page 
for (i in 1:235)
{
  print(paste("starting country",i))
  pop_links[i] <- paste("https://www.worldometers.info",pop_codes[i],sep="")
  html <- read_html(pop_links[i])
}
pop_links <- pop_links[c(-4,-20,-25,-28,-32,-41,-48,-49,-55,-58,-60,-61,-64,-66,-72,-79,-81,-94,-103,-105,-106,-107,-114,-117,-118,-129,-148,-176,-179,-190,-192,-198,-211,-219,-224)]
pop_tables <- list(length = 200)
for (i in 1:200)
{
  print(paste("starting country",i))
  pop_html <- read_html(pop_links[i])
  pop_tables[[i]] <- pop_html %>% html_table()
}

#creating different matrices
population <- matrix(0, nrow = 18, ncol = 200)
median_age <- matrix(0, nrow = 18, ncol = 200)
fertility_rate <- matrix(0, nrow= 18, ncol = 200)
density <- matrix(0, nrow = 18, ncol =200)
urban_pop <- matrix(0, nrow = 18, ncol = 200)
country_share <- matrix(0, nrow = 18, ncol = 200)
pop_forecast <- matrix(0, nrow = 7, ncol = 200)

for (i in 1:200)
{
  pop <- as.integer(str_remove_all(pop_tables[[i]][[2]]$Population, "[, ]"))
  population[,i] <- pop
  median_age[,i] <- pop_tables[[i]][[2]]$`Median Age`
  fertility_rate[,i] <- pop_tables[[i]][[2]]$`Fertility Rate`
  dens <- as.integer(pop_tables[[i]][[2]]$`Density (P/Km²)`)
  density[,i] <- dens
  urban <- as.integer(str_remove_all(pop_tables[[i]][[2]]$`Urban Population`, "[, ]" ))
  urban_pop[,i] <- urban 
  share <- as.numeric(str_remove_all(pop_tables[[i]][[2]]$`Country's Share of World Pop`, "[% ]"))
  country_share[,i] <- share
  forecast <- as.integer(str_remove_all(pop_tables[[i]][[3]]$Population,"[, ]"))
  pop_forecast[,i] <- forecast
  
} 

colnames(population) <- countries
rownames(population) <- c(1955, 1960, 1965, 1970, 1975, 1980, 1985, 1990, 1995, 2000, 2005, 2010, 2015, 2016, 2017, 2018, 2019, 2020)
colnames(median_age) <- countries
rownames(median_age) <- c(1955, 1960, 1965, 1970, 1975, 1980, 1985, 1990, 1995, 2000, 2005, 2010, 2015, 2016, 2017, 2018, 2019, 2020)
colnames(fertility_rate) <- countries
rownames(fertility_rate) <- c(1955, 1960, 1965, 1970, 1975, 1980, 1985, 1990, 1995, 2000, 2005, 2010, 2015, 2016, 2017, 2018, 2019, 2020)
colnames(density) <- countries
rownames(density) <- c(1955, 1960, 1965, 1970, 1975, 1980, 1985, 1990, 1995, 2000, 2005, 2010, 2015, 2016, 2017, 2018, 2019, 2020)
colnames(urban_pop) <- countries
rownames(urban_pop) <- c(1955, 1960, 1965, 1970, 1975, 1980, 1985, 1990, 1995, 2000, 2005, 2010, 2015, 2016, 2017, 2018, 2019, 2020)
colnames(country_share) <- countries
rownames(country_share) <- c(1955, 1960, 1965, 1970, 1975, 1980, 1985, 1990, 1995, 2000, 2005, 2010, 2015, 2016, 2017, 2018, 2019, 2020)
colnames(pop_forecast) <- countries
rownames(pop_forecast) <- c(2020,2025,2030,2035,2040,2045,2050)

#Manually inserting the data for India for the year 2020, as the data for this year was missing at the time of scraping.
#Note : It has now been updated.
population[1,200] <- 1380004385
urban_pop[1,200] <- 35
country_share[1,200] <- 17.7
density[1,200] <- 464
fertility_rate[1,200] <- 2.24
median_age[1,200] <- 28.4

save(pop_tables,file = "pop_tables1.Rdata")
save(pop_links,file = "pop_links1.Rdata")
save(population, file = "population.Rdata")
save(country_share,file = "countryshare.Rdata")
save(density, file = "density.Rdata")
save(fertility_rate,file = "fertilityrate.Rdata")
save(median_age,file = "medianage.Rdata")
save(urban_pop, file = "urbanpop.Rdata")

#Combining the matrices in a single dataframe.
country_wise <- data.frame("Country"= rep(colnames(population),each = 18),"years" = rep(rownames(population),200),"population" = c(population),"median_age"=c(median_age),"density"=c(density),"fertility_rate"=c(fertility_rate),"country_share"=c(country_share))
country_wise[3583,3] = 1396387127
save(country_wise, file = "country_wise_data.Rdata")

#creating another dataset for forecasted population
population_forecast <- data.frame("Country"= rep(colnames(pop_forecast),each = 7),"years" = rep(rownames(pop_forecast),200),"population" = c(pop_forecast))
population_forecast[1394,3] = 1396387127

save(population_forecast,file = "population_forecast.Rdata")


country_wise <- country_wise[-seq(1,3600,18),]
country_wise <- country_wise[,1:3]
c <- country_wise[order(country_wise$years),]
d <- population_forecast[order(population_forecast$years),]
e <- rbind(c,d)
population_data <- e[order(e$Country),]
save(population_data,file = "population_data.Rdata")



