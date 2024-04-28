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

# fetch all Baltimore and motor vehicle related data
BaltimoreVehicleNEI <- NEI[(NEI$SCC %in% VehicleSCC$SCC) & NEI$fips == "24510",]

# Creating aggregate data based on year for the Baltimore Vehicle data 
TotalByYearBaltimoreMotorVehicle <- aggregate(Emissions ~ year, BaltimoreVehicleNEI, sum)

# create plot5.png file
png("plot5.png", width=840, height=480)

#Plotting
g <- ggplot(TotalByYearBaltimoreMotorVehicle, aes(factor(year), Emissions))
g <- g + geom_bar(stat="identity") +
  xlab("year") +
  ylab(expression("Total PM2.5 Emissions")) +
  ggtitle('Total Emissions from motor vehicle in Baltimore City, Maryland (fips = "24510") from 1999 to 2008')
print(g)
dev.off()

