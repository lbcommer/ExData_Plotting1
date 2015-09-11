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

selectedData <- data[data$Date == "2007-02-01" | data$Date == "2007-02-02"  , ]

# Set english time locale (so we can have weekdays in english)
Sys.setlocale("LC_TIME", "en_US.UTF-8")

# this ensures par() is reseted to default values
dev.off()

# Create Plot 2
plot(selectedData$Datetime, selectedData$Global_active_power, 
     type="l", ylab="Global Active Power (kilowatts)", xlab="")

# Generate png file
dev.copy(png, file = "plot2.png")
dev.off()