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

# input time series should look like this:
procution_ts <- ts(aineisto[,4],freq=12, start=c(1920,2))
plot(procution_ts)

# Data frame
#aineisto <- data.frame(dataset1);

# ARIMA-models and their BIC - loop over i = 1 to 5 and j = 1 to 5 (test)
tulosmatriisi <- matrix(Inf, nrow = 6, ncol = 6, dimnames = list(c(0:5),c(0:5)))
bestmodel1 <- NA; bestmodel2 <- NA; bestmodel3 <- NA

for(i in 0:5) {
	for(j in 0:5) {
		try(test_model <- arima(procution_ts, order=c(i,0,j), include.mean=FALSE))
		
		# Save result of AIC to results matrix
		tulosmatriisi[(i+1),(j+1)] <- test_model$aic
		
		if (test_model$aic <= min(tulosmatriisi)) {
			bestmodel3 <- bestmodel2
			bestmodel2 <- bestmodel1
			bestmodel1 <- test_model
		}
		
	}
}

# Find outliers from residuals bestmodel1-bestmodel3 with TSA-packages functions
outlierI1 <- detectIO(bestmodel1)
outlierA1 <- detectAO(bestmodel1)

# Create summary tables
# For innovative outliers:
tableI1 <- data.frame(outlierI1$ind, aineisto[outlierI1$ind,1],aineisto[outlierI1$ind,2],  
  aineisto[(outlierI1$ind),4], outlierI1$lambda1, "1st model")
names(tableI1)<-c("OBS","Date","Value","LogDiff","Lambda1", "Model"); tableI1

# For additive outliers:

# Output possible outliers

# Select data.frame to be sent to the output Dataset port
#maml.mapOutputPort("ulos");
