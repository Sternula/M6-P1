library(shiny)
library(markdown)

source("tabPanels.R", local=TRUE)

shinyUI(
    navbarPage("Apparent Competition",
    tabPanel("Introduction",
             withMathJax(),
             includeHTML("Introduction.html"),
             value = "tP0"),
    tabPanel("Model", tP1, value = "tP1"), # end tabPanel "tp1"
    id = "panels",
    footer = div(br(),
                 img(src="R-UN_L4c_tag_4c.png"),
                 tags$a(href="http://snr.unl.edu/","Brought to you by the School of Natural Resources")
                 )
  ) # end navbarPage
) # end shinyUI

