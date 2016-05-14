## Create tabpanel objects here
## they should be named tP<i> where <i> is the
## index of the order they are created.
tP1 <- fluidPage(sidebarLayout(
  sidebarPanel(
    tabsetPanel(
      tabPanel(
        "Prey Species",
        h3("Species 1"),
        sliderInput("N1_0", "Initial Population", 0, 10, 1, step = 0.1),
        sliderInput("K1", "Carrying Capacity", 0.5, 2, 1 , step = 0.1),
        sliderInput("r1", "Intrinsic growth", min = 0, max = 2, value = 1, step = 0.05),
        br(),
        h3("Species 2"),
        sliderInput("N2_0", "Initial Population", 0, 10, 1, step = 0.1),
        sliderInput("K2", "Carrying Capacity", 0.5, 2, 1 , step = 0.1),
        sliderInput("r2", "Intrinsic growth", min = 0, max = 2, value = 1, step = 0.05)
      ),
      tabPanel(
        "Predator Parameters",
        h3("Species 1"),
        sliderInput("C1", "Maximum attack rate", min = 1, max = 10, value = 5, step = 0.1),
        sliderInput("h1", "Handling time", min = 0.1, max = 2, value = 0.6, step = 0.05),
        sliderInput("e1", "Energy Content", min = 0.1, max = 2, value = 1, step = 0.1),
        h3("Species 2"),
        sliderInput("C2", "Maximum attack rate", min = 1, max = 10, value = 5, step = 0.1),
        sliderInput("h2", "Handling time", min = 0.1, max = 2, value = 0.6, step = 0.05),
        sliderInput("e2", "Energy Content", min = 0.1, max = 2, value = 1, step = 0.1),
        h3("Predator"),
        sliderInput("P0", "Initial Population", 0, 10, 1, step = 0.1),
        sliderInput("T_", "Maintenance requirement", min = 0.1, max = 2, value = 0.8, step = 0.1)
      ),
      tabPanel(
        "Simulation Controls",
        sliderInput("showTimeSpan","Time Span shown", min = 0, max = 1000, value = c(100,150), step = 10)
      ) # end last column
    ) # end tabsetPanel
  ), # end sidebarPanel
  
  mainPanel(
    plotOutput("graph1"),
    plotOutput("graph2")
  )  # end mainPanel
) # end sidebarLayout
) # end fluidpage
