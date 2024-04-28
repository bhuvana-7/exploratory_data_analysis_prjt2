## plot1  

# Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 
# Using the base plotting system, make a plot showing the total PM2.5 emission from all sources 
# for each of the years 1999, 2002, 2005, and 2008.

## Reading the file
if(!exists("NEI")){
  NEI <- readRDS("./summarySCC_PM25.rds")
}

# Creating aggregate data frame object based on the year
TotalEmissionsByYear <- aggregate(Emissions ~ year, NEI, sum)

# create plot1.png file
png('plot1.png')

# Plotting
barplot(height=TotalEmissionsByYear$Emissions, names.arg=TotalEmissionsByYear$year, 
        xlab="Year", ylab=expression('Total PM2.5 emission'),
        main=expression('Total PM2.5 emission from all sources for various years'))
dev.off()