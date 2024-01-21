# Burger Bounty Forecasting DSS
## Introduction
This Shiny dashboard serves as a Decision Support System (DSS) for Burger Bounty, providing sales predictions based on various factors. The system includes regression models for different burger types, allowing users to input parameters and receive revenue forecasts.

## Getting Started
1. Clone the Repository:
Clone the GitHub repository to your local machine to access the R script and dataset.
```bash
git clone https://github.com/KanikaGaikwad/R-Shiny-Projects.git
```
2. Open in RStudio:
Open the R script (script.R) in RStudio.

3. Install Required Packages:
Make sure you have the required R packages installed by running the following commands in RStudio:
```r
install.packages("shiny")
install.packages("shinydashboard")
install.packages("openxlsx")
```
4. Run the Script:
Run the R script to load the necessary libraries, perform regression analysis, and set up the Shiny dashboard.

## Import Dataset
Before running the Shiny app, ensure that you have the Burger Bounty dataset available. You can import the dataset using the following R code:
```r
library(openxlsx)

# Load the dataset
BurgerBounty_Visits <- read.xlsx("path/to/your/dataset/BurgerBounty_Visits.xlsx", sheet = 1)
BurgerBounty_Prices <- read.xlsx("path/to/your/dataset/BurgerBounty_Prices.xlsx", sheet = 1)
BurgerBounty_Sales <- read.xlsx("path/to/your/dataset/BurgerBounty_Sales.xlsx", sheet = 1)
```
Replace "path/to/your/dataset/" with the actual path to your dataset files.

