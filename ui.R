library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(

  # Application title
  titlePanel("Titanic Data"),

  # Sidebar with a slider input for number of bins
  sidebarLayout(
    sidebarPanel(
        h3("Choose the variable that you like to plot its percentage."),
       radioButtons("group", "Group by",
                    c("Class" = "class",
                      "Sex" = "sex",
                      "Age" = "age")),
       h3("Choose whether you want to show survival rate or death rate."),
       radioButtons("rate", "Choose rate",
                    c("Survival" = "survival",
                      "Death" = "death"))
    ),

    # Show a plot of the generated distribution
    mainPanel(
        h3("This bar plot shows the survival/death rate for the selected variable"),
       plotOutput("distPlot")
    )
  )
))
