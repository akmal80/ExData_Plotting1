######################################################################################
## This script produces Plot1 (a figure) in png format
#####################################################################################
### set your working directory here:

setwd("C:\\Users\\puldor\\Desktop\\Coresera\\Exploratory_data_analysis")

##### set time format

lct <- Sys.getlocale("LC_TIME"); Sys.setlocale("LC_TIME", "C")

##### load raw dataset and transfrom  variables into suitable formats 

EPC_total <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", dec = ".", na.strings = "?", colClasses = "character")

str(EPC_total)

date <- EPC_total$Date
time <- EPC_total$Time
datetime <- paste(date, time)

strptime(datetime, "%d/%m/%Y %H:%M:%S")

EPC_total_DT <- cbind(datetime, EPC_total)

EPC_total_DT$datetime <-  strptime(EPC_total_DT$datetime, "%d/%m/%Y %H:%M:%S")

str(EPC_total_DT)

EPC_total_DT_full <- cbind(EPC_total_DT[, 1:3], apply(EPC_total_DT[,4:10], 2, function(x) as.numeric(as.character(x)))) ## This is full dataset available for further data analysis  

str(EPC_total_DT_full)

rm(time, datetime, date, EPC_total, EPC_total_DT)

#########

#### deriving only 2-days observations from the full dataset - subsetting  

Obs2days <- subset(EPC_total_DT_full, datetime >= strptime("01/02/2007 00:00:00", "%d/%m/%Y %H:%M:%S") & datetime < strptime("02/02/2007 23:59:59", "%d/%m/%Y %H:%M:%S"))


##### Construct Plot4 in png format and save it in the working directory 

png("sample_graphs_in_R_Akmal.png",  width = 480, height = 480, units = "px")


par(mfrow=c(2,2)) 

plot(Obs2days$datetime, Obs2days$Global_active_power, type="l", xlab="", ylab="Global Active Power")


plot(Obs2days$datetime, Obs2days$Voltage, type="l", xlab="datetime", ylab="Voltage")


plot(Obs2days$datetime, Obs2days$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")
lines(Obs2days$datetime, Obs2days$Sub_metering_2, type="l", col= "red", xlab="", ylab="Energy sub metering")
lines(Obs2days$datetime, Obs2days$Sub_metering_3, type="l", col="blue", xlab="", ylab="Energy sub metering")
legend("topright", c("Sub_metering_1","Sub_metering_2", "Sub_metering_3" ), 
       lty=c(1, 1,1), # gives the legend appropriate symbols (lines)
       col=c("black", "red","blue")
) # gives the legend lines the correct color and width


plot(Obs2days$datetime, Obs2days$Global_reactive_power, type="l", xlab="datetime", ylab="Global reactive power")

dev.off()
