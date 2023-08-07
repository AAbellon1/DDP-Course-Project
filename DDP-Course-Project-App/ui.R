library(shiny)

shinyUI(fluidPage(
    titlePanel("Examine U.S. House Arrests Data"),
    sidebarLayout(
        sidebarPanel(
            h3("Choose which variables to examine the relationship of!"),
            radioButtons("X_Var", "Select variable to plot on X-axis:",
                         choices=colnames(USArrests)),
            radioButtons("Y_Var", "Select variable to plot on Y-axis:",
                         choices=colnames(USArrests)),
            actionButton("genplotBtn", "Generate Plot")
        ),
    mainPanel(
        plotOutput("sPlot")
        )
    )
))