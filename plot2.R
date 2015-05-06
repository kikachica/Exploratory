#======setting my local WD and changing system time to English======
setwd("~/Coursera/Exploratory Data Analysis")
Sys.setlocale("LC_TIME", "English")

#======if neccessary installs the package "sqldf" for reading big data using MYSQL======
install.packages("sqldf")
library(sqldf)

#=======reads the data and subsets for requested dates======
file<-read.table("power.txt", header=TRUE, sep=";", stringsAsFactors=FALSE)
Mysql<-"select * from file where Date = '1/2/2007' or Date='2/2/2007'"
myData<-sqldf(Mysql, row.names=FALSE)
rm(file)

#======parse date and time======
datetime <- strptime(paste(myData$Date, myData$Time, sep=" "), "%d/%m/%Y %H:%M:%S") 

#======converting other column to numeric======
myData$Global_active_power<-as.numeric(myData$Global_active_power)

#======plot2======
png("plot2.png", width=480, height=480)
with(myData, plot(datetime, Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)"))
dev.off()
