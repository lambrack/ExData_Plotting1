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

#Open graphic device
png(filename = "plot1.png")

#Plotting graph
hist(my_data$Global_active_power,
     col = "red",
     main = "Global Active Power",
     xlab = "Global Active Power (kilowatts)")

#Close graphic device
dev.off()