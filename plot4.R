library(ggplot2)
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Get coal-related sources
SCC_Coal<-SCC[grep("Coal",SCC$EI.Sector),c(1,4)]
        
NEI_Coal<-merge(SCC_Coal,NEI,by.x="SCC",by.y="SCC",all=FALSE)

NEI_agg=aggregate(list(Emissions=NEI_Coal$Emissions),
                  list(Year=NEI_Coal$year),
                  sum)

png(file="plot4.png",width=720)

qplot(Year,Emissions,data=NEI_agg,
      geom =	c("point","smooth"),method="lm",
      main="US Total PM2.5 Emissions by Coal Combustion",
      ylab="PM2.5 Emissions from Coal")

dev.off()

