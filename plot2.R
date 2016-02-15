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
png(filename = "plot2.png")

#Plotting graph
with(my_data, plot(datetime, Global_active_power, type = "l", 
                   xlab = "", ylab = "Global Active Power (kilowatts)"))

#Close graphic device
dev.off()