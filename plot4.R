## loading the file

file<-read.table(file="household_power_consumption.txt",header=TRUE,sep=";",na.strings ="?",
                 nrows=2075259,comment.char = "",check.names =FALSE,stringsAsFactors = FALSE, quote='\"')

##step1----coverting the date from character class to date class

file$Date<-as.Date(file$Date,format="%d/%m/%Y")

##check1---- class(file$Date) -----> to check whether the date chaged or not

##step2------subsetting the file

file_sub<- subset(file, Date>="2007-02-01" & Date<="2007-02-02")

##extra1------- as we now have the subset, we are removing the original file to save space
rm(file)

##step3-------- creating a new object datetime in the POSIXct format

datetime <- paste(file_sub$Date, file_sub$Time)

## step4------- creating a new column as Datetime which shows the time in POSIXct 
file_sub$Datetime <- as.POSIXct(datetime)

##step5-----------creating the plot

##extra1---------creating partitions
par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))

##plot 1
plot(y= file_sub$Global_active_power, x= file_sub$Datetime, type="l",
     ylab="Global Active Power (kilowatts)",xlab="")
##plot2

plot(y= file_sub$Voltage, x= file_sub$Datetime, type="l",
     ylab="Voltage",xlab="datetime")
##plot3

plot(y= file_sub$Sub_metering_1, x= file_sub$Datetime, type="l",
     ylab="Energy Sub metering",xlab="", col="black")

points(y=file_sub$Sub_metering_2,x=file_sub$Datetime,col="red",type="l")

points(y=file_sub$Sub_metering_3,x=file_sub$Datetime,col="blue",type="l")

##extra3-------creating the legend

legend("topright",col=c("black","red","blue"),lty=1,lwd=1,bty="n",
       legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),cex=0.5)

##plot4


plot(y= file_sub$Global_reactive_power, x= file_sub$Datetime, type="l",
     ylab="Voltage",xlab="datetime")

##step6-------- copying the file to a device which is png

dev.copy(png, file="plot4.png", height=480, width=480)

##step7------- turn the device off
dev.off()







