# plot2 

# Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510") from 1999 to 2008? 
# Use the base plotting system to make a plot answering this question.

## Reading the file
if(!exists("NEI")){
  NEI <- readRDS("./summarySCC_PM25.rds")
}

# creating subset for Baltimore City, Maryland (fips == "24510")
subsetNEI  <- subset(NEI, fips == "24510")
                     
# Creating aggregate data frame object for Baltimore data based on the year
TotalEmissionsByYear <- aggregate(Emissions ~ year, subsetNEI, sum)

# create plot2.png file
png('plot2.png')

# Plotting
barplot(height=TotalEmissionsByYear$Emissions, names.arg=TotalEmissionsByYear$year, 
        xlab="Year", ylab=expression('Total PM2.5 emission'),
        main=expression('Total PM2.5 emission in the Baltimore City, MD for various years'))

dev.off()

