library(ggplot2)
#NEI <- readRDS("summarySCC_PM25.rds")
#SCC <- readRDS("Source_Classification_Code.rds")
NEI_fips<-subset(NEI,fips=="24510",select =c(Emissions, year,type))

NEI_agg=aggregate(list(Emissions=NEI_fips$Emissions),
                  list(Year=NEI_fips$year,Type=NEI_fips$type),
                  sum)

png(file="plot3.png",width=960)

##qplot(displ,     hwy,	data	=	mpg,	facets	=	.	~	drv)	
qplot(Year,Emissions,data=NEI_agg,facets=.~Type,
      geom =	c("point","smooth"),method="lm",
      main="Total Emissions by Type in Baltimore, MD",
      ylab="Emissions from PM25")

dev.off()

