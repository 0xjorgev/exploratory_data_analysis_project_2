# Library
library(dplyr)
library(lattice)

# Set working directory
# This assumes that both of the datasource files are in sub directory named data
setwd(dir = ".")

#Read both datasources
NEI <- readRDS("./data/summarySCC_PM25.rds")
SCC <- readRDS("./data/Source_Classification_Code.rds")

# Create dataframes
SCC_df  <-tbl_df(SCC)
NEI_df <- tbl_df(NEI)

# Combine both dataframes to create a new datasource
CombinedSet<- full_join(NEI_df, SCC_df, by = "SCC")
CombinedSet_df <- tbl_df(CombinedSet)

BaltimoreVsLa <- CombinedSet_df %>% 
  group_by(EI.Sector) %>%
  filter(fips == c('24510','06037')) %>%
  filter(grepl('Mobile', EI.Sector))

# Accumulate yearly emissions
BaltimoreEmissions_byCity <- BaltimoreVsLa %>% 
  group_by(EI.Sector, fips) %>% 
  summarize(annualEmissions = (sum(Emissions)))

# Create PNG file
png(filename = "Plot6.png", height = 600, width = 600)

xyplot(annualEmissions ~ EI.Sector | fips, data = BaltimoreEmissions_byCity, layout = c(2, 1))

# Shut graphics device off
dev.off()