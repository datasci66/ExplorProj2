#--------------------------------------------------------
# Total Baltimore PM2.5 Emissions from 1999-2008 by Type
#
# Sum *ALL* emissions by year for Baltimore by type
# and then create a plot for each type, by year using 
# ggplot2 plotting system
#--------------------------------------------------------

library(ggplot2)

# load source data
NEI <- readRDS("summarySCC_PM25.rds")

# filter data set on Baltimore and reduce set to Emissions, year, and type
NEI_fips<-subset(NEI,fips=="24510",select =c(Emissions, year,type))

# sum emissions by year and type
NEI_agg=aggregate(list(Emissions=NEI_fips$Emissions),
                  list(Year=NEI_fips$year,Type=NEI_fips$type),
                  sum)

png(file="plot3.png",width=1200,height=600)

# generate one plot per type for year and emissions
qplot(Year,Emissions,data=NEI_agg,facets=.~Type,
      geom =	c("point","smooth"),method="lm",
      main="Total Emissions by Type in Baltimore, MD",
      ylab="Emissions from PM25")

dev.off()

