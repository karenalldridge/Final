# Sea Urchin Analysis Script
# =========================

# Load libraries
library(tidyverse)

# 1: IMPORT DATA
#After data is downloaded and added to Files on R studio
data <- read.csv("Urchin Data_Final.csv")

# 2: CLEAN DATA
#Cleaning data from .csv file for easier use on R (ex. removing "_g" on biomass)
data <- data %>%
  rename(
    year = year,
    habitat = habitat,
    quadrat = quadrat,
    species = species,
    color = Color.desc,
    diameter = diameter_cm,
    biomass = biomass_g
  ) %>%
#Making data values into categorical 
  mutate(
    species = as.factor(species),
    habitat = as.factor(habitat),
    year = as.factor(year),
    color = as.factor(color)
  )

#Look over data to make sure it pulled and changed correctly
summary(data)
table(data$species) #See the two species and how many
table(data$habitat) #See the two types of habitat and how many urchins are from there
table(data$year) #See the two years of collections and how many urchins for each year


# 3: EXPLORATORY PLOTS (Aka Graphs)
# Color palette
colors <- c("#1b9e77", "#d95f02") #Adding some colors

# Scatterplot (linear scale) #Looking at biomass (weight) compared to diameter of urchins
ggplot(data, aes(diameter, biomass, color = species)) +
  geom_point(alpha = 0.5, size = 2) +
  geom_smooth(method = "lm", se = TRUE) +
  scale_color_manual(values = colors) +
  theme_minimal() +
  labs(title = "Biomass vs. Diameter",
       x = "Diameter (cm)",
       y = "Biomass (g)")
#Removes the outliners to see data better
ggplot(data, aes(diameter, biomass, color = species)) +
  geom_point(alpha = 0.5, size = 2) +
  geom_smooth(method = "lm", se = TRUE) +
  scale_color_manual(values = colors) +
  coord_cartesian(xlim = c(0, 10)) +
  theme_minimal() +
  labs(
    title = "Biomass vs. Diameter (Outliners removed)",
    x = "Diameter (cm)",
    y = "Biomass (g)"
  )

# Log-log plot (important for allometry of urchins)
ggplot(data, aes(diameter, biomass, color = species)) +
  geom_point(alpha = 0.5) +
  scale_x_log10() +
  scale_y_log10() +
  scale_color_manual(values = colors) +
  theme_minimal() +
  labs(title = "Allometric Scaling (Log Diamter-Log Biomass)",
       x = "Log Diameter",
       y = "Log Biomass")

# Boxplots by habitat
ggplot(data, aes(habitat, biomass, fill = habitat)) +
  geom_boxplot(alpha = 0.7) +
  facet_wrap(~ species) +
  scale_fill_manual(values = c("#7570b3", "#e7298a")) +
  theme_minimal()

# 4: MODEL: SIZE RELATIONSHIPS
# Linear model with interaction showing general trend
#Does biomass increase with size, and does that relationship differ between species?
model_size <- lm(biomass ~ diameter * species, data = data)
summary(model_size)
#Both species grow in basically the same way in the linear model

# Log-transformed model (better to biologically anylasis) showing real growth trend
data_log <- data %>%
  filter(diameter > 0, biomass > 0)
model_allometry <- lm(log(biomass) ~ log(diameter) * species, data = data_log)
summary(model_allometry)
#Species are very similar overall, but they differ slightly in how biomass scales with size

# 5: MODEL 2: ECOLOGICAL DRIVERS
#After accounting for body size, how does habitat affect biomass?
model_full <- lm(biomass ~ diameter + species + habitat + year, data = data)
summary(model_full)
#food availability strongly influences condition

# 6: DIAGNOSTIC PLOTS
par(mfrow = c(2,2))
plot(model_full)
#Shows the 4 standard plots used to check whether my regression model is valid


# 7: SAVE OUTPUTS
#Create folders
dir.create("output", showWarnings = FALSE)
dir.create("output/figures", showWarnings = FALSE)
#Save the figures as wanted in output folder
