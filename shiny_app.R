library(shiny)
library(ggplot2)

dados_dengue <- read.csv('dengue_casos_freguesia_raw.csv')

ui <- fluidPage(
  titlePanel("Dashboard do panorama Dengue"),
  sidebarLayout(
    sidebarPanel(
      selectInput("variavel", "Selecione uma variável:", choices = c("casos_dengue", "temperatura", "precipitacao", "umidade_ar")),
      selectInput("cor", "Selecione a cor da linha:", choices = c("Azul" = "blue", "Vermelho" = "red", "Verde" = "green")),
      sliderInput("limite_x", "Limite do eixo X:", min = 0, max = 500, value = c(0, 500)),
      sliderInput("limite_y", "Limite do eixo Y:", min = 0, max = 500, value = c(0, 500))
    ),
    mainPanel(
      plotOutput("grafico")
    )
  )
)

server <- function(input, output) {
  
  output$grafico <- renderPlot({
    x <- seq_along(dados_dengue[[input$variavel]])  
    ggplot(dados_dengue, aes(x = x, y = !!sym(input$variavel))) +
      geom_line(color = input$cor) +
      xlim(input$limite_x[1], input$limite_x[2]) +
      ylim(input$limite_y[1], input$limite_y[2]) +
      labs(x = "Índice das Observações", y = "Eixo Y", title = "Gráfico em Linha")
  })
}

shinyApp(ui = ui, server = server)