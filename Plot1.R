library(dplyr)
# Set working directory
# This assumes that both of the datasource files are in sub directory named data
setwd(dir = ".")

#Read both datasources
NEI <- readRDS("/data/summarySCC_PM25.rds")
SCC <- readRDS("/data/Source_Classification_Code.rds")

# Summarize the data from datasource NEI
emissionsSum <- NEI %>% group_by(year) %>% summarize(annualEmissions = sum(Emissions))

# Create PNG file
png(filename = "Plot1.png", height = 600, width = 600)

# Plot the data, year Emissions vs total annual emissions
plot(emissionsSum$year, emissionsSum$annualEmissions,  xlab = "Year (1999 - 2008)", ylab = "PM 2.5 Annual Emissions", pch= 19, col= "green")

# Device off
dev.off()