#-------------------------------------------------------------------------
# Total Baltimore and LA PM2.5 Emissions from 1999-2008 for Motor Vehicles
#
# Sum motor vehicle-related emissions by year for the Baltimore and LA,
# and then plot by year using ggplot2 plotting system
#
# "Motor-Vehicle" is determined by type = 'ON-ROAD'
#
# Baltimore fips = 24510; LA fips = 06037
#-------------------------------------------------------------------------

library(ggplot2)

# load source data
NEI <- readRDS("summarySCC_PM25.rds")

## get baltimore and LA data where type = On-Road -- this indicates Motor Vehicles
NEI_MV<-subset(NEI,
               NEI$type=="ON-ROAD" & (NEI$fips=="24510" | NEI$fips=="06037"),
               select=c(Emissions,year,fips))

# factorize the fips codes so we can change their names
NEI_MV$fips<-factor(NEI_MV$fips)

## sum across all sources of MV emissions by year
NEI_agg=aggregate(list(Emissions=log(NEI_MV$Emissions)),
                  list(Year=NEI_MV$year,County=NEI_MV$fips),
                  sum)
# change fips code to county name
levels(NEI_agg$County)[levels(NEI_agg$County)=="24510"] <- "Baltimore"
levels(NEI_agg$County)[levels(NEI_agg$County)=="06037"] <- "Los Angeles"

png(file="plot6.png",width=720,height=480)

# include both counties in one plot, each with different color
qplot(Year,Emissions,data=NEI_agg,
      geom= c("point","smooth"),
      method="lm",
      main="PM2.5 Emissions by Motor Vehicles for Baltimore and Los Angeles",
      ylab="Log(PM2.5 Emissions)",
      color=County)

dev.off()

