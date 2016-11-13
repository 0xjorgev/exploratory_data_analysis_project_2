#------------------------------------------------------------------------
#
#      Have total emissions from PM2.5 decreased in the Baltimore City, 
#      Maryland (fips == "24510") from 1999 to 2008? Use base      plotting system to make a plot answering this question.
# 
#------------------------------------------------------------------------
library(dplyr)
# Set working directory
# This assumes that both of the datasource files are in sub directory named data
setwd(dir = ".")

#Read both datasources
NEI <- readRDS("./data/summarySCC_PM25.rds")
#SCC <- readRDS("/data/Source_Classification_Code.rds")

# Filter the Baltimore related data
baltimorePM25 <- NEI %>% group_by("fips") %>% filter(fips == 24510)

# Accumulate
baltimoreAnnual <- baltimorePM25 %>% group_by(year) %>% summarize(annualEmissions = sum(Emissions))

# Create PNG file
png(filename = "Plot2.png",height = 600,width = 600)

# Plot the data, year Emissions on Baltimore, Maryland
plot(baltimoreAnnual$year, baltimoreAnnual$annualEmissions, 
     xlab = "YEARS (1999 - 2008)",  
     ylab = "Total PM 2.5 Emissions",
     main = "PM 2.5 Emissions on Baltimore, Maryland",
     pch= 19, 
     col= "blue")

# Device off
dev.off()