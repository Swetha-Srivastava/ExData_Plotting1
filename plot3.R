#Dowload and unzip the data for the project
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip","./data/household_power_consumption.zip")
unzip(zipfile="./data/household_power_consumption.zip",exdir="./data")


#read into data table pc (for power consumption) and adjust date times for plotting
pc <- read.table("./data/household_power_consumption.txt", sep = ";", header = TRUE, na.strings = "?", colClasses = c('character','character','numeric','numeric','numeric','numeric','numeric','numeric','numeric'))
pc$Date <- as.Date(pc$Date,"%d/%m/%Y")
pc <- pc[pc$Date == as.Date('2007-2-1')| pc$Date == as.Date('2007-2-2'),]
dateTime <- paste(pc$Date, pc$Time)
dateTime <- strptime(dateTime, "%Y-%m-%d %H:%M:%S")
pc <- cbind(dateTime,pc)

## Create 3 line graphs for plot 3
with(pc,{plot(Sub_metering_1~dateTime, type="l", xlab="", ylab="Energy sub metering")
        lines(Sub_metering_2~dateTime, col="red")
        lines(Sub_metering_3~dateTime, col="blue")
})
legend("topright",col=c("black","red","blue"),lwd=c(1,1,1),c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

# Save the plot to png file
dev.copy(png,"./data/plot3.png", width=480, height=480)
dev.off()