## Shiny Dashboard
1, Run Shiny App:
After importing the dataset, run the Shiny app using the following code:
```r
library(shiny)
library(shinydashboard)
library(openxlsx)

attach(BurgerBounty_Visits)
attach(BurgerBounty_Prices)
attach(BurgerBounty_Sales)

# Regression Model for Bounty Hunter
BH.Sales= BurgerBounty_Sales$`Bounty Hunter`
BH.Prices = BurgerBounty_Prices$`Bounty Hunter`

regBH = lm(BH.Sales~BH.Prices+Town+Time+Precipitation+Temperature+Event+Weekend)
summary(regBH)

df = data.frame(
  BH.Prices = 9,
  Town = "Downtown Hartford",
  "Time" = 2,
  "Precipitation" = 0.20,
  "Temperature" = 70,
  "Event" = "Yes",
  "Weekend" = "No"
)
df
# Use the predict() function with your regression model regBH
predicted_value = predict(regBH, newdata = df)

# Display the predicted value
print(predicted_value)
# corresponding Revenue
print(predicted_value*df$BH.Prices)



##########################################################################
# Regression Model for Classic Cheeseburger
CC.Sales = BurgerBounty_Sales$`Classic Cheeseburger`
CC.Prices = BurgerBounty_Prices$`Classic Cheeseburger`
regCC = lm(CC.Sales~CC.Prices+Town+Time+Precipitation+Temperature+Event+Weekend)
summary(regCC)

############################################################
# Regression Model for Spicy Mutiny
SM.Sales = BurgerBounty_Sales$`Spicy Mutiny`
SM.Prices = BurgerBounty_Prices$`Spicy Mutiny`
regSM = lm(SM.Sales~SM.Prices+Town+Time+Precipitation+Temperature+Event+Weekend)
summary(regSM)
############################################################
# Regression Model for Nature Bounty
NB.Sales = BurgerBounty_Sales$`Nature Bounty`
NB.Prices = BurgerBounty_Prices$`Nature Bounty`
regNB = lm(NB.Sales~NB.Prices+Town+Time+Precipitation+Temperature+Event+Weekend)
summary(regNB)
############################################################
# Regression Model for BEC 
BEC.Sales = BurgerBounty_Sales$`BEC`
BEC.Prices = BurgerBounty_Prices$`BEC`
regBEC = lm(BEC.Sales~BEC.Prices+Town+Time+Precipitation+Temperature+Event+Weekend)
summary(regBEC)


############################################################
# Regression Model for Double Veggie
DV.Sales = BurgerBounty_Sales$`Double Veggie`
DV.Prices = BurgerBounty_Prices$`Double Veggie`
regDV = lm(DV.Sales~DV.Prices+Town+Time+Precipitation+Temperature+Event+Weekend)
summary(regDV)
#########################################################################3


#Part 2



library(shiny)
library(shinydashboard)

ui = dashboardPage(
  skin = "purple",
  dashboardHeader(title = "A Forecasting DSS for Burger Bounty ", titleWidth = 365),
  dashboardSidebar(
    width = 350,
    sidebarMenu(
      menuItem("General", tabName = "general", icon = icon("gear"),
               numericInput("etime", label = "Time in town (hours)", min = 1, max = 24, step = 1, value = 1),
               numericInput("preci", label = "Average precipitation (%)", min = 0, max = 100, step = 1, value = 50),
               numericInput("tempe", label = "Average temperature (F)", min = 20, max = 100, step = 1, value = 70),
               selectInput("weekend", label = "Weekend", choices = c("Yes", "No"))),
      menuItem("Events", icon = icon("calendar"), tabName = "events",
               selectInput("edh", label = "Event at Downtown Hartford", choices = c("Yes", "No")),
               selectInput("eeh", label = "Event at East Hartford", choices = c("Yes", "No")),
               selectInput("ewh", label = "Event at West Hartford", choices = c("Yes", "No")),
               selectInput("emh", label = "Event at Manchester", choices = c("Yes", "No")),
               selectInput("enb", label = "Event at New Britain", choices = c("Yes", "No")),
               selectInput("egb", label = "Event at Glastonbury", choices = c("Yes", "No")),
               selectInput("ewf", label = "Event at Wethersfield", choices = c("Yes", "No"))),
      menuItem("Prices", icon = icon("dollar"), tabName = "prices",
               sliderInput("BH.Prices", label = "Bounty Hunter", min = 0, max = 20, step = 0.5, value = 6),
               sliderInput("CC.Prices", label = "Classic Cheeseburger", min = 0, max = 20, step = 0.5, value = 6),
               sliderInput("SM.Prices", label = "Spicy Mutiny", min = 0, max = 20, step = 0.5, value = 6),
               sliderInput("NB.Prices", label = "Nature Bounty", min = 0, max = 20, step = 0.5, value = 6),
               sliderInput("BEC.Prices", label = "BEC", min = 0, max = 20, step = 0.5, value = 6),
               sliderInput("DV.Prices", label = "Double Veggie", min = 0, max = 20, step = 0.5, value = 6))
    ),
    actionButton("recommendations", label = "Recommendation", icon = icon("thumbs-up"))
  ),
  dashboardBody(
    fluidRow(
      conditionalPanel(
        condition = "!input.recommendations",
        p("Press 'Recommendation' button to generate recommendations.")
      ),
      conditionalPanel(
        condition = "input.recommendations",
        box(
          title = "Recommendations",
          status = "danger",
          solidHeader = TRUE,
          tableOutput("t1"),
          width = 12
        )
      )
    )
  )
)





server = function(input, output) {
  observeEvent(input$recommendations, {
    # storing town names
    towns = c("Downtown Hartford", "East Hartford", "West Hartford", 
              "Manchester", "New Britain", "Glastonbury", "Wethersfield")
    
    burgers = c(regBH, regCC, regSM, regNB, regBEC, regDV) # Regression models
    costs = c(input$BH.Prices, input$CC.Prices, input$SM.Prices, 
              input$NB.Prices, input$BEC.Prices,input$DV.Prices)
    # Creating a blank data frame to storing the results
    all_predictions = data.frame(matrix(0L, nrow= length(towns), ncol = 8))
    # Setting the column names
    colnames(all_predictions)= c("Town", "Bounty Hunter", "Classic Cheeseburger",
                                 "Spicy Mutiny","Nature Bounty", "BEC", "Double Veggie", "Predicted Revenues")
    
    for (i in 1:length(towns)){
      if (towns[i] == "Downtown Hartford"){Event = input$edh} # if town is equal to downtown
      # Select the event for the same town
      if (towns[i] == "East Hartford"){Event = input$eeh}
      if (towns[i] == "West Hartford"){Event = input$ewh}
      if (towns[i] == "Manchester"){Event = input$emh}
      if (towns[i] == "New Britain"){Event = input$enb}
      if (towns[i] == "Glastonbury"){Event = input$egb}
      if (towns[i] == "Wethersfield"){Event = input$ewf}
      # Creating dataframe for BH fo all the towns
      df.BH <- data.frame(
        BH.Prices = input$BH.Prices,
        Town = towns[i],
        Time = input$etime,
        Precipitation = input$preci*0.01,
        Temperature = input$tempe,
        Event=Event, # Convert to factor if not already
        Weekend = input$weekend # Convert to factor if not already
      )
      
      
      # Storing the predictions of  BH in y.BH
      y.BH = predict(regBH, newdata = df.BH)
      
      # Creating dataframe for CC fo all the towns
      df.CC = data.frame(
        CC.Prices = input$CC.Prices,
        Town = towns[i],
        Time = input$etime,
        Precipitation = input$preci*0.01,
        Temperature = input$tempe,
        Event=factor(Event), # Convert to factor if not already
        Weekend = input$weekend # Convert to factor if not already
      )
      
      
      # Storing the predictions of CC in y.CC
      y.CC = predict(regCC, newdata = df.CC)
      
      # Creating dataframe for SM fo all the towns
      df.SM = data.frame(
        SM.Prices = input$SM.Prices,
        Town = towns[i],
        Time = input$etime,
        Precipitation = input$preci*0.01,
        Temperature = input$tempe,
        Event=factor(Event), # Convert to factor if not already
        Weekend = input$weekend # Convert to factor if not already
      )
      
      
      # Storing the predictions of SM in y.SM
      y.SM = predict(regSM, newdata = df.SM)
      
      # Creating dataframe for NB fo all the towns
      df.NB = data.frame(
        NB.Prices = input$NB.Prices,
        Town = towns[i],
        Time = input$etime,
        Precipitation = input$preci*0.01,
        Temperature = input$tempe,
        Event=factor(Event), # Convert to factor if not already
        Weekend = input$weekend # Convert to factor if not already
      )
      
      
      # Storing the predictions of NB in y.NB
      y.NB = predict(regNB, newdata = df.NB)
      
      # Creating dataframe for BEC fo all the towns
      df.BEC = data.frame(
        BEC.Prices = input$BEC.Prices,
        Town = towns[i],
        Time = input$etime,
        Precipitation = input$preci*0.01,
        Temperature = input$tempe,
        Event=factor(Event), # Convert to factor if not already
        Weekend = input$weekend # Convert to factor if not already
      )
      
      
      # Storing the predictions of BEC in y.BC
      y.BEC = predict(regBEC, newdata = df.BEC)
      
      # Creating dataframe for DV fo all the towns
      df.DV = data.frame(
        DV.Prices = input$DV.Prices,
        Town = towns[i],
        Time = input$etime,
        Precipitation = input$preci*0.01,
        Temperature = input$tempe,
        Event=factor(Event), # Convert to factor if not already
        Weekend = input$weekend # Convert to factor if not already
      )
      
      
      # Storing the predictions of DV in y.DV
      y.DV = predict(regDV, newdata = df.DV)
      
      #Storing all the predictions for all the burgers and for all the towns in y
      y = c(as.integer(round(y.BH)), as.integer(round(y.CC)), as.integer(round(y.SM)),
            as.integer(round(y.NB)), as.integer(round(y.BEC)), as.integer(round(y.DV)))
      
      # Storing the town names in 1st column
      all_predictions[i, 1] <- towns[i]
      
      # Store the predicted sales for each burger in columns 2 to 7
      all_predictions[i,2:7] = y
      all_predictions[i,8]= all_predictions[i,2]*costs[1]+all_predictions[i,3]*costs[2]+
        all_predictions[i,4]*costs[3]+all_predictions[i,5]*costs[4]+
        all_predictions[i,6]*costs[5]+all_predictions[i,7]*costs[6]
    }
    output$t1 = renderTable({
      # storing the sorted predictions in descending order
      sorted_predictions = all_predictions[order(-all_predictions$`Predicted Revenues`), ]
      # Converting it into a data frame
      as.data.frame(sorted_predictions)
    })
  })
}

shinyApp(ui, server)

```
2. Explore Recommendations:
The Shiny dashboard provides a user interface with tabs for "General," "Events," and "Prices." Adjust the input parameters and click the "Recommendation" button to generate sales predictions.

3. View Recommendations:
The predicted revenues for each town and burger type will be displayed in a table on the dashboard.

## Conclusion
This Burger Bounty Forecasting DSS allows for interactive forecasting based on user inputs. Explore different scenarios to optimize prices and maximize revenue.

Feel free to reach out for any questions or improvements!

Note: Make sure to adapt the paths and file names in the R script and dataset import code according to your local setup.
