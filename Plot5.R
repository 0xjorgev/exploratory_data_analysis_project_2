#------------------------------------------------------------------------
#
# How have emissions from motor vehicle sources changed 
# from 1999–2008 in Baltimore City?
#
#------------------------------------------------------------------------
library(dplyr)

# Set working directory
# This assumes that both of the datasource files are in sub directory named data
setwd(dir = ".")

#Read both datasources
NEI <- readRDS("./data/summarySCC_PM25.rds")
SCC <- readRDS("./data/Source_Classification_Code.rds")

# Create easier data to look at
SCC_dataframe  <-tbl_df(SCC)
NEI_dataframe <- tbl_df(NEI)

# Combine SUMSSC_df & SCC_df using dplyr to create new data set
CombinedSet<- full_join(NEI_dataframe, SCC_dataframe, by = "SCC")
CombinedSet_df <- tbl_df(CombinedSet)

# Isolate emissions from coal combustion-related sources
EmissionsInBaltimore <- CombinedSet_df %>% group_by(Short.Name, EI.Sector) %>%
  filter(fips == '24510') %>% filter(grepl('Mobile', EI.Sector))

# Accumulate the yearly data
BaltimoreEmissions_SourceByYear <- EmissionsInBaltimore %>% 
  group_by(EI.Sector, year) %>%  summarize(annualEmissions = (sum(Emissions)))

# Create PNG file
png(filename = "Plot5.png", height = 600, width = 600)

# Plot the motor vehicle data the using base plot
plot(BaltimoreEmissions_SourceByYear$year, BaltimoreEmissions_SourceByYear$annualEmissions,
     col = rep(1:37, each = 10), pch = 19,
     xlab = "Year (1999 - 2008)", ylab = "Emissions")
     legend("topright", legend = paste("Emmision Type"), col = 1:37, pch = 19, bty ="n")

# Device off
dev.off()