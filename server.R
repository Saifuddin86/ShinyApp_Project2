library(shiny)
library(ggplot2)
library(gridExtra)
library(ggthemes)

# Define server logic

shinyServer(
  function(input, output){
    output$p1<-renderPlot({
      # Histogram
      ggplot(mtcars,aes(x=!!input$continuous_var))+
        geom_histogram(bins=input$bins,fill="steelblue",color="black")+
        theme_clean()
    })
    output$p2<-renderPlot({
      # Boxplot
      ggplot(mtcars,aes(y=!!input$continuous_var))+
      geom_boxplot(fill="cyan4")+
      coord_flip()+
        theme_clean()
    })
    output$p3<-renderPlot({
      # Scatterplot
      ggplot(mtcars,aes(x=!!input$continuous_var,y=mpg))+
      geom_point()+
        geom_smooth(se=FALSE)+
        theme_clean()
    })
    output$p4<-renderPlot({
      mtcars %>% select(categorical_variables) %>%
        mutate_all(as.factor)->mtcars_factor
      
      # Pie chart
      ggplot(mtcars, aes(x = "", fill = factor(!!input$categorical_variable))) +
        geom_bar(width = 1) +
        coord_polar("y") +
        geom_text(aes(label = paste0(round(..count../sum(..count..) * 100, 1), "%")), 
                  stat = "count", position = position_stack(vjust = 0.5))+
        labs(title =paste("Distribution of ",input$categorical_variable),
             fill=input$categorical_variable) +
        theme_void() + 
        theme(legend.position = "right")+
        theme_clean()
    })
  }
)