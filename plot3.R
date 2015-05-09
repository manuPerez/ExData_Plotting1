if(!("lubridate" %in% rownames(installed.packages()))){
  install.packages("lubridate")
}

library(lubridate)

data <- read.table("household_power_consumption.txt", sep=";",na.string="?",header=TRUE)

data$Date <- as.Date(dmy(data$Date))

data$Time <- strptime(data$Time, "%H:%M:%S")

minidata <- data[data$Date %in% as.Date(c("2007-02-01","2007-02-02")),]

plot(minidata$Sub_metering_1, type="n", ylab="Energy Sub Metering", xlab="", xaxt="n")

lines(minidata$Sub_metering_1, type="l")

lines(minidata$Sub_metering_2, type="l", col="red")

lines(minidata$Sub_metering_3, type="l", col="blue")

legend("topright", pch="_", col=c("black","red","blue"), legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

first <- 1

medium <- nrow(minidata)/2

last <- nrow(minidata)

wfirst <- wday(minidata[first,1], label=TRUE, abbr=TRUE)

wmedium <- wday(week(minidata[first,1])+1, label=TRUE, abbr=TRUE)

wlast <- wday(week(minidata[first,1])+2, label=TRUE, abbr=TRUE)

axis(side=1, at=c(first,medium,last), labels=c(as.character(wfirst),as.character(wmedium),as.character(wlast)))

dev.copy(png, file="plot3.png")

dev.off()