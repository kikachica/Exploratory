setwd("~/Coursera/Exploratory Data Analysis")

#======if neccessary installs the package "sqldf" for reading big data using MYSQL======
install.packages("sqldf")
library(sqldf)

#=======reads the data======
file<-read.table("power.txt", header=TRUE, sep=";", stringsAsFactors=FALSE)
Mysql<-"select * from file where Date = '1/2/2007' or Date='2/2/2007'"
myData<-sqldf(Mysql, row.names=FALSE)
rm(file)

#======parse date and time======
myData$Date<-as.Date(myData$Date, "%d/%m/%Y")
library(lubridate)
time<-myData$Time #temp
myData$Time<-hms(myData$Time)

#======converting other columns to numeric======
myData$Global_active_power<-as.numeric(myData$Global_active_power)
myData$Global_reactive_power<-as.numeric(myData$Global_reactive_power)
myData$Voltage<-as.numeric(myData$Voltage)
myData$Global_intensity<-as.numeric(myData$Global_intensity)
myData$Sub_metering_1<-as.numeric(myData$Sub_metering_1)
myData$Sub_metering_2<-as.numeric(myData$Sub_metering_2)
myData$Sub_metering_3<-as.numeric(myData$Sub_metering_3)

#======plot1======
png("plot1.png")
with(myData, hist(Global_active_power, col="red", xlab="Global Active Power (kilowatts)", main="Global Active Power"))
dev.off()