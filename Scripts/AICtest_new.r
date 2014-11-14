# Simplified iterative AIC test to find best ARIMA for selected time series
# Combined to base_script.r

laskuM <- function(aikasarja) {

	tulosmatriisi <- matrix(-Inf, nrow = 6, ncol = 6, dimnames = list(c(0:5),c(0:5)))
	best1model <- NA; best2model <- NA; best3model <- NA
	
	for(i in 0:5) {
		for(j in 0:5) {
			try(test_model <- arima(aikasarja, order=c(i,0,j), include.mean=FALSE))
			
			# Save result of AIC to results matrix
			tulosmatriisi[(i+1),(j+1)] <- test_model$aic
			
			if (test_model$aic >= max(tulosmatriisi)) {
				best3model <- best2model
				best2model <- best1model
				best1model <- test_model
			}
			
		}
	}

# return best model
tulosmatriisi
}