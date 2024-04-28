# plot3

# Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, 
# which of these four sources have seen decreases in emissions from 1999 2008 for Baltimore City? 
# Which have seen increases in emissions from 1999 2008? 
# Use the ggplot2 plotting system to make a plot answer this question.

# Load the NEI data frame
if(!exists("NEI")){
  NEI <- readRDS("./summarySCC_PM25.rds")
}

library(ggplot2)

# creating subset for Baltimore City, Maryland (fips == "24510")
baltimoreNEI  <- subset(NEI, fips == "24510")

# Creating aggregate data frame object for Baltimore data based on the year
TotalByYearAndType <- aggregate(Emissions ~ year + type, baltimoreNEI, sum)

# create plot3.png file
png('plot3.png')

# Plotting
g <- ggplot(TotalByYearAndType, aes(factor(year), Emissions, fill = type))
g <- g + geom_col(show.legend = FALSE) +
  facet_grid(.~type) + 
  xlab("Year") +
  ylab("Total PM2.5 Emissions") +  
  ggtitle("Total Emissions in Baltimore City from 1999 to 2008")
print(g)
dev.off()