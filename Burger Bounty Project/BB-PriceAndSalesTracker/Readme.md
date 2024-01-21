# Burger Bounty Data Management

This R script, utilizing the Shiny framework, facilitates the efficient management of data for Burger Bounty, a gourmet meatless burger food truck. The script allows the user to input and update information related to visits, sales, and prices, contributing to the decision support system (DSS) aimed at enhancing overall operations.

## Prerequisites

Before running the script, ensure that you have the following R libraries installed:

```R
install.packages("shiny")
install.packages("openxlsx")

```
You can install these libraries by running the above commands in your R environment.

## Update.Data Function

The `Update.Data` function is central to the script's functionality. It takes various parameters such as Name, Date, Quantity sold for each burger type (B1 to B6), Town, Time spent, Precipitation, Temperature, Event, Weekend, and Selling prices for each burger type (P1 to P6). The function updates the existing Excel file "BurgerBounty.xlsx" with the new data, ensuring accurate and up-to-date records.

## User Interface (UI)

The script provides a user-friendly interface with input fields and controls, categorized into two panels:

### Sidebar Panel

- **Name**: Enter the user's name.
- **Date**: Choose the date of data collection.
- **Town**: Select the town visited by the food truck.
- **Time**: Specify the time spent in the town (in hours).
- **Precipitation**: Set the local probability of precipitation (in percent).
- **Temperature**: Input the local average temperature (in degrees Fahrenheit).
- **Event**: Indicate whether there is an event at the location.
- **Weekend**: Specify if it is a weekend day or a regular day.

### Main Panel

- **Quantity Sold (B1 to B6)**: Enter the number of burgers sold for each type.
- **Selling Prices (P1 to P6)**: Adjust the selling prices for each burger type using sliders.
- **Update Button**: Click the "Update" button to apply changes and update the records.

## How to Run

1. Ensure that the required libraries (`shiny` and `openxlsx`) are installed.
   ```r
   library(shiny)
   library(openxlsx)
   ```
3. Import the Excel File:
   - Open R Studio and load the script.
   - Import the Excel file "BurgerBounty.xlsx" into your R environment.
     - Make sure to import all the sheets: "Visits," "Prices," and "Sales."
     - Save each sheet with the following names:
       - Import "Visits" sheet and save it as "Visits."
       - Import "Prices" sheet and save it as "Prices."
       - Import "Sales" sheet and save it as "Sales."
   - This ensures that the script can read the data from the correct sheets.

4. Run the script in the R environment.
5. Interact with the user interface to input and update data.
6. Click the "Update" button to apply changes and update the records.

## Important Notes

- The script assumes the existence of the Excel file "BurgerBounty.xlsx" with the specified sheets.
- Existing data for a given date will be replaced with the new input.
- Customize the script according to Burger Bounty's evolving needs and data management requirements.

Feel free to customize and enhance the script to meet specific requirements. Contributions and improvements are welcome!
