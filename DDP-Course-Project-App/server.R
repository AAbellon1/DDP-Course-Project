library(shiny)
library(ggplot2)

shinyServer(function(input, output) {
    observeEvent(input$genplotBtn, {
        x = ifelse(input$X_Var == 'Murder', 1,
                    ifelse(input$X_Var == 'Assault', 2,
                           ifelse(input$X_Var == 'UrbanPop', 3, 4)))
        y = ifelse(input$Y_Var == 'Murder', 1,
                    ifelse(input$Y_Var == 'Assault', 2,
                           ifelse(input$Y_Var == 'UrbanPop', 3, 4)))
        
        df = as.data.frame(USArrests)
        trend = lm(df[,input$Y_Var] ~ df[,input$X_Var])
        
        plot_data = data.frame(
            x = df[, input$X_Var],
            y = df[, input$Y_Var]
        )
        
        equation = paste('y =', 
                         round(coef(trend)[2], 2), 
                         'x +', 
                         round(coef(trend)[1], 2))
        
        output$sPlot = renderPlot({
            ggplot(plot_data, aes(x = x, y = y)) +
                geom_point() +
                geom_line(aes(y = predict(trend)), color = 'maroon') +
                labs(x = input$X_Var, y = input$Y_Var) +
                geom_text(aes(label = equation), x = Inf, y = Inf, 
                          hjust = 1, vjust = 1)
        })
    })
})