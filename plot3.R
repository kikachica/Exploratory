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

#======converting other columns to numeric======
myData$Sub_metering_1<-as.numeric(myData$Sub_metering_1)
myData$Sub_metering_2<-as.numeric(myData$Sub_metering_2)
myData$Sub_metering_3<-as.numeric(myData$Sub_metering_3)

#======plot3======
png("plot3.png", width=480, height=480)
with(myData, plot(datetime, myData$Sub_metering_1, col="black", type="l", xlab="",ylab="Energy sub metering"))
with(myData, lines(datetime, myData$Sub_metering_2, col="red", type="l"))
with(myData, lines(datetime, myData$Sub_metering_3, col="blue", type="l"))
legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col=c("black", "red", "blue"), lwd=1)
dev.off()
