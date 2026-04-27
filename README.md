# Final Project
# Sea Urchin Biomass Analysis

## Overview
This project analyzes sea urchin biomass in relation to body size, species, habitat, and year using R.

The repository contains:
- `analysis.R` → main R script for data cleaning, visualization, and statistical analysis  
- `Urchin Data_Final.csv` → dataset used in the analysis  
- `README → what you are using now to navigate this project

## How to Run the Analysis
### Open R or RStudio
Make sure you have R and RStudio installed.

### Set your working directory
Place both files (`analysis.R` and `Urchin Data_Final.csv`) in the same folder.

### Install package:
install.packages("tidyverse")

## Run the script
### Open analysis.R in RStudio and run all lines from top to bottom.
The script will:
Load and clean the dataset
Create plots (biomass relationships, habitat comparisons, etc.)
Run statistical models (linear regression)
Output model summaries in the console

## Output
Plots in the RStudio plot viewer:
Biomass vs diameter
Log–log scaling relationship
Habitat and species comparisons
Model summaries in the R console

## Key Findings (Summary)
Biomass strongly increases with body size (allometric scaling)
Habitat (kelp vs barren) has a strong effect on biomass
Species differences are small but detectable
Year effects are minor but statistically significant
Scaling relationships differ slightly between species in log-space

## See written anylasis for further claification and explanations 
