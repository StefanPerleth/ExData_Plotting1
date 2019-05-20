library(lubridate)
library(dplyr)

############ Read in data from website

zipUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

if (!file.exists("./data")) dir.create("./data")
download.file(zipUrl, destfile = "./data/household_power_consumption.zip", method = "libcurl")

### Have a look on the data
unzip("./data/household_power_consumption.zip", list = TRUE)

### Unzip the data
unzip("./data/household_power_consumption.zip", exdir = "./data")

### Show all directories and files
list.dirs("./data")
list.files(("./data"), recursive = TRUE)

### Read in file
hhPower <- read.table(file = "./data/household_power_consumption.txt", sep = ";", na.string = "?", header = TRUE)
head(hhPower)
summary(hhPower)
dim(hhPower)

####### Build graphic
### define Date as date-variable
hhPower$date <- as.Date(hhPower$Date, format = "%d/%m/%Y") 

### select first 2 days of feb 2007
dataPlot4 <- hhPower %>% 
    dplyr::filter(year(date) == 2007, month(date) == 2, day(date) %in% c(1, 2))

### Build time variable
dataPlot4$time <- strptime(paste(dataPlot2$Date, dataPlot2$Time, sep = " "), "%d/%m/%Y %H:%M:%S")

head(dataPlot4)

summary(dataPlot4)

### Set parameter for 4 graphs
par(mfrow = c(2, 2))

### plot1.1
with(dataPlot4, plot(time, Global_active_power,
                     type = "l", 
                     ylab = "Global Active Power",
                     xlab = ""))

### plot1.2
with(dataPlot4, plot(time, Voltage,
                     type = "l", 
                     ylab = "Voltage",
                     xlab = "datetime"))

### plot2.1
with(dataPlot4, plot(time, Sub_metering_1,
                     type = "l", col = "black",
                     ylab = "Energy sub metering",
                     xlab = ""))
lines(dataPlot4$time, dataPlot4$Sub_metering_2, col = "red")
lines(dataPlot4$time, dataPlot4$Sub_metering_3, col = "blue")
legend("topright", lty = 1, col = c("black", "red", "blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       bty = "n", cex = 0.8)

### plot2.2
with(dataPlot4, plot(time, Global_reactive_power,
                     type = "l", 
                     ylab = "Global_reactive_power",
                     xlab = "datetime"))

### Copy to png device
dev.copy(png, file = "plot4.png", width = 480, height = 480) 

### Close png device
dev.off()

