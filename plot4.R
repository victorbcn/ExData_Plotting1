# Plot 4 - Multiple Plots

plot4 <- function() {
  # Preparation of the source data
  data_file <- "household_power_consumption.txt"
  data_dir<-"data"
  data_file_path <- paste(data_dir, data_file, sep="/")
  
  
  if(!file.exists(data_file_path)) {
    if (!dir.exists(data_dir)) {
      dir.create(data_dir)
    }
    fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
    destFile<-paste(data_dir, "power_consumption.zip", sep="/")
    download.file(fileURL, destfile = destFile, method="curl")
    unzip(destFile, exdir=data_dir)
  }
  
  
  # Importing the data into R
  powerdata <- read.table(data_file_path, sep=";", header = TRUE, skip=66636, nrows=2880, na.strings = "?")
  names(powerdata) <- c("Date", "Time", "Global_active_power", "Global_reactive_power", "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
  powerdata <- within(powerdata, {timestamp = strptime(paste(Date, Time), "%d/%m/%Y%H:%M:%S")})
  
  # Plotting to the PNG file
  png(filename = "plot4.png", width=480, height=480, bg="transparent")
  
  # Plot Code
  Sys.setlocale("LC_TIME", "en_US.UTF-8")
  par(mfrow = c(2,2))
  with(powerdata, {
    plot(timestamp, Global_active_power, type="l", xlab= "", ylab = "Global Active Power")
    plot(timestamp, Voltage, type="l", ylab = "Voltage", xlab="datetime")
    plot(timestamp, Sub_metering_1, type="n", ylab="Energy sub metering", xlab="")
    lines(timestamp, Sub_metering_1, col="black")
    lines(timestamp, Sub_metering_2, col="red")
    lines(timestamp, Sub_metering_3, col="blue")
    legend("topright", box.lwd=0, lty = c(1,1), col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
    plot(timestamp, Global_reactive_power, type="l", ylab = "Global_reactive_power", xlab="datetime")
  })
  # Write to file
  dev.off()
}