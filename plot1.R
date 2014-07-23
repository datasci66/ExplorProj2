#NEI <- readRDS("summarySCC_PM25.rds")
#SCC <- readRDS("Source_Classification_Code.rds")

#NEI_agg=aggregate(list(Emissions=NEI$Emissions),list(Year=NEI$year),sum)
png(file="plot1.png")
with(NEI_agg,plot(Year,Emissions))
abline(lm(Emissions ~ Year, NEI_agg),lwd = 2)
title(main = "Total US Emissions from PM25 by Year") ## Add a main title
dev.off()
