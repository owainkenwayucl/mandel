# Plot timing data for different mandel implementations

# Read our data
timings <- read.csv("timing.csv")

# Sort ascending by time
sortedtimings <- timings[order(timings$Time),]

# Open our output file
png(file="timing.png", width=1024, height=720)

# Plot
barplot(sortedtimings$Time, names.arg=sortedtimings$Language, xlab="Language", ylab="Run time (seconds)", main="Run time of mandel code by language")

# Tidy up
dev.off()