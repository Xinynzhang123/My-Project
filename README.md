# my-projectThis project analyzes global vaccine coverage and disease burden data for 1980-2015.    The analysis includes visual comparisons across regions and countries, aiming to uncover trends and insights into global immunization practices.

Data
The data used in this project is sourced from the 2017 WHO report on vaccine coverage and disease burden.      The dataset includes fields for country, year, immunization coverage rates, and disease cases for various vaccines and diseases.

Key Analysis Steps
Data Cleaning and Preparation:
Dealing with Missing Values: A custom function (replaceNA) was used to fill missing data points by averaging adjacent years.      This provides a more reliable value for missing entries rather than filling with zeros, which could misrepresent trends.
Data Reshaping: The dataset was transformed from long format to wide format using pivot_wider for easier year-to-year comparison.
Data Visualizations:
Scatter Plot: This plot compares polio and measles immunization coverage across countries, with North African countries highlighted.      The scatter plot enables easy comparison of vaccination levels between the two diseases.
Country Comparison Plot: A line plot function (visualize2countries) was created to compare disease cases between Egypt and Sudan, focusing on tetanus cases in this analysis.      This function facilitates flexible country comparisons for quick insights.
World Map of Polio Immunization: A choropleth map visualizes polio immunization coverage worldwide, using color gradients to indicate coverage levels.      This view highlights geographic disparities in vaccine coverage.

Visualizations and Their Rationale
Scatter Plot: Demonstrates the correlation between polio and measles immunization rates, with North African countries distinguished for regional insight.
Line Plot for Country Comparisons: Offers longitudinal insights into disease cases, with the custom function enabling flexible comparisons between different countries.
World Map: Visually represents immunization disparities by country, helping to identify regions with particularly high or low vaccine coverage levels.

Required Packages
The following R packages are required to run the analysis:
dplyr for data wrangling
tidyr for data reshaping
ggplot2 for creating visualizations
maps for map data
How to Use the Code
Ensure the dataset (Vaccine Coverage and Disease Burden - WHO (2017).csv) is in your working directory.
Load the necessary R libraries.
Run each code block sequentially to reproduce the analysis and visualizations.