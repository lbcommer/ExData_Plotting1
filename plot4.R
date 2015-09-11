# Load data
data <- read.csv("household_power_consumption.txt", sep=";", na.strings = "?", stringsAsFactors = FALSE)

#data$Time <- strptime(data$Time, format="%H:%M:%S", tz="Europe/Paris")
data$Datetime <- strptime(paste(data$Date, data$Time), format="%d/%m/%Y %H:%M:%S", tz="Europe/Paris") 
data$Date <- as.Date(data$Date, format="%d/%m/%Y")

selectedData <- data[data$Date == "2007-02-01" | data$Date == "2007-02-02"  , ]

# Set english time locale (so we can have weekdays in english)
Sys.setlocale("LC_TIME", "en_US.UTF-8")

# this ensures par() is reseted to default values
dev.off()

# 4 plots 
par(mfrow=c(2,2))

# Create Plot 1
plot(selectedData$Datetime, selectedData$Global_active_power, 
     type="l", ylab="Global Active Power", xlab="")

# Create Plot 2
plot(selectedData$Datetime, selectedData$Voltage, 
     type="l", ylab="Voltage", xlab="datetime")

# Create Plot 3
plot(selectedData$Datetime, selectedData$Sub_metering_1, 
     type="n", ylab="Energy sub mettering", xlab="")

points(selectedData$Datetime, selectedData$Sub_metering_1, 
       type="l", col="black")

points(selectedData$Datetime, selectedData$Sub_metering_2, 
       type="l", col="red")

points(selectedData$Datetime, selectedData$Sub_metering_3, 
       type="l", col="blue")

legend("topright", lty=1, bty='n', col = c("black", "blue", "red"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       y.intersp=0.5, cex=0.6)

# Create Plot 4
plot(selectedData$Datetime, selectedData$Global_reactive_power, 
     type="l", ylab="Global_reactive_power", xlab="datetime", ylim=c(0, 0.5), cex.axis=0.8)

# Generate png file
dev.copy(png, file = "plot4.png")
dev.off()


