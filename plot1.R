if(!("lubridate" %in% rownames(installed.packages()))){
  install.packages("lubridate")
}

library(lubridate)

data <- read.table("household_power_consumption.txt", sep=";",na.string="?",header=TRUE)

data$Date <- as.Date(dmy(data$Date))

data$Time <- strptime(data$Time, "%H:%M:%S")

minidata <- data[data$Date %in% as.Date(c("2007-02-01","2007-02-02")),]

hist(minidata$Global_active_power, col="red", xlab="Global Active Power (kilowatts)", main="Global Active Power")

dev.copy(png, file="plot1.png")

dev.off()