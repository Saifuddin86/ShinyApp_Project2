# Import library
library(shiny)
library(tidyverse)

# Categorical variable list in `mtcars`
#glimpse(mtcars)

categorical_variables<-c('cyl','vs','am','gear','carb')

# Application layout

shinyUI(
  fluidPage(
    titlePanel(title=div(img(src="shiny.png",height=50, width=100),
               "Data Exploration Using Shiny")),
    
    # Define sidebar layout with sidebar panel and main panel
    sidebarLayout(
      sidebarPanel(
        h3('Explore mtcars'),
        # Input 1: variable select
        varSelectInput('continuous_var','Select continuous variable',
                       data=select(mtcars,-categorical_variables),selected='wt'),
        # Input 2: variable select
        varSelectInput('categorical_variable','Select categorical variable',
                       data = mtcars[categorical_variables],selected = 'cyl'),
        
        # Input 3: slider
        sliderInput('bins','Number of bins:',min=2,max=20,value = 5),
        
        # Add plot guide
        h4('Plot Variable Map Guide'),
        p( ' Miles/(US) gallon=mpg ' , br(),
           ' Number of cylinders=cyl ' , br(),
           ' Displacement (cu.in.)=disp ' , br(),
           ' Gross horsepower=hp ' , br(),
           ' Rear axle ratio=drat ' , br(),
           ' Weight (1000 lbs)=wt ' , br(),
           ' 1/4 mile time=qsec ' , br(),
           ' Engine (0 = V-shaped, 1 = straight)=vs ' , br(),
           ' Transmission (0 = automatic, 1 = manual)=am ' , br(),
           ' Number of forward gears=gear ' , br(),
           ' Number of carburetors=carb ' , br()
           
        )
        
      ),
      mainPanel(
        tabsetPanel(
          tabPanel("Plots for observing data trend",
            plotOutput('p1'),
            plotOutput('p2')),
          tabPanel("Plots for observing data correlation",
            plotOutput('p3')),
          tabPanel("Pie chart of categorical variables",
            plotOutput('p4'))       
      
        )
      )
    )
    
  )
)

