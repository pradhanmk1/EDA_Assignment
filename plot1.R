
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

# create the histogram
hist(data$Global_active_power,main = "Global Active Power",xlab = "Global Active Power (kilowatts)",col="red")

#save to png file
dev.copy(png,"plot1.png",height=480,width=480)
dev.off()
