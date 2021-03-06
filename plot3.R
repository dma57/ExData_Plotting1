# create directory for dataset
if(!file.exists("data")){
    dir.create("data")
} 

## Download the zip file
zipFileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(zipFileUrl,destfile="./data/Dataset.zip",method="curl")

## unzip the file in the data directory
unzip(zipfile="./data/Dataset.zip",exdir="./data")

# set the locale to US
Sys.setlocale(category = "LC_ALL", locale = "us")

# read the dataset, extracting only rows from 2007-02-01 to 2007-02-02 included
power_cons_col_names <- c("Date","DateTime", "Global_active_power", "Global_reactive_power", "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
power_cons <- read.csv(file.path("data","household_power_consumption.txt"), sep=";", col.names=power_cons_col_names, skip=66636, nrows=2880, stringsAsFactors=FALSE)

# Time column converted from string to Time
power_cons$DateTime <- paste(power_cons$Date, power_cons$DateTime)
power_cons$DateTime <- strptime(power_cons$DateTime, format="%d/%m/%Y %H:%M:%S")

# Date column converted from string to Date
power_cons$Date <- as.Date(power_cons$Date, format="%d/%m/%Y")

# draw plot of Energy sub metering on screen
plot(power_cons$DateTime, power_cons$Sub_metering_1, col="black", type="l", 
     xlab="", ylab="Energy Sub Metering")

lines(power_cons$DateTime, power_cons$Sub_metering_2, col="red", type="l")

lines(power_cons$DateTime, power_cons$Sub_metering_3, col="blue", type="l")

legend("topright", col = c("black", "red", "blue"), 
       legend = c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'), lwd = 1)

# copy histogram to a PNG file specifying with and height
dev.copy(png, file="plot3.png", width=480, height=480)

# close the png device 
dev.off()
