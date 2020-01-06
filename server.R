library(shiny)
library(ggplot2)
library(dplyr)
# Define server logic required to draw a histogram
shinyServer(function(input, output) {
    data("Titanic")
    Titanic_data <- data.frame(Titanic)
  output$distPlot <- renderPlot({
      x = switch(input$group,
                 class = 'Class',
                 sex = 'Sex',
                 age = 'Age',
                 'Class')
      Survival <- switch(input$rate,
                         survival = TRUE,
                         death = FALSE,
                         TRUE)
      data <- Titanic_data %>% group_by_at(vars(x,'Survived')) %>% summarise(Total = sum(Freq))
      data_split <- data.frame(split(data$Total, data[x]))
      if (Survival)
      {
          Mortality_rate <- data.frame(rate = sapply(data_split, function(x){x[2]/sum(x)}))
      }
      else
      {
          Mortality_rate <- data.frame(rate = sapply(data_split, function(x){x[1]/sum(x)}))
      }

      Mortality_rate$var <- rownames(Mortality_rate)

      ggplot(aes(var,rate),data=Mortality_rate)+geom_bar(stat = "identity")+
          labs(x=x,y='Percentage')+
          labs(title="Titanic Survival")

  })

})


