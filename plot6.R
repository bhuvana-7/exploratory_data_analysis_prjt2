# plot5

# How have emissions from motor vehicle sources changed from 1999-2008 in Baltimore City?

# Load the NEI & SCC data frames.
if(!exists("NEI")){
  NEI <- readRDS("./summarySCC_PM25.rds")
}

if(!exists("SCC")){
  SCC <- readRDS("./Source_Classification_Code.rds")
}

library(ggplot2)

# Fetch SSC Vehicle data   
vehicles <- grepl("vehicle", SCC$SCC.Level.Two, ignore.case=TRUE)
vehiclesSCC <- SCC[vehicles,]$SCC

# fetch all Baltimore, LA motor vehicle related data
BaltimoreVehicleNEI <- NEI[(NEI$SCC %in% VehicleSCC$SCC & (NEI$fips == "24510" | NEI$fips=="06037")),]

# Adding new column city in the data set and assigning value based on fips data
BaltimoreVehicleNEI$city[BaltimoreVehicleNEI$fips == "24510"] <- "Baltimore City"
BaltimoreVehicleNEI$city[BaltimoreVehicleNEI$fips == "06037"] <- "Los Angeles"

# create plot6.png file
png("plot6.png", width=840, height=480)

#Plotting
g <- ggplot(BaltimoreVehicleNEI, aes(factor(year), Emissions, fill = city))
g <- g + geom_col(show.legend = FALSE) +
  facet_grid(.~city) + 
  xlab("year") +
  ylab(expression("Total PM2.5 Emissions")) +
  ggtitle('Total Emissions from motor vehicle in Baltimore City and Los Angeles from 1999 to 2008')
print(g)
dev.off()

