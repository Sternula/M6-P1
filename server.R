library(shiny)
library(ggplot2)
library(dplyr)
library(scales)
library(deSolve)
library(tidyr)

testpars <- c(r1 = 1, K1 = 1, C1 = 1.25, h1 = 0.6,
              r2 = 1, K2 = 1, C2 = 5, h2 = 0.6,
              e1 = 1, e2 = 1, T_ = 0.8)

shinyServer(function(input, output, session) {
  
  mydata <- reactive({
    # Model Parameters:
    np = 1000
    par <- c(K1 = input$K1,
             r1 = input$r1,
             C1 = input$C1,
             h1 = input$h1,
             r2 = input$r2,
             K2 = input$K2,
             C2 = input$C2,
             h2 = input$h2,
             e1 = input$e1,
             e2 = input$e2,
             T_ = input$T_
             )
    
    # Model - Dynamic Change
    # rates of change
    mod <- function(t, y, parms, ...){
      with(as.list(c(y,parms)),{
        dN1 <- r1*N1*(1-N1/K1) - (C1/(1 + h1*C1*N1 + h2*C2*N2))*N1*P
        dN2 <- r2*N2*(1-N2/K2) - (C2/(1 + h1*C1*N1 + h2*C2*N2))*N2*P
        dP <- ((e1*C1*N1 + e2*C2*N2)/(1 + h1*C1*N1 + h2*C2*N2) - T_) * P 
        return(list(c(dN1, dN2, dP)))
      })
    } 
    
    # Initial populations:
    state <- c(N1=input$N1_0, N2=input$N2_0, P=input$P0)
    
    result <- ode(state, 0:np, mod, par)
    
    # Turn the results into a long table
    wide <- as.data.frame(result)
    long <- tidyr::gather(wide, Indicator, Population, N1, N2, P)
    list(long=long, wide=wide)
    
  })
  
  output$graph1 <- renderPlot({
    showSpan <- input$showTimeSpan
    long <- mydata()[["long"]]
    avgPopn <- filter(long, time > showSpan[1] & time < showSpan[2]) %>%
      group_by(Indicator) %>%
      summarize(meanPopn = mean(Population))
    p <- filter(long, time > showSpan[1] & time < showSpan[2]) %>%
      ggplot(aes(x=time, y=Population, group=Indicator))    
    p <- p + 
      geom_line(aes(colour = Indicator), size=1, alpha=.75) + 
      ggtitle("Population Totals") + 
      scale_x_continuous(name="Years") + 
      scale_y_continuous(labels = comma, name="") + 
      geom_hline(aes(yintercept=meanPopn, group = Indicator, color=Indicator), 
                 data= avgPopn)
    print(p)
  })
  
  output$graph2 <- renderPlot({
    showSpan <- input$showTimeSpan
    wide <- mydata()[["wide"]]
    p <- dplyr::filter(wide, time > showSpan[1] & time < showSpan[2]) %>%
      ggplot(aes(x=N1, y=N2))    
    p + 
      geom_point() + 
      scale_x_continuous(name="Species 1")+ 
      scale_y_continuous(name="Species 2")
  })
  
  
})
