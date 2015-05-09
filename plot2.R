if(!("lubridate" %in% rownames(installed.packages()))){
  install.packages("lubridate")
}

library(lubridate)

data <- read.table("household_power_consumption.txt", sep=";",na.string="?",header=TRUE)

data$Date <- as.Date(dmy(data$Date))

data$Time <- strptime(data$Time, "%H:%M:%S")

minidata <- data[data$Date %in% as.Date(c("2007-02-01","2007-02-02")),]

plot(minidata$Global_active_power, ylab="Global Active Power (kilowatts)", xlab="", xaxt="n", main="Global Active Power", type="l")

first <- 1

medium <- nrow(minidata)/2

last <- nrow(minidata)

wfirst <- wday(minidata[first,1], label=TRUE, abbr=TRUE)

wmedium <- wday(week(minidata[first,1])+1, label=TRUE, abbr=TRUE)

wlast <- wday(week(minidata[first,1])+2, label=TRUE, abbr=TRUE)

axis(side=1, at=c(first,medium,last), labels=c(as.character(wfirst),as.character(wmedium),as.character(wlast)))

dev.copy(png, file="plot2.png")

dev.off()