# plot4

# Across the United States, how have emissions from coal combustion-related sources changed from 1999-2008?

# Load the NEI & SCC data frames.
if(!exists("NEI")){
  NEI <- readRDS("./summarySCC_PM25.rds")
}
if(!exists("SCC")){
  SCC <- readRDS("./Source_Classification_Code.rds")
}

library(ggplot2)

# fetch all Coal Combustion related data
combustionRelated <- grepl("comb", SCC$SCC.Level.One, ignore.case=TRUE)
coalRelated <- grepl("coal", SCC$SCC.Level.Four, ignore.case=TRUE) 
coalCombustion <- (combustionRelated & coalRelated)
combustionSCC <- SCC[coalCombustion,]$SCC
combustionNEI <- NEI[NEI$SCC %in% combustionSCC,]

# Creating aggregate data based on year for the Coal combustion related sources 
TotalByYearCoalCombustion <- aggregate(Emissions ~ year, combustionNEI, sum)

# create plot4.png file
png("plot4.png", width=640, height=480)

# plotting
g <- ggplot(TotalByYearCoalCombustion, aes(factor(year), Emissions))
g <- g + geom_bar(stat="identity") +
  xlab("year") +
  ylab(expression("Total PM2.5 Emissions")) +
  ggtitle("Total Emissions from coal combustion related sources from 1999 to 2008")
print(g)
dev.off()