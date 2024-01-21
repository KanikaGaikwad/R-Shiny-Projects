library(shiny)
library(openxlsx)

Update.Data <- function(Name, Date, B1, B2, B3, B4, B5, B6, Town, Time, Precipitation, Temperature, Event, Weekend, P1, P2, P3, P4, P5, P6) {
  excel_file <- "Burger Bounty Project/BB-PriceAndSalesTracker/BurgerBounty (1).xlsx"
  
  # Load the workbook
  wb <- loadWorkbook(excel_file)
  
  # Load the existing sheets
  df_Visits <- read.xlsx(wb, sheet = "Visits")
  df_Prices <- read.xlsx(wb, sheet = "Prices")
  df_Sales <- read.xlsx(wb, sheet = "Sales")
  
  # Convert Date to Date format
  df_Visits$Date <- as.Date(df_Visits$Date, origin = "1900-01-01")
  df_Sales$Date <- as.Date(df_Sales$Date, origin = "1900-01-01")
  df_Prices$Date <- as.Date(df_Prices$Date, origin = "1900-01-01")
  Date <- as.Date(Date)
  
  # Remove existing row if Date already exists
  df_Visits <- df_Visits[!df_Visits$Date == Date,]
  df_Sales <- df_Sales[!df_Sales$Date == Date,]
  df_Prices <- df_Prices[!df_Prices$Date == Date,]
  
  # Create data frames for new data
  dd_Visits <- data.frame(Date, Name, Town, Time, Precipitation, Temperature, Event, Weekend)
  dd_Prices <- data.frame(Date, P1, P2, P3, P4, P5, P6)
  dd_Sales <- data.frame(Date, B1, B2, B3, B4, B5, B6)
  colnames(dd_Visits) <- colnames(df_Visits)  # Adjusted column names
  colnames(dd_Prices) <- colnames(df_Prices)
  colnames(dd_Sales) <- colnames(df_Sales)
  
  # Append new data to existing data frames
  df_Visits <- rbind(df_Visits, dd_Visits)
  df_Prices <- rbind(df_Prices, dd_Prices)
  df_Sales <- rbind(df_Sales, dd_Sales)
  
  # Write the modified data frames back to their respective sheets
  writeData(wb, sheet = "Visits", df_Visits)
  writeData(wb, sheet = "Prices", df_Prices)
  writeData(wb, sheet = "Sales", df_Sales)
  
  # Save the workbook
  saveWorkbook(wb, excel_file, overwrite = TRUE)
}


ui <- fluidPage(
  titlePanel("Customer Order Entry"), 
  sidebarLayout(
    sidebarPanel(
      textInput("Name", label= "Enter User's Name"), # a
      dateInput("Date", label = "Enter the date, when the data was collected", format= "mm/dd/yyyy", 
                min = "2023-10-20", max = "2023-12-31", value = Sys.Date()), # b
      selectInput("Town", label = "Enter the town visited by the truck",
                  choices = c("Downtown Hartford", "East Hartford", "West Hartford", 
                              "Manchester", "New Britain", "Glastonbury", "Wethersfield"), 
                  selected = "Downtown Hartford"), # d
      numericInput("Time", label = "Enter Time spent in a town (in hours)", 
                   min=1, max=24, value=1), # e
      sliderInput("Precipitation", label = "Enter the local probability of precipitation (in percent)", 
                  min=0, max=100, step=1, value=50), # f
      sliderInput("Temperature", label = "Enter the local average temperature (in degrees Fahrenheit)", 
                  min=20, max=100, value=70), # g
      radioButtons("Event", label = "Enter whether there is an event at the location", 
                   choices = c("Yes", "No")), # h
      radioButtons("Weekend", label = "Enter whether it is a weekend day or a regular day", 
                   choices = c("Yes", "No")), # i
      
    ),
    mainPanel(
      numericInput("B1", label = "Enter the number of quantity sold for Bounty Hunter Burger", 
                   min=1, max=100, value = 20), # c
      numericInput("B2", label = "Enter the number of quantity sold for Classic Cheeseburger", 
                   min=1, max=100, value = 20), # c
      numericInput("B3", label = "Enter the number of quantity sold for Spicy Mutiny Burger", 
                   min=1, max=100, value = 20), # c
      numericInput("B4", label = "Enter the number of quantity sold for Nature Bounty Burger", 
                   min=1, max=100, value = 20), # c
      numericInput("B5", label = "Enter the number of quantity sold for BEC Burger", 
                   min=1, max=100, value = 20), # c
      numericInput("B6", label = "Enter the number of quantity sold for Double Veggie Burger", 
                   min=1, max=100, value = 20), # c
      hr(),
      
      sliderInput("P1", label = "Enter Selling price of Bounty Hunter Burger", 
                  min=0, max=20, step=0.5, value=6), # j
      sliderInput("P2", label = "Enter Selling price of Classic Cheeseburger", 
                  min=0, max=20, step=0.5, value=6), # j
      sliderInput("P3", label = "Enter Selling price of Spicy Mutiny Burger", 
                  min=0, max=20, step=0.5, value=6), # j
      sliderInput("P4", label = "Enter Selling price of Nature Bounty Burger", 
                  min=0, max=20, step=0.5, value=6), # j
      sliderInput("P5", label = "Enter Selling price of BEC Burger", 
                  min=0, max=20, step=0.5, value=6), # j
      sliderInput("P6", label = "Enter Selling price of Double Veggie Burger", 
                  min=0, max=20, step=0.5, value=6), # j
      actionButton("Update", icon("refresh")) # k
      
    )
    
  )
  
)  
server= function(input, output) {
  observeEvent(input$Update,{
    Update.Data(input$Name,input$Date,input$B1,input$B2,input$B3,input$B4,
                input$B5,input$B6,input$Town,input$Time, input$Precipitation,
                input$Temperature,input$Event,input$Weekend,
                input$P1,input$P2,input$P3,input$P4,input$P5,input$P6)
  })
}
shinyApp(ui, server)
