#Reading data
my_data <- read.table("household_power_consumption.txt",
                      sep = ";",
                      header = TRUE,
                      na.strings = "?",
                      nrows = 2075259,
                      colClasses = c("character", "character", "numeric", 
                                     "numeric", "numeric", "numeric", 
                                     "numeric", "numeric", "numeric"))

#Selecting data from 1/2/2007 to 2/2/2007
my_data <- my_data[my_data$Date == "1/2/2007" | my_data$Date == "2/2/2007",]

#Merging Date and Time columns
datetime <- paste(my_data$Date, my_data$Time, sep = " ")
my_data <- cbind(datetime, my_data[,3:9])

#Convert DateTime to POSIX
my_data$datetime <- strptime(my_data$datetime, format = "%d/%m/%Y %H:%M:%S")

#Open graphic device
png(filename = "plot4.png")

#Setting up plotting canvas
par(mfrow = c(2, 2), mar = c(4, 4, 2, 1))

#Plotting graph 1 (from plot2.R)
with(my_data, plot(datetime, Global_active_power, type = "l", 
                   xlab = "", ylab = "Global Active Power"))

#Plotting graph 2
with(my_data, plot(datetime, Voltage, type = "l"))

#Plotting graph 3 (from plot3.R)
with(my_data, plot(datetime, Sub_metering_1, type = "n", xlab = "", ylab = "Energy sub metering"))
lines(my_data$datetime, my_data$Sub_metering_1)
lines(my_data$datetime, my_data$Sub_metering_2, col = "red")
lines(my_data$datetime, my_data$Sub_metering_3, col = "blue")

legend("topright", lwd = 1, col = c("black", "red", "blue"), legend = names(my_data[, 6:8]), bty = "n")

#Plotting graph 4
with(my_data, plot(datetime, Global_reactive_power, type = "l"))

#Close graphic device
dev.off()