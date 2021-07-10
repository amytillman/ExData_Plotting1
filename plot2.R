# The purpose of plot2.R is to:
# -read in the household_power_consumption.txt file located in the working directory,
# -subset on (or read in) Feb-2007 data (2007-02-01 and 2007-02-02), and 
# -create a graph of global active power in kilowatts over time (date+time)

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


## plot global active power over time
png("plot2.png", width=480, height=480) #default units is pixels already
plot(powdat_subset1$datetime, powdat_subset1$Global_active_power, 
     xlab="", ylab="Global Active Power (kilowatts)",type="l")
#lines(powdat_subset1$datetime, powdat_subset1$Global_active_power)
dev.off()
