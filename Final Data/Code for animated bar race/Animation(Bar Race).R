library(tidyverse)
install.packages("gganimate")
install.packages("gifski")
library(gganimate)
library(gifski)

#Animated bar graph race till the year 2020
load("country_wise_data.Rdata")
gdp_tidy <- country_wise

gdp_formatted <- gdp_tidy %>%
  group_by(years) %>% 
  mutate(rank = rank(-population),
         Value_rel = population/population[rank == 1],
         Value_lbl = paste0(" ",round(population))) %>%
  group_by(Country) %>%
  filter(rank <= 20) %>%
  ungroup()

staticplot = ggplot(gdp_formatted, aes(rank, group = Country,
                                       fill = as.factor(Country), color = as.factor(Country))) +
  geom_tile(aes(y = population/2,
                height = population,
                width = 0.9), alpha = 0.8, color = NA) +
  geom_text(aes(y = 0, label = paste(Country, " ")), vjust = 0.2, hjust = 1) +
  geom_text(aes(y = population,label = Value_lbl, hjust=0)) +
  coord_flip(clip = "off", expand = FALSE) +
  scale_y_continuous(labels = scales::comma) +
  scale_x_reverse() +
  guides(color = "none", fill = "none") +
  theme(axis.line = element_blank(),
        axis.text.x = element_blank(),
        axis.text.y = element_blank(),
        axis.ticks = element_blank(),
        axis.title.x = element_blank(),
        axis.title.y = element_blank(),
        legend.position = "none",
        panel.background = element_blank(),
        panel.border = element_blank(),
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        panel.grid.major.x = element_line( size = .1, color = "grey" ),
        panel.grid.minor.x = element_line( size = .1, color = "grey" ),
        plot.title  = element_text(size=25, hjust = 0.5, face = "bold", colour = "grey", vjust = -1),
        plot.subtitle = element_text(size = 18, hjust = 0.5, face = "italic", color = "grey"),
        plot.caption = element_text(size = 8, hjust = 0.5, face = "italic", color = "grey"),
        plot.background = element_blank(),
        plot.margin = margin(2, 2, 2, 4, "cm"))

anim = staticplot + transition_states(years, transition_length = 4, state_length = 1) +
  view_follow(fixed_x = TRUE)  +
  labs(title = 'Population per 5 Year : {closest_state}',
       subtitle = "Top 20 Countries",
       caption = "Population | Data Source: Worldometer")

animate(anim, 200, fps = 10,  width = 1200, height = 1000,
        renderer = gifski_renderer("gganim1.gif"))

#Animated bar graph race for future years (based on forecasted population figures)

library(tidyverse)
library(gganimate)
library(gifski)

load("population_forecast.Rdata")
gdp_tidy <- population_forecast

gdp_formatted <- gdp_tidy %>%
  group_by(years) %>%
  mutate(rank = rank(-population),
         Value_rel = population/population[rank==1],
         Value_lbl = paste0(" ",round(population))) %>%
  group_by(Country) %>%
  filter(rank <=20) %>%
  ungroup()

staticplot = ggplot(gdp_formatted, aes(rank, group = Country,
                                       fill = as.factor(Country), color = as.factor(Country))) +
  geom_tile(aes(y = population/2,
                height = population,
                width = 0.9), alpha = 0.8, color = NA) +
  geom_text(aes(y = 0, label = paste(Country, " ")), vjust = 0.2, hjust = 1) +
  geom_text(aes(y=population,label = Value_lbl, hjust =0)) +
  coord_flip(clip = "off", expand = FALSE) +
  scale_y_continuous(labels = scales::comma) +
  scale_x_reverse() +
  guides(color = FALSE, fill = FALSE) +
  theme(axis.line=element_blank(),
        axis.text.x=element_blank(),
        axis.text.y=element_blank(),
        axis.ticks=element_blank(),
        axis.title.x=element_blank(),
        axis.title.y=element_blank(),
        legend.position="none",
        panel.background=element_blank(),
        panel.border=element_blank(),
        panel.grid.major=element_blank(),
        panel.grid.minor=element_blank(),
        panel.grid.major.x = element_line( size=.1, color="grey" ),
        panel.grid.minor.x = element_line( size=.1, color="grey" ),
        plot.title = element_text(size=25, hjust=0.5, face="bold", colour="grey", vjust=-1),
        plot.subtitle = element_text(size=18, hjust=0.5, face="italic", color="grey"),
        plot.caption = element_text(size=8, hjust=0.5, face="italic", color="grey"),
        plot.background = element_blank(),
        plot.margin = margin(2,2, 2, 4, "cm"))

anim = staticplot + transition_states(years, transition_length = 4, state_length = 1) +
  view_follow(fixed_x = TRUE)  +
  labs(title = 'Population per  5 Year : {closest_state}',
       subtitle  =  "Top 20 Countries",
       caption  = "Population | Data Source: Worldometer")

animate(anim, 200, fps = 15,  width = 1200, height = 1000,
        renderer = gifski_renderer("gganim2.gif"))



