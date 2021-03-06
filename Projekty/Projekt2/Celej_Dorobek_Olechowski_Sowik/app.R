library(shiny)
library(shinydashboard)
library(ggplot2)


source('barplots_are_ok.R')
source('bar_plots_gone_wrong.R')
source('last_three.R')


ui <- dashboardPage(
  skin = "black",
  dashboardHeader(title = "Nie rób tego w domu"),
  dashboardSidebar(
    sidebarMenu(
      id = "tabs",
      menuItem("Dashboard", tabName = "dashboard", icon = icon("dashboard")),
      menuItem("About", icon = icon("info-circle"), tabName = "about", badgeLabel = "new",
               badgeColor = "green"),
      menuItem("See also", icon = icon("send",lib='glyphicon'), 
               href = "https://github.com/mini-pw/WizualizacjaDanych2018/blob/master/Prezentacje/P4.Rmd/")
    )
  ),
  dashboardBody(
    tabItems(
      tabItem("dashboard",
              titlePanel("Waffle vs varplot: Liverpool matches in Premier League 2018/19"),
              fluidRow(column(2,                           
                              textInput("textInput1", "How many macthes Liverpool won?", value="0"),
                              verbatimTextOutput("textOutput1", placeholder = TRUE)),
                       box(title = "Waffle", status = "primary",
                          solidHeader = TRUE, collapsible = TRUE, 
                          plotOutput("plot1bad"),
                          width = 5),
                       box(title = "Barplot", status = "primary",
                          solidHeader = TRUE, collapsible = TRUE, collapsed = TRUE,
                          plotOutput("plot1good"), width = 5)),
              titlePanel("Exploded Pie vs barplot: Best Liverpool goalscorers in 2018/19"),
              fluidRow(column(2,                           
                              selectInput("selectInput2", label = "Who scored more: Salah vs Mane?", 
                                          choices = c("don't know", "Mane", "Salah", "the same"), 
                                          selected = NULL),
                              verbatimTextOutput("textOutput2", placeholder = FALSE)),
                       box(title = "Exploded Pie", status = "primary",
                           solidHeader = TRUE, collapsible = TRUE, 
                           plotOutput("plot2bad"), width = 5),
                       box(title = "Barplot", status = "primary", collapsed = TRUE,
                           solidHeader = TRUE, collapsible = TRUE, 
                           plotOutput("plot2good"), width = 5)),
              titlePanel("Stacked barplot vs dodged barplot: Market share in USA and UK"),
              fluidRow(column(2,                           
                              textInput("textInput3", "How many more percent of matket share LG has in UK compared to USA?", value="0"),
                              verbatimTextOutput("textOutput3", placeholder = TRUE)),
                       box(title = "Stacked barplot", status = "primary",
                           solidHeader = TRUE, collapsible = TRUE, 
                           plotOutput("plot3bad"), width = 5),
                       box(title = "Dodged barplots", status = "primary", collapsed = TRUE,
                           solidHeader = TRUE, collapsible = TRUE, 
                           plotOutput("plot3good"), width = 5)),
              titlePanel("Gap barplot vs zoomed facet: results with large discrepancies"),
              fluidRow(column(2,                           
                              textInput("textInput4", "How many more occurrences of category 2 than category 4?", value="0"),
                              verbatimTextOutput("textOutput4", placeholder = TRUE)),
                       box(title = "Gap barplot", status = "primary",
                           solidHeader = TRUE, collapsible = TRUE, 
                           plotOutput("plot4bad"), width = 5),
                       box(title = "Zoomed facet", status = "primary", collapsed = TRUE,
                           solidHeader = TRUE, collapsible = TRUE, 
                           plotOutput("plot4good"), width = 5)),
              titlePanel("Spider plot vs barplot: University subjects popularity"),
              fluidRow(column(2,                           
                              selectInput("selectInput5", label = "Which subjecy is 5th in popularity?", 
                                          choices = c("don't know", "physics", "music", "statistics", "french"), 
                                          selected = NULL),
                              verbatimTextOutput("textOutput5", placeholder = FALSE)),
                       box(title = "Spider plot", status = "primary",
                           solidHeader = TRUE, collapsible = TRUE, 
                           plotOutput("plot5bad"), width = 5),
                       box(title = "Barplot", status = "primary", collapsed = TRUE,
                           solidHeader = TRUE, collapsible = TRUE, 
                           plotOutput("plot5good"), width = 5)),
              titlePanel("TITLE 6"),
              fluidRow(column(2),
                       box(title = "----------", status = "primary",
                           solidHeader = TRUE, collapsible = TRUE, 
                           plotOutput("plot6bad"), width = 5),
                       box(title = "--------", status = "primary", collapsed = TRUE,
                           solidHeader = TRUE, collapsible = TRUE, 
                           plotOutput("plot6good"), width = 5)),
              titlePanel("TITLE 7"),
              fluidRow(column(2),
                       box(title = "--------", status = "primary",
                           solidHeader = TRUE, collapsible = TRUE, 
                           plotOutput("plot7bad"), width = 5),
                       box(title = "----------", status = "primary", collapsed = TRUE,
                           solidHeader = TRUE, collapsible = TRUE, 
                           plotOutput("plot7good"), width = 5)),
              titlePanel("TITLE 8"),
              fluidRow(column(2),
                       box(title = "---------", status = "primary",
                           solidHeader = TRUE, collapsible = TRUE, 
                           plotOutput("plot8bad"), width = 5),
                       box(title = "-------", status = "primary", collapsed = TRUE,
                           solidHeader = TRUE, collapsible = TRUE, 
                           plotOutput("plot8good"), width = 5))
      ),
      tabItem("about",
              "App developed for WD project. Bad plots on the left, collapsed (good) on the right."
      )
    )
  )
)
server <- function(input, output) {
  output$plot1good <- renderPlot(first_ok)
  output$plot1bad <- renderPlot(first_bad)
  output$textOutput1 <- renderText({
    if(input$textInput1==live_matches$Value[live_matches$Result=="Win"]) {
      "Your answer is correct.\nHave you counted in on waffleplot or check on barplot?\nWaffle plot becomes inconvinient when presented value is too big"
    }
    else {
      "Your answer is incorrect.\nProvide proper value. Try not count waffles ;)"
    }
    })
  output$plot2good <- renderPlot(second_ok)
  output$plot2bad <- renderPlot(second_bad())
  output$textOutput2 <- renderText({
    if(input$selectInput2=="the same") {
      "Your answer is correct.\nDo you think 3D exploded pie is fine?"
    }
    else if(input$selectInput2=="don't know") {
      "Select your answer."
    }
    else {
      "Your answer is incorrect.\nCheck barplot!"
    }
    })
  output$plot3bad <- renderPlot(market_stacked)
  output$plot3good<- renderPlot(market_dodge)
  output$textOutput3 <- renderText({
    
    if(input$textInput3==uk_usa_difference) {
      "Your answer is correct."
    } else {
      paste0("Your answer is incorrect.\nProvide proper value.")
    }
    
  })
  output$plot4bad <- renderPlot(gap_in_scale())
  output$plot4good <- renderPlot(zoomed_plot)
  output$textOutput4 <- renderText({
    
    if(input$textInput4==24) {
      "Your answer is correct."
    } else {
      paste0("Your answer is incorrect.\nProvide proper value.")
    }
    
  })
  output$plot5bad <- renderPlot(plot_radar_chart())
  output$plot5good <- renderPlot(barplot_school_subjects)
  output$textOutput5 <- renderText({
    if(input$selectInput5=="statistics") {
      "Your answer is correct.\nDo you think that this usage of spider chart is useful?"
    }
    else if(input$selectInput5=="don't know") {
      "Select your answer."
    }
    else {
      "Your answer is incorrect.\nCheck barplot!"
    }
    })
  output$plot6bad <- renderPlot(six_bad)
  output$plot6good <- renderPlot(six_ok)
  output$plot7bad <- renderPlot(seven_bad)
  output$plot7good <- renderPlot(seven_ok)
  output$plot8bad <- renderPlot(eight_bad)
  output$plot8good <- renderPlot(eight_ok)
}

shinyApp(ui, server)