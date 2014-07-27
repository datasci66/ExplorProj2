#----------------------------------------
# Total US PM2.5 Emissions from 1999-2008
#
# Sum *ALL* emissions by year and plot 
#----------------------------------------

# Load data source
NEI <- readRDS("summarySCC_PM25.rds")

# sum ALL emissions by year
NEI_agg=aggregate(list(Emissions=NEI$Emissions),list(Year=NEI$year),sum)

png(file="plot1.png")

# generate plot
with(NEI_agg,plot(Year,Emissions))
             abline(lm(Emissions ~ Year, NEI_agg),lwd = 2)

title(main = "Total US PM2.5 Emissions by Year") ## Add a main title

dev.off()
