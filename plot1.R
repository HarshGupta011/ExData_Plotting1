##Specifying column names while reading
colname<-c("Date","Time","Global_active_power","Global_reactive_power","Voltage","Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3")

##Reading the data 
file<-read.table("household_power_consumption.txt",skip = 1,col.names = colname,sep = ";",stringsAsFactors = FALSE)

##Convert the date variable to the Date format
file$Date<- as.Date(strptime(file$Date,format = "%d/%m/%Y"))

##subset the dataset for the dates 2007-02-02 to 2001-02-01
file<-subset(file,file$Date>="2007-02-01"& file$Date<= "2007-02-02")

##Create a png file with the required width and height
png("plot1.png", width=480, height=480)

##Plot the histogam on the png file
hist(as.numeric(file$Global_active_power),col="red",main="Global Active Power",xlab = "Global Active Power(kilowatts)",ylab="Frequency")

##Close the file
dev.off()