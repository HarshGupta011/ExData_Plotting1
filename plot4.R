##Specifying column names while reading
colname<-c("Date","Time","Global_active_power","Global_reactive_power","Voltage","Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3")

##Reading the data 
file<-read.table("household_power_consumption.txt",skip = 1,col.names = colname,sep = ";",stringsAsFactors = FALSE)

##Convert the date variable to the Date format
file$Date<- as.Date(strptime(file$Date,format = "%d/%m/%Y"))

##subset the dataset for the dates 2007-02-02 to 2001-02-01
file<-subset(file,file$Date>="2007-02-01"& file$Date<= "2007-02-02")

##Convert the date and time variable to the combined Date Time format and add the column to the dataset
DateTime<-as.POSIXct(paste(file$Date, file$Time), format="%Y-%m-%d %H:%M:%S")
file<-cbind(file,DateTime)

##Create a png file with the required width and height
png("plot4.png", width=480, height=480)

##Making space for 4 plots using mfcol
par(mfcol=c(2,2))

##Plotting Global active power vs datetime
plot(file$DateTime , file$Global_active_power , xlab="", ylab="Global Active Power",type="l")

##Plotting Energy sub metering vs datetime
plot(file$DateTime,file$Sub_metering_1,type="n",xlab = "",ylab = "Energy sub metering")
lines(file$DateTime,file$Sub_metering_2,col="red")
lines(file$DateTime,file$Sub_metering_3,col="blue")
lines(file$DateTime,file$Sub_metering_1,col="black")
legend("topright",legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),col=c("black","red","blue"),lty=c(1,1,1),cex = 0.5, bty="n")

##Plotting Voltage vs datetime
plot(file$DateTime,file$Voltage,type="l",xlab = "datetime", ylab = "Voltage")

##Plotting Global_Reactive_Power vs datetime
plot(file$DateTime,file$Global_reactive_power,type="l",xlab = "datetime", ylab = "Global_reactive_power")

##Closing png file
dev.off()
