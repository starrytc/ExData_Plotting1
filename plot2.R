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
png(filename = "plot2.png", width = 480, height = 480)

plot(x, data$Global_active_power, type = "n", xlab = "",
     ylab = "Global Active Power (kilowatts)")
lines(x, data$Global_active_power)

dev.off()