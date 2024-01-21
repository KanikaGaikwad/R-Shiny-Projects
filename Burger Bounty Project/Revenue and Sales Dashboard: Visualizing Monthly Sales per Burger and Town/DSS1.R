library(shiny)
library(shinydashboard)
library(openxlsx)
ui <- dashboardPage(
  dashboardHeader(title = "Burger Bounty"),
  dashboardSidebar(
    selectInput("month", "Select Month",
                choices = c("January", "February", "March", "April", "May",
                            "June", "July", "August", "September", "October",
                            "November", "December")),
    radioButtons("variable", "Select Variable to Aggregate",
                 choices = c("Sales", "Revenue")),
    radioButtons("method", "Select Aggregation Method",
                 choices = c("by Burgers", "by Towns")),
    sidebarMenuOutput("menu")
  )
  ,
  
  dashboardBody(
    fluidRow(
      box(title = "Pie Chart", background = "blue", status = "warning", solidHeader = TRUE, 
          plotOutput("pie1")),
      box(title = "Pie Chart", background = "blue", status = "warning", solidHeader = TRUE, 
          plotOutput("pie2")),
      box(title = "Pie Chart", background = "blue", status = "warning", solidHeader = TRUE, 
          plotOutput("pie3")),
      box(title = "Pie Chart", background = "blue", status = "warning", solidHeader = TRUE, 
          plotOutput("pie4")),
      box(title = "Pie Chart", background = "blue", status = "warning", solidHeader = TRUE, 
          plotOutput("pie5")),
      box(title = "Pie Chart", background = "blue", status = "warning", solidHeader = TRUE, 
          plotOutput("pie6")),
      box(title = "Pie Chart", background = "blue", status = "warning", solidHeader = TRUE, 
          plotOutput("pie7"))
    )
  )
  
)
path = "C:/Users/Kanika Gaikwad/Desktop/Sem 3/adaptive bi/Project/BurgerBounty.xlsx"
server <- function(input, output) {
  df_Visits <- read.xlsx(path, sheet = "Visits", detectDates = TRUE)
  df_Sales <- read.xlsx(path, sheet = "Sales", detectDates = TRUE)
  df_Prices <- read.xlsx(path, sheet = "Prices", detectDates = TRUE)
  df_merged1 <- merge(df_Visits, df_Sales, by = "Date")
  df_merged <- merge(df_merged1, df_Prices, by = "Date")
  
  
  df_merged$Date <- as.Date(df_merged$Date, format = "%m/%d/%Y")
  
  output$menu <- renderMenu({
    # Subset the data for the selected month
    df_month <- subset(df_merged, format(Date, "%B") == input$month)
    
    # Aggregated Revenue by Burger
    if (input$variable == "Sales" && input$method == "by Burgers") {
      # Calculate row-wise sum of columns 9 to 14 for each town
      row_sums <- aggregate(df_month[, 9:14], by = list(Town = df_month$Town), FUN = sum, na.rm = TRUE)
      rownames(row_sums) <- row_sums[,1]
      row_sums <- row_sums[,2:7]
      # Create pie charts for each burger
      
      output$pie1 <- renderPlot({
        burger <- "Bounty.Hunter.x"
        values <- row_sums[, burger]
        names <- rownames(row_sums)
        colors <- terrain.colors(length(values))
        
        # Calculate percentages for labels
        percentages <- round((values / sum(values)) * 100, 1)
        labels <- paste(names, "\n", as.character(percentages), "%")
        
        # Create the pie chart with colors and labels
        pie(values, labels = labels, main = paste("Aggregated",input$variable,"by", burger, "in",input$month), col = colors)
      })
      
      output$pie2 <- renderPlot({
        burger <- "Classic.Cheeseburger.x"
        values <- row_sums[, burger]
        names <- rownames(row_sums)
        colors <- terrain.colors(length(values))
        
        # Calculate percentages for labels
        percentages <- round((values / sum(values)) * 100, 1)
        labels <- paste(names, "\n", as.character(percentages), "%")
        
        # Create the pie chart with colors and labels
        pie(values, labels = labels, main = paste("Aggregated",input$variable,"by", burger, "in",input$month), col = colors)
      })
      
      output$pie3 <- renderPlot({
        burger <- "Spicy.Mutiny.x"
        values <- row_sums[, burger]
        names <- rownames(row_sums)
        colors <- terrain.colors(length(values))
        
        # Calculate percentages for labels
        percentages <- round((values / sum(values)) * 100, 1)
        labels <- paste(names, "\n", as.character(percentages), "%")
        
        pie(values, labels = labels, main = paste("Aggregated",input$variable,"by", burger, "in",input$month), col = colors)
      })
      
      output$pie4 <- renderPlot({
        burger <- "Nature.Bounty.x"
        values <- row_sums[, burger]
        names <- rownames(row_sums)
        colors <- terrain.colors(length(values))
        
        # Calculate percentages for labels
        percentages <- round((values / sum(values)) * 100, 1)
        labels <- paste(names, "\n", as.character(percentages), "%")
        
        pie(values, labels = labels, main = paste("Aggregated",input$variable,"by", burger, "in",input$month), col = colors)
      })
      
      output$pie5 <- renderPlot({
        burger <- "BEC.x"
        values <- row_sums[, burger]
        names <- rownames(row_sums)
        colors <- terrain.colors(length(values))
        
        # Calculate percentages for labels
        percentages <- round((values / sum(values)) * 100, 1)
        labels <- paste(names, "\n", as.character(percentages), "%")
        
        pie(values, labels = labels, main = paste("Aggregated",input$variable,"by", burger, "in",input$month), col = colors)
      })
      
      output$pie6 <- renderPlot({
        burger <- "Double.Veggie.x"
        values <- row_sums[, burger]
        names <- rownames(row_sums)
        colors <- terrain.colors(length(values))
        
        # Calculate percentages for labels
        percentages <- round((values / sum(values)) * 100, 1)
        labels <- paste(names, "\n", as.character(percentages), "%")
        
        pie(values, labels = labels, main = paste("Aggregated",input$variable,"by", burger), col = colors)
      })
      
    }
    
    # Aggregated Sales by towns 
    if (input$variable == "Sales" && input$method == "by Towns") {
      # Calculate row-wise sum of columns 9 to 14 for each town
      row_sums1 <- aggregate(df_month[, 9:14], by = list(Town = df_month$Town), FUN = sum, na.rm = TRUE)
      # Transpose the table
      transposed_df <- t(row_sums1)
      colnames(transposed_df) <- transposed_df[1, ]
      transposed_df <- transposed_df[-1, ]
      transposed_df1 <- apply(transposed_df, 2, as.numeric)
      rownames(transposed_df1) <- rownames(transposed_df)
      
      # Create pie charts for each town
      output$pie1 <- renderPlot({
        town <- "Downtown Hartford"
        values <- transposed_df1[, town]
        names <- rownames(transposed_df1)
        colors <- terrain.colors(length(values))
        
        # Calculate percentages for labels
        percentages <- round((values / sum(values)) * 100, 1)
        labels <- paste(names, "\n", percentages, "%")
        
        pie(values, labels = labels, main = paste("Aggregated",input$variable,"by", town,"in",input$month),col = colors)
      })
      
      output$pie2 <- renderPlot({
        town <- "East Hartford"
        values <- transposed_df1[, town]
        names <- rownames(transposed_df1)
        colors <- terrain.colors(length(values))
        
        # Calculate percentages for labels
        percentages <- round((values / sum(values)) * 100, 1)
        labels <- paste(names, "\n", percentages, "%")
        
        pie(values, labels = labels, main = paste("Aggregated",input$variable,"by", town, "in",input$month),col = colors)
      })
      
      output$pie3 <- renderPlot({
        town <- "Glastonbury"
        values <- transposed_df1[, town]
        names <- rownames(transposed_df1)
        colors <- terrain.colors(length(values))
        # Calculate percentages for labels
        percentages <- round((values / sum(values)) * 100, 1)
        labels <- paste(names, "\n", percentages, "%")
        
        pie(values, labels = labels, main = paste("Aggregated",input$variable,"by", town, "in",input$month),col = colors)
      })
      
      output$pie4 <- renderPlot({
        town <- "Manchester"
        values <- transposed_df1[, town]
        names <- rownames(transposed_df1)
        colors <- terrain.colors(length(values))
        # Calculate percentages for labels
        percentages <- round((values / sum(values)) * 100, 1)
        labels <- paste(names, "\n", percentages, "%")
        
        pie(values, labels = labels, main = paste("Aggregated",input$variable,"by", town, "in",input$month),col = colors)
      })
      
      output$pie5 <- renderPlot({
        town <- "New Britain"
        values <- transposed_df1[, town]
        names <- rownames(transposed_df1)
        colors <- terrain.colors(length(values))
        # Calculate percentages for labels
        percentages <- round((values / sum(values)) * 100, 1)
        labels <- paste(names, "\n", percentages, "%")
        
        pie(values, labels = labels, main = paste("Aggregated",input$variable,"by", town, "in",input$month),col = colors)
      })
      
      output$pie6 <- renderPlot({
        town <- "West Hartford"
        values <- transposed_df1[, town]
        names <- rownames(transposed_df1)
        colors <- terrain.colors(length(values))
        # Calculate percentages for labels
        percentages <- round((values / sum(values)) * 100, 1)
        labels <- paste(names, "\n", percentages, "%")
        
        pie(values, labels = labels, main = paste("Aggregated",input$variable,"by", town, "in",input$month),col = colors)
      })
      
      output$pie7 <- renderPlot({
        town <- "Wethersfield"
        values <- transposed_df1[, town]
        names <- rownames(transposed_df1)
        colors <- terrain.colors(length(values))
        # Calculate percentages for labels
        percentages <- round((values / sum(values)) * 100, 1)
        labels <- paste(names, "\n", percentages, "%")
        
        pie(values, labels = labels, main = paste("Aggregated",input$variable,"by", town, "in",input$month),col = colors)
      })
    }
    #############################################
    # Aggregated Revenue by Town
    if (input$variable == "Revenue" && input$method == "by Towns") {
      # Calculate row-wise sum of columns 9 to 14 for each town
      # Calculate the revenue for each type of burger
      revenue <- df_month[, 9:14] * df_month[, 15:20]
      
      # Aggregate the revenue by town
      revenue_by_town <- aggregate(revenue, by = list(Town = df_month$Town), FUN = sum, na.rm = TRUE)
      
      #row_sums1 <- aggregate(df_month[, 9:14], by = list(Town = df_month$Town), FUN = sum, na.rm = TRUE)
      # Transpose the table
      transposed_df <- t(revenue_by_town)
      colnames(transposed_df) <- transposed_df[1, ]
      transposed_df <- transposed_df[-1, ]
      transposed_df1 <- apply(transposed_df, 2, as.numeric)
      rownames(transposed_df1) <- rownames(transposed_df)
      
      # Create pie charts for each town
      output$pie1 <- renderPlot({
        town <- "Downtown Hartford"
        values <- transposed_df1[, town]
        names <- rownames(transposed_df1)
        colors <- terrain.colors(length(values))
        
        # Calculate percentages for labels
        percentages <- round((values / sum(values)) * 100, 1)
        labels <- paste(names, "\n", percentages, "%")
        
        pie(values, labels = labels, main = paste("Aggregated",input$variable,"by", town, "in",input$month),col = colors)
      })
      
      output$pie2 <- renderPlot({
        town <- "East Hartford"
        values <- transposed_df1[, town]
        names <- rownames(transposed_df1)
        colors <- terrain.colors(length(values))
        
        # Calculate percentages for labels
        percentages <- round((values / sum(values)) * 100, 1)
        labels <- paste(names, "\n", percentages, "%")
        
        pie(values, labels = labels, main = paste("Aggregated",input$variable,"by", town, "in",input$month),col = colors)
      })
      
      output$pie3 <- renderPlot({
        town <- "Glastonbury"
        values <- transposed_df1[, town]
        names <- rownames(transposed_df1)
        colors <- terrain.colors(length(values))
        
        # Calculate percentages for labels
        percentages <- round((values / sum(values)) * 100, 1)
        labels <- paste(names, "\n", percentages, "%")
        
        pie(values, labels = labels, main = paste("Aggregated",input$variable,"by", town, "in",input$month),col = colors)
      })
      output$pie4 <- renderPlot({
        town <- "Manchester"
        values <- transposed_df1[, town]
        names <- rownames(transposed_df1)
        colors <- terrain.colors(length(values))
        
        # Calculate percentages for labels
        percentages <- round((values / sum(values)) * 100, 1)
        labels <- paste(names, "\n", percentages, "%")
        
        pie(values, labels = labels, main = paste("Aggregated",input$variable,"by", town, "in",input$month),col = colors)
      })
      
      output$pie5 <- renderPlot({
        town <- "New Britain"
        values <- transposed_df1[, town]
        names <- rownames(transposed_df1)
        colors <- terrain.colors(length(values))
        
        # Calculate percentages for labels
        percentages <- round((values / sum(values)) * 100, 1)
        labels <- paste(names, "\n", percentages, "%")
        
        pie(values, labels = labels, main = paste("Aggregated",input$variable,"by", town, "in",input$month),col = colors)
      })
      
      output$pie6 <- renderPlot({
        town <- "West Hartford"
        values <- transposed_df1[, town]
        names <- rownames(transposed_df1)
        colors <- terrain.colors(length(values))
        
        # Calculate percentages for labels
        percentages <- round((values / sum(values)) * 100, 1)
        labels <- paste(names, "\n", percentages, "%")
        
        pie(values, labels = labels, main = paste("Aggregated",input$variable,"by", town, "in",input$month),col = colors)
      })
      
      output$pie7 <- renderPlot({
        town <- "Wethersfield"
        values <- transposed_df1[, town]
        names <- rownames(transposed_df1)
        colors <- terrain.colors(length(values))
        
        # Calculate percentages for labels
        percentages <- round((values / sum(values)) * 100, 1)
        labels <- paste(names, "\n", percentages, "%")
        
        pie(values, labels = labels, main = paste("Aggregated",input$variable,"by", town, "in",input$month),col = colors)
      })
    }
    
    #######################################################
    # Aggregated Revenue by Burgers
    if (input$variable == "Revenue" && input$method == "by Burgers") {
      revenue <- df_month[, 9:14] * df_month[, 15:20]
      
      # Aggregate the revenue by town
      revenue_by_town <- aggregate(revenue, by = list(Town = df_month$Town), FUN = sum, na.rm = TRUE)
      # Calculate row-wise sum of columns 9 to 14 for each town
      #row_sums <- aggregate(df_month[, 9:14], by = list(Town = df_month$Town), FUN = sum, na.rm = TRUE)
      rownames(revenue_by_town) <- revenue_by_town[,1]
      row_sums <- revenue_by_town[,2:7]
      # Create pie charts for each burger
      output$pie1 <- renderPlot({
        burger <- "Bounty.Hunter.x"
        values <- row_sums[, burger]
        names <- rownames(row_sums)
        colors <- terrain.colors(length(values))
        
        # Calculate percentages for labels
        percentages <- round((values / sum(values)) * 100, 1)
        labels <- paste(names, "\n", as.character(percentages), "%")
        
        pie(values, labels = labels, main = paste("Aggregated",input$variable,"by", burger, "in",input$month),col = colors)
      })
      
      
      output$pie2 <- renderPlot({
        burger <- "Classic.Cheeseburger.x"
        values <- row_sums[, burger]
        names <- rownames(row_sums)
        colors <- terrain.colors(length(values))
        
        # Calculate percentages for labels
        percentages <- round((values / sum(values)) * 100, 1)
        labels <- paste(names, "\n", as.character(percentages), "%")
        
        pie(values, labels = labels, main = paste("Aggregated",input$variable,"by", burger, "in",input$month),col = colors)
      })
      
      
      output$pie3 <- renderPlot({
        burger <- "Spicy.Mutiny.x"
        values <- row_sums[, burger]
        names <- rownames(row_sums)
        colors <- terrain.colors(length(values))
        
        # Calculate percentages for labels
        percentages <- round((values / sum(values)) * 100, 1)
        labels <- paste(names, "\n", as.character(percentages), "%")
        
        pie(values, labels = labels, main = paste("Aggregated",input$variable,"by", burger, "in",input$month),col = colors)
      })
      
      
      output$pie4 <- renderPlot({
        burger <- "Nature.Bounty.x"
        values <- row_sums[, burger]
        names <- rownames(row_sums)
        colors <- terrain.colors(length(values))
        
        # Calculate percentages for labels
        percentages <- round((values / sum(values)) * 100, 1)
        labels <- paste(names, "\n", as.character(percentages), "%")
        
        pie(values, labels = labels, main = paste("Aggregated",input$variable,"by", burger, "in",input$month),col = colors)
      })
      
      
      output$pie5 <- renderPlot({
        burger <- "BEC.x"
        values <- row_sums[, burger]
        names <- rownames(row_sums)
        colors <- terrain.colors(length(values))
        
        # Calculate percentages for labels
        percentages <- round((values / sum(values)) * 100, 1)
        labels <- paste(names, "\n", as.character(percentages), "%")
        
        pie(values, labels = labels, main = paste("Aggregated",input$variable,"by", burger, "in",input$month),col = colors)
      })
      
      output$pie6 <- renderPlot({
        burger <- "Double.Veggie.x"
        values <- row_sums[, burger]
        names <- rownames(row_sums)
        colors <- terrain.colors(length(values))
        
        # Calculate percentages for labels
        percentages <- round((values / sum(values)) * 100, 1)
        labels <- paste(names, "\n", as.character(percentages), "%")
        
        pie(values, labels = labels, main = paste("Aggregated",input$variable,"by", burger, "in",input$month),col = colors)
      })
      
    }
    
  })
}

shinyApp(ui, server)
