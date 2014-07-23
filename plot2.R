#NEI <- readRDS("summarySCC_PM25.rds")
#SCC <- readRDS("Source_Classification_Code.rds")
NEI_fips<-subset(NEI,fips=="24510",select =c(Emissions, year))

NEI_agg=aggregate(list(Emissions=NEI_fips$Emissions),list(Year=NEI_fips$year),sum)

png(file="plot2.png")

with(NEI_agg,plot(Year,Emissions))

abline(lm(Emissions ~ Year, NEI_agg),lwd = 2)

title(main = "Total Emissions from PM25 by Year for Baltimore, MD") ## Add a main title
dev.off()

