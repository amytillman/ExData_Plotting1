# The purpose of plot4.R is to:
# -read in the household_power_consumption.txt file located in the working directory,
# -subset on (or read in) Feb-2007 data (2007-02-01 and 2007-02-02), and 
# -create four graphs (2x2) of global active power over time, voltage over time, 
#  energy sub metering (1-3) over time, and global reactive power over time

#read in data
powdat <- read.table("./household_power_consumption.txt", header=TRUE, sep=";", 
                     stringsAsFactors=FALSE,na.strings=c("NA","?",""," "))

#str(powdat)

#tell R that you have a date variable and provide format of date
powdat$Date <- as.Date(powdat$Date, format="%d/%m/%Y")

#subset on 01Feb2007 and 02Feb2007
powdat_subset <- subset(powdat, Date=="2007-02-01" | Date=="2007-02-02")

#create datetime variable and append back on to dataset
datetime <- strptime(paste(powdat_subset$Date,powdat_subset$Time,sep=" "), "%Y-%m-%d %H:%M:%S", tz="")
powdat_subset1 <- cbind(powdat_subset,datetime)

#oldpar <- par(no.readonly = TRUE)


#plot all four graphs described above (row 1 first starting with column 1 then row 2 starting with column 1)
png("plot4.png", width=480, height=480) #default units is pixels already

par(mfrow=c(2,2))

plot(powdat_subset1$datetime, powdat_subset1$Global_active_power, 
     xlab="", ylab="Global Active Power",type="l")

plot(powdat_subset1$datetime, powdat_subset1$Voltage, 
     xlab="datetime", ylab="Voltage",type="l")

plot(powdat_subset1$datetime, powdat_subset1$Sub_metering_1, 
     xlim=c(min(powdat_subset1$datetime),max(powdat_subset1$datetime)),
     ylim=c(min(powdat_subset1$Sub_metering_1,powdat_subset1$Sub_metering_2,powdat_subset1$Sub_metering_3),
            max(powdat_subset1$Sub_metering_1,powdat_subset1$Sub_metering_2,powdat_subset1$Sub_metering_3)),
     xlab="", ylab="Energy sub metering",type="n")
lines(powdat_subset1$datetime, powdat_subset1$Sub_metering_1,col="black")
lines(powdat_subset1$datetime, powdat_subset1$Sub_metering_2,col="red")
lines(powdat_subset1$datetime, powdat_subset1$Sub_metering_3,col="blue")
legend("topright",lty=1,col=c("black","red","blue"),
       legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),bty="n")

plot(powdat_subset1$datetime, powdat_subset1$Global_reactive_power, 
     xlab="datetime", ylab="Global_reactive_power",type="l")

dev.off()
