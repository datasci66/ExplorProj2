#--------------------------------------------------------
# Total Baltimore PM2.5 Emissions from 1999-2008 by Type
#
# Sum coal-related emissions by year for the US
# and then plot by year using ggplot2 plotting system
#--------------------------------------------------------

library(ggplot2)

# load source data
NEI <- readRDS("summarySCC_PM25.rds")

# load classification codes for SCC
SCC <- readRDS("Source_Classification_Code.rds")

# Get coal-related sources from the classification list
SCC_Coal<-SCC[grep("Coal",SCC$EI.Sector),c(1,4)]
        
# Merge data set and coal-related class. codes
NEI_Coal<-merge(SCC_Coal,
                NEI,by.x="SCC",
                by.y="SCC",
                all=FALSE) # only include data with codes from SCC_Coal

# sum coal-related emissions by year
NEI_agg=aggregate(list(Emissions=NEI_Coal$Emissions),
                  list(Year=NEI_Coal$year),
                  sum)

png(file="plot4.png",width=720)

# plot emissions by year
qplot(Year,Emissions,data=NEI_agg,
      geom =	c("point","smooth"),method="lm",
      main="US Total PM2.5 Emissions by Coal Combustion",
      ylab="PM2.5 Emissions from Coal")

dev.off()

