# The purpose of plot1.R is to:
# -read in the household_power_consumption.txt file located in the working directory,
# -subset on (or read in) Feb-2007 data (2007-02-01 and 2007-02-02), and 
# -create a histogram of global active power in kilowatts

#read in data
powdat <- read.table("./household_power_consumption.txt", header=TRUE, sep=";", 
                        stringsAsFactors=FALSE,na.strings=c("NA","?",""," "))
#str(powdat)

#tell R that you have a date variable and provide format of date
powdat$Date <- as.Date(powdat$Date, format="%d/%m/%Y")

#subset on 01Feb2007 and 02Feb2007
powdat_subset <- subset(powdat, Date=="2007-02-01" | Date=="2007-02-02")


## plot histogram of global active power 
png("plot1.png", width=480, height=480) #default units is pixels already
hist(powdat_subset$Global_active_power, col="red", 
     main ="Global Active Power", xlab="Global Active Power (kilowatts)", ylab="Frequency")
dev.off()
