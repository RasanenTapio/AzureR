# MyDistanceMany - for matrix with multiple ids and id variable column

# MyDistance - for matrix without id variable columns

# Required libraries
library(data.table)
library(MASS)

# File to subsample
path_features <- "C:/cdata_results/features.csv"

# For bigger files:
features <- fread(path_features, header = TRUE, sep = ',')

# seed
set.seed(11)

# dmatrix - matrix or data frame with first column as id
myDistanceMany <- function(dmatrix, loop_start, loop_stop, result_name) {

	# To loop over
	identifiers <- unique(as.matrix(dmatrix[,1]))
	
	# For results
	path_results <- paste("C:/cdata_results/local/", result_name, ".csv", sep = "")

	message(paste("Started", Sys.time()))
	start_t <- Sys.time()

	for (i in loop_start:loop_stop){

		observation1 <- identifiers[i]
		
		train <- as.matrix(dmatrix)
		train <- train[,-1]
		
		# subset.. (1a) ### Add su
		
		# Make sure that there are no NAs. If there are, then skip
		na_check <- sum(is.na(train))
		
		# For result
		result <- matrix(NA, 100, 3) ### Size? Should be same as subset (1a)
		
		# Skip if NA's
		if (!na_check){
			Sx <- cov(train)
			Sx1 <- ginv(Sx) #Sx1 <- solve(Sx)
			
			otos_s <- sample(1:100, 3, replace = FALSE) ### Size? Add parameter

			for (k in 1:length(otos_s)) {
				
				center_row <- as.vector(train[otos_s[k],]) # Select one random row as center
				subsampled[,k] <- mahalanobis(train, center_row, Sx1, inverted=TRUE)
				subsampled[otos_s[k],k] <- NA # Set distance to self NA
			}
			
			## Select row minimums:
			min_dist <- apply(subsampled, 1, min, na.rm = TRUE)
			
			## Z-tests:
			zz <- (min_dist - mean(min_dist, na.rm = TRUE)) / (sd(min_dist, na.rm = TRUE) / sqrt(100))

			# some distributions. DF?
			tod_norm <- pnorm(zz)
			tod_chidf1 <- pchisq(zz,1)
			tod_chidf2 <- pchisq(zz,2)
			
			1 - tod_norm -> norm1
			1 - tod_chidf1 -> chi1
			1 - tod_chidf2 -> chi2
		} else {
			NA -> norm1
			NA -> chi1
			NA -> chi2
			warning("NA's found!")
		}
		
		# create id variable: <id>_<obs>
		id_variab <- paste(identifiers[i], "_", 1:100, sep="")
		
		# combine results
		results <- data.frame(id = id_variab, maha = min_dist, prob = norm1, prob_chi1 = chi1, prob_chi2 = chi2)
		
		# writing matrixes with write.table is faster than data frames
		results <- as.matrix(results)
		
		# if output file exists, append to it. else create new
		if(file.exists(path_results)) {
			write.table(results, file = path_results, row.names = FALSE, quote = FALSE, col.names = FALSE, sep=",", append = TRUE)
		} else {
			write.table(results, file = path_results, row.names = FALSE, quote = FALSE, col.names = TRUE, sep=",")
		}	
	}
	
	# stop  messages
	message(paste("Ended", Sys.time()))
	stop_t <- Sys.time()
	time_t <- stop_t - start_t
	message(time_t);
}
 
# myDistanceMany(matrix_test, 1, 100, "maha_sample")

## MyDistance 