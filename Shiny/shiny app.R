#### Libraries used in shiny app
install.packages("shiny")
install.packages("shinydashboard")
install.packages("shinycssloaders")
install.packages("shinyjs")
install.packages("DT")
install.packages("gganimate")
install.packages("gifski")
install.packages("reshape2")
install.packages("heatmaply")
install.packages("plotly")
install.packages("hrbrthemes")
library(shiny)
library(shinydashboard)
library(shinycssloaders)
library(shinyjs)
library(DT)
library(tidyverse)
library(gganimate)
library(gifski)
library(reshape2)
library(heatmaply)
library(plotly)
library(hrbrthemes)

##  loading Data

load("population_data.Rdata")
load("final_heatmap_dataset.Rdata")
load("final_correlatedheatmap_dataset.Rdata")
load("stackedbarplotdata.Rdata")


## ui Of shiny app

ui <- dashboardPage(skin = "blue",
                    dashboardHeader(title = "Country Wise Analysis  ", titleWidth = 500),
                    dashboardSidebar(
                      sidebarMenu(
                        id = "tabs",
                        menuItem("Introduction", tabName = "home"),
                        menuItem("Heatmap/Correlation", icon = icon("map"),tabName = "data_set1"),
                        menuItem("Multiple Line Chart", icon = icon("line-chart"),tabName = "data_set2"),
                        menuItem("Stack Bar Chart", icon = icon("bar-chart"),tabName = "data_set3")
                      )),
                    dashboardBody(skin = "blue",
                                  shinyjs::useShinyjs(),
                                  tabItems( 
                                    tabItem(tabName = "home",
                                            column(width = 8,
                                                   status ="primary", 
                                                   h2("Bar Chart Race of Total population (1955-2050)"),
                                                   p("-Bar chart Race shows the Race between the countrys according to their population"),
                                                   p("-As China is top most  populated country in the world, as per future estimate India will be top most population country by year 2030 "),
                                                   withSpinner(imageOutput("plot1")))
                                            
                                    ),
                                    tabItem(tabName = "data_set1",
                                            fluidRow(                  
                                              tabBox(
                                                id = "tabset1",
                                                tabPanel("Heat map", 
                                                         div(style = "display:inline-block; vertical-align: top; padding-left: 30px;",selectInput(inputId = "country_select1", label = "Select Countries: ", choices = heatm$country, selected = c("India","Pakistan","Japan","China","United States"),multiple = TRUE), width = "500"),
                                                         div(style = "display:inline-block; vertical-align: 60px;",selectInput(inputId = "year_select1", label = "Year: ", choices = heatm$year, selected = "2016")), br(),
                                                         withSpinner((plotlyOutput("plot2")))
                                                         
                                                ),
                                                tabPanel("correlation",
                                                         div(style = "display:inline-block;",selectInput(inputId = "country_select2", label = "Select Country :" ,choices =  cor$country, selected = "India")),br(),br(),br(),
                                                         withSpinner((plotlyOutput("plot3"))))
                                                
                                              ))),
                                    tabItem(tabName = "data_set2",
                                            box( title = " Multiple Line Graph",solidHeader = TRUE,status ="primary",collapsible = TRUE,
                                                 column(width = 6,selectInput(inputId = "country_select3", label = "Select Countries: ", choices = heatm$country, multiple = TRUE,selected = c("India","Pakistan","Japan","China","United States") )),
                                                 column(width = 4,selectInput(inputId = "Variable_select", label = "Variable: ", choices = colnames(heatm[3:15]),selected = "GDP")),br(),br(),br(),br(),br(),br(),br(),
                                                 withSpinner(plotlyOutput("plot4")), width = 7)
                                            
                                    ),
                                    tabItem(tabName = "data_set3",
                                            box( title = "Stack Bar Graph",solidHeader = TRUE,status ="primary",collapsible = TRUE,
                                                 column(width = 6,selectInput(inputId = "country_select4", label = "Select Countries: ", choices = country$country, multiple = TRUE,selected = c("India","Pakistan","Japan","China","United States"))),
                                                 column(width = 4,selectInput(inputId = "year_select2", label = "Year: ", choices = country$Years, selected = "2007")),br(),br(),br(),br(),br(),br(),br(),
                                                 withSpinner(plotlyOutput("plot5")), width = 7))
                                    
                                  ))
)
#server of shiny app
server <- function(input, output,session)
{
  
  ####  animated Graph of population 
  output$plot1 <- renderImage({
    
    pop_tidy <- population_data
    
    pop_formatted <- pop_tidy %>%
      group_by(years) %>% 
      mutate(rank = rank(-population),
             Value_rel = population / population[rank == 1],
             Value_lbl = paste0(" ", round(population))) %>%
      group_by(Country) %>%
      filter(rank <= 20) %>%
      ungroup()
    outfile <- tempfile(fileext='.gif')
    
    staticplot = ggplot(pop_formatted, aes(rank, group = Country,
                                           fill = as.factor(Country), color = as.factor(Country))) +
      geom_tile(aes(y = population/2,
                    height = population,
                    width = 1), alpha = 2, color = NA) +
      geom_text(aes(y = 0, label = paste(Country, " ")), vjust = 0.2, hjust = 1) +
      geom_text(aes(y = population,label = Value_lbl, hjust=0)) +
      coord_flip(clip = "off", expand = FALSE) +
      scale_y_continuous(labels = scales::comma) +
      scale_x_reverse() +
      guides(color = "none", fill = "none") +
      hrbrthemes::theme_ipsum(plot_title_size = 32, subtitle_size = 24, caption_size = 20, base_size = 20) +
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
            plot.margin = margin(1.5, 3, 1.5, 3, "cm"))
    
    
    anim = staticplot + transition_states(years, transition_length = 4, state_length = 1) +
      view_follow(fixed_x = TRUE)  + ease_aes('cubic-in-out')+
      labs(title = 'Population per 5 Year : {closest_state}',
           subtitle = "Top 20 Countries",
           caption = "Population | Data Source: Worldometer")
    
    anim_save("outfile.gif", animate(anim,fps = 5),) 
    list(src = "outfile.gif",
         contentType = 'image/gif'
    )}, deleteFile = TRUE)
  
  #### Heat Map
  
  
  output$plot2 <- renderPlotly({
    data <- heatm %>% 
      filter(country %in% input$country_select1) %>%
      filter(year %in% input$year_select1) %>%
      arrange(country)
    
    mat <- data
    rownames(mat) <- mat[,1]
    mat <- mat %>% dplyr::select(-country, -year)
    
    heatmaply(mat,dendrogram = "none", 
              xlab = "factors", ylab = "Countrys", 
              main = "",
              scale = "column",
              margins = c(60,100,40,20),
              grid_color = "white",
              grid_width = 0.00001,
              titleX = FALSE,
              hide_colorbar = FALSE,
              branches_lwd = 0.1,
              label_names = c("Country", "Feature:", "Value"),
              fontsize_row = 5, fontsize_col = 5,
              labCol = colnames(mat),
              labRow = rownames(mat), 
              heatmap_layers = theme(axis.line=element_blank()))
  })  
  
  #### correlation matrix
  
  
  output$plot3 <- renderPlotly({
    data1 <- cor%>% filter(country %in% input$country_select2) %>% select(-country, -year)
    heatmaply_cor(x = cor(data1), xlab = "Features",
                  ylab = "Features", k_col = 2, k_row = 2,grid_color = "white",
                  grid_width = 0.0000001)
  })
  
  ####  line graph 
  
  output$plot4 <- renderPlotly({
    dat <- heatm %>% filter(country %in% input$country_select3)
    ggplot(dat,aes(x = year,y = dat[,input$Variable_select], color = country)) +
      geom_smooth(se = F)+labs(x="Years",y = input$Variable_select)
  })
  
  ##### stack bar graph 
  
  output$plot5 <- renderPlotly({
    
    country1 <- country %>% select(-final.consumption)
    b <- country1[country1$country %in% input$country_select4 & country1$Years == input$year_select2,]
    a<-melt(b)
    ggplot(a, aes(x = country,y = value , fill = variable))+ geom_bar(position = "fill", stat = "identity") + coord_flip()+
      labs(x="Countries", y="per_of_GDP") +
      theme(plot.title = element_text(hjust=0.5, size=20, face='bold'))
    
  })
}

shinyApp(ui, server)
