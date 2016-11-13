#------------------------------------------------------------------------
#
#   Of the four types of sources indicated by the type 
#   (point, nonpoint, onroad, nonroad) variable, which of 
#   these four sources have seen decreases in emissions 
#   from 1999–2008 for Baltimore City? Which have seen increases 
#   in emissions from 1999–2008? Use the ggplot2 plotting system 
#   to make a plot answer this question.
#
#------------------------------------------------------------------------
require(ggplot2)
# Set working directory
# This assumes that both of the datasource files are in sub directory named data
setwd(dir = ".")

#Read both datasources
NEI <- readRDS("./data/summarySCC_PM25.rds")
SCC <- readRDS("./data/Source_Classification_Code.rds")

# Sampling
NEI_sampling <- NEI[sample(nrow(NEI), size=5000, replace=F), ]

# Baltimore City, Maryland == fips
MD <- subset(NEI, fips == 24510)
MD$year <- factor(MD$year, levels=c('1999', '2002', '2005', '2008'))

# Create PNG file
png(filename='Plot3.png', width=800, height=600, units='px')

ggplot(data=MD, aes(x=year, y=log(Emissions))) + facet_grid(. ~ type) + guides(fill=F) +
  geom_boxplot(aes(fill=type)) + stat_boxplot(geom ='errorbar') +
  ylab(expression(paste('Log', ' of PM'[2.5], ' Emissions'))) + xlab('Year') + 
  ggtitle('Emissions per Type in Baltimore, Maryland') +
  geom_jitter(alpha=0.10)

# Device off
dev.off()