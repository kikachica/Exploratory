setwd("~/Coursera/Exploratory Data Analysis")

#======if neccessary installs the package "sqldf" for reading big data using MYSQL======
install.packages("sqldf")
library(sqldf)

#=======reads the data======
file<-read.table("power.txt", header=TRUE, sep=";", stringsAsFactors=FALSE)
Mysql<-"select * from file where Date = '1/2/2007' or Date='2/2/2007'"
myData<-sqldf(Mysql, row.names=FALSE)
rm(file)

#======converting other column to numeric======
myData$Global_active_power<-as.numeric(myData$Global_active_power)

#======plot1======
png("plot1.png")
with(myData, hist(Global_active_power, col="red", xlab="Global Active Power (kilowatts)", main="Global Active Power"))
dev.off()