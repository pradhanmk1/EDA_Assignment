
# set current directory where the household_power_consumption.txt is downloaded
setwd("C:/Manoj-H/docs/data science/JHU/4 - Exploratory Data Analysis/Week 1")

# read the file
hh_power<-read.table("household_power_consumption.txt",header = TRUE,sep = ";",na.strings = "?",colClasses=c('character','character','numeric','numeric','numeric','numeric','numeric','numeric','numeric'))

# set the Date as column as date data type
hh_power$Date <- as.Date(hh_power$Date, "%d/%m/%Y")

#filter the data for 2007-02-01 and 2007-02-02
data<-subset(hh_power,Date >= as.Date("2007-02-01") & Date <= as.Date("2007-02-02"))

#remove incomplete data if any
data <- data[complete.cases(data),]

#create date time column by combing data and time attribute
dateTime <- paste(data$Date, data$Time)

#Add the new column - date and time
data <- cbind(dateTime,data)

# convert the datetime column in to date time class using strptime
data$dateTime <- as.POSIXct(dateTime)

# create the plot
par(mfrow=c(2,2), mar=c(4,4,2,1))
with (data,{
	      plot(data$Global_active_power~data$dateTime,type="l",ylab="Global Active Power",xlab="")

	      plot(data$Voltage~data$dateTime,type="l",ylab="Voltage",xlab="datetime")

	      plot(Sub_metering_1~dateTime,type="l",ylab="Energy sub metering",xlab="")
	      lines(Sub_metering_2~dateTime,type="l",col="red")
	      lines(Sub_metering_3~dateTime,type="l",col="blue")
	      legend("topright",col=c("black","red","blue"),lty=1,lwd=2,bty="n",legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
	      plot(data$Global_reactive_power~data$dateTime,type="l",ylab="Global_reactive_power",xlab="datetime")
}
)

#save to png file
dev.copy(png,"plot4.png",height=480,width=480)
dev.off()
