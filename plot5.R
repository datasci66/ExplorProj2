library(ggplot2)
##NEI <- readRDS("summarySCC_PM25.rds")
##SCC <- readRDS("Source_Classification_Code.rds")

## get baltimore data where type = On-Road -- this indicates Motor Vehicles
NEI_MV<-subset(NEI,NEI$type=="ON-ROAD" & NEI$fips=="24510",select=c(Emissions,year))

## sum across all sources of MV emissions by year
NEI_agg=aggregate(list(Emissions=NEI_MV$Emissions),
                  list(Year=NEI_MV$year),
                  sum)

png(file="plot5.png")

qplot(Year,Emissions,data=NEI_agg,
      geom =	c("point","smooth"),method="lm",
      main="Baltimore PM2.5 Emissions by Motor Vehicles",
      ylab="PM2.5 Emissions")

dev.off()

