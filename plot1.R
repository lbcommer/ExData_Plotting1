# Load data

file <- "household_power_consumption.txt"

# check if data file exists (it must be downloaded)
if (!file.exists(file))
{
    stop("Data file not found")
}    

data <- read.csv(file, sep=";", na.strings = "?", stringsAsFactors = FALSE)

data$Datetime <- strptime(paste(data$Date, data$Time), format="%d/%m/%Y %H:%M:%S", tz="Europe/Paris") 
data$Date <- as.Date(data$Date, format="%d/%m/%Y")

# this ensures par() is reseted to default values
dev.off()

# Create Plot 1
plot1 <- data[data$Date == "2007-02-01" | data$Date == "2007-02-02"  , "Global_active_power"]
hist(plot1, col="red", xlab="Global Active Power (kilowatts)")

# Generate png file
dev.copy(png, file = "plot1.png")
dev.off()