# Burger Bounty Shiny Dashboard

This Shiny Dashboard provides visualizations for Burger Bounty sales and revenue data. It allows you to analyze aggregated data by burgers or towns for a specific month.

## Prerequisites

Before running the script, make sure you have the following R libraries installed:

```R
install.packages("shiny")
install.packages("shinydashboard")
install.packages("openxlsx")
library(shiny)
library(shinydashboard)
library(openxlsx)
```
## How to Run
Clone or download the repository.
Open the R script (DSS1.R) in R Studio.
Update the path variable in the script to the path of your "BurgerBounty.xlsx" file on GitHub.

```r
path <- "https://github.com/KanikaGaikwad/R-Shiny-Projects/blob/main/Burger%20Bounty%20Project/BurgerBounty.xlsx"
```
Run the script in the R environment.
## Usage
The dashboard allows you to select a month and choose between sales and revenue. You can aggregate data either by burgers or towns. The dashboard displays pie charts for each burger or town based on your selection.

## Folder Structure
- Burger Bounty Project/: Contains the "BurgerBounty.xlsx" file with data sheets.
- DSS1.R: The main Shiny R script.
- Feel free to customize the script and explore different visualizations based on your data.
