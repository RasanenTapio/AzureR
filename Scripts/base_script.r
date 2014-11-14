# Map 1-based optional input ports to variables
#dataset1 <- maml.mapInputPort(1) # class: data.frame

## Libraries
library(TSA)

# Test data
test_aineisto <- read.table("E:/data/tuotanto.csv",sep = ";", header=TRUE)

test_aineisto[,1] <- as.Date(test_aineisto[,1])
aineisto <- data.frame(pvm=test_aineisto[,1], production = test_aineisto[,2],
	logproduction=log(test_aineisto[,2]), logdiff=c(NA,diff(log(test_aineisto[,2]))))
plot(aineisto[,4], type='l')

# input timeseries should look like this:
procution_ts <- ts(aineisto[,4],freq=12, start=c(1920,2))
plot(procution_ts)

# Data frame
#aineisto <- data.frame(dataset1);

# ARIMA-models and their BIC - loop over k = 1 to 5 and j = 1 to 5 (test)
bestmodel <- laskuM(procution_ts)

# testing: check results:
max(bestmodel)

# more testin
bestmodel <- laskuM(procution_ts[400:800]); max(bestmodel)

# Find minimum from BIC_results

# Minumum was found at k_min, j_min (was (1,0) with example data

# Find outliers from residuals of ARIMA(k_min, 0, j_min) with TSA-packages functions

# Output

# Select data.frame to be sent to the output Dataset port
#maml.mapOutputPort("ulos");
