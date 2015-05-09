if(!("lubridate" %in% rownames(installed.packages()))){
  install.packages("lubridate")
}

library(lubridate)

data <- read.table("household_power_consumption.txt", sep=";",na.string="?",header=TRUE)

data$Date <- as.Date(dmy(data$Date))

data$Time <- strptime(data$Time, "%H:%M:%S")

minidata <- data[data$Date %in% as.Date(c("2007-02-01","2007-02-02")),]

first <- 1
medium <- nrow(minidata)/2
last <- nrow(minidata)
wfirst <- wday(minidata[first,1], label=TRUE, abbr=TRUE)
wmedium <- wday(week(minidata[first,1])+1, label=TRUE, abbr=TRUE)
wlast <- wday(week(minidata[first,1])+2, label=TRUE, abbr=TRUE)

par(mfrow = c(2,2))
with(minidata, {
  plot(minidata$Global_active_power, ylab="Global Active Power", xlab="", xaxt="n", type="l", cex.lab=0.8)
  axis(side=1, at=c(first,medium,last), labels=c(as.character(wfirst),as.character(wmedium),as.character(wlast)))
  
  plot(minidata$Voltage, ylab="Voltage", xlab="datetime", xaxt="n", type="l", cex.lab=0.8)
  axis(side=1, at=c(first,medium,last), labels=c(as.character(wfirst),as.character(wmedium),as.character(wlast)))
  
  plot(minidata$Sub_metering_1, type="n", ylab="Energy Sub Metering", xlab="", xaxt="n", cex.lab=0.8)
  lines(minidata$Sub_metering_1, type="l")
  lines(minidata$Sub_metering_2, type="l", col="red")
  lines(minidata$Sub_metering_3, type="l", col="blue")
  legend(1400,42, pch="_", col=c("black","red","blue"), legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), bty="n", pt.cex=1.2, cex=0.7)
  axis(side=1, at=c(first,medium,last), labels=c(as.character(wfirst),as.character(wmedium),as.character(wlast)))
  
  plot(minidata$Global_reactive_power, ylab="Global Reactive Power", xlab="datetime", xaxt="n", type="l", cex.lab=0.8)
  axis(side=1, at=c(first,medium,last), labels=c(as.character(wfirst),as.character(wmedium),as.character(wlast)))
})

dev.copy(png, file="plot4.png")

dev.off()