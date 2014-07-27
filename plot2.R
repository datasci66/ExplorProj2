#---------------------------------------------------
# Total Baltimore PM2.5 Emissions from 1999-2008
#
# Sum *ALL* emissions by year for Baltimore
# and then plot by year using base plotting system
#---------------------------------------------------

# load source data
NEI <- readRDS("summarySCC_PM25.rds")

# filter on Baltimore
NEI_fips<-subset(NEI,fips=="24510",select =c(Emissions, year))

# sum emissions by year
NEI_agg=aggregate(list(Emissions=NEI_fips$Emissions),list(Year=NEI_fips$year),sum)

png(file="plot2.png")

# generate plot 
with(NEI_agg,plot(Year,Emissions))

abline(lm(Emissions ~ Year, NEI_agg),lwd = 2)

title(main = "Total PM2.5 Emissions by Year for Baltimore, MD") ## Add a main title
dev.off()

