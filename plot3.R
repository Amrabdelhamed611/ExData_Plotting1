library(lubridate)
#download the data from the link
if(!file.exists("Dataset.zip")){
    url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
    download.file(url, destfile= "Dataset.zip") 
}
##unzip the data
if(!file.exists('household_power_consumption.txt')  ){
    unzip("Dataset.zip" ) 
}
#select rows we want to read from the dataset
rowsindices <- grep("^(1/2/2007|2/2/2007)",readLines("household_power_consumption.txt"))
data <- read.table("household_power_consumption.txt",
                   sep = ";",
                   skip =rowsindices[1]-1,
                   nrows=length(rowsindices),
                   col.names = names(read.csv2("household_power_consumption.txt", nrows=1)))
#get the rows from txt file but note we need to include the first index on rowsindices 
#so start reading befor the first index by one we dont skip the first one (skip =rowsindices[1]-1)
#and as skiping some rows we cant get headers by headers paramter so read single row 
#and headers and assign the names to colnames
datet<-with(data, dmy(Date) + hms(Time))
png(filename = "plot3.png",width = 480, height = 480)
plot(datet,
     data$Sub_metering_1,
     xlab = "",
     ylab = "Energy Sub Metering",
     type = "n" )
lines(datet,data$Sub_metering_1,col ="black")
lines(datet,data$Sub_metering_2,col ="red")
lines(datet,data$Sub_metering_3,col ="blue")
legend("topright",lty=1,
        col = c("black", "red","blue"),
       legend = c("Sub metering 1", "Sub metering 2","Sub metering 3"))

dev.off()

