# Read in the 1st hundred rows to find class of each column
initial <- read.table("household_power_consumption.txt", sep = ";", 
                      header = TRUE, nrow = 100)
classes <- sapply(initial, class)
rm(initial)

# Read in the full table, and subset the data between specified dates
alldata <- read.table("household_power_consumption.txt", sep = ";", 
                      header = TRUE, na.strings = "?",
                      colClasses = classes)
data <- subset(alldata, Date == "1/2/2007" | Date == "2/2/2007")
rm(alldata)

# Date conversion 
x <- strptime(paste(data$Date, data$Time), "%d/%m/%Y %H:%M:%S")

# Open graphic device for PNG format file
png(filename = "plot4.png", width = 480, height = 480)
par(mfrow = c(2, 2))

# upper left 
plot(x, data$Global_active_power, type = "n", xlab = "",
     ylab = "Global Active Power")
lines(x, data$Global_active_power)

# upper right
plot(x, data$Voltage, type = "n", xlab = "datetime", ylab = "Voltage")
lines(x, data$Voltage)

# lower left
plot(x, data$Sub_metering_1, type = "n", xlab = "",
     ylab = "Energy sub metering")
lines(x, data$Sub_metering_1)
lines(x, data$Sub_metering_2, col = "red")
lines(x, data$Sub_metering_3, col = "blue")
legend("topright", col = c("black", "red", "blue"), lty = 1, bty = "n",
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

# lower right
plot(x, data$Global_reactive_power, type = "n", xlab = "datetime",
     ylab = "Global_reactive_power")
lines(x, data$Global_reactive_power)

dev.off()