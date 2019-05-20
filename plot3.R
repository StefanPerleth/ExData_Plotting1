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
dataPlot3 <- hhPower %>% 
    dplyr::filter(year(date) == 2007, month(date) == 2, day(date) %in% c(1, 2))

### Build time variable
dataPlot3$time <- strptime(paste(dataPlot2$Date, dataPlot2$Time, sep = " "), "%d/%m/%Y %H:%M:%S")

head(dataPlot3)

summary(dataPlot3)

### open png device


png(filename = "plot3.png",
    width = 480, height = 480)

### make plot
with(dataPlot3, plot(time, Sub_metering_1,
                     type = "l", col = "black",
                     ylab = "Energy sub metering",
                     xlab = ""))
lines(dataPlot3$time, dataPlot3$Sub_metering_2, col = "red")
lines(dataPlot3$time, dataPlot3$Sub_metering_3, col = "blue")
legend("topright", lty = 1, col = c("black", "red", "blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

### Close png device
dev.off()

