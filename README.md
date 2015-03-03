AzureR
======

Experiment of R scripts for MS Azure Machine Learning studio and general R scripts and functions.

======
Outlier detection in time series

1. Input: One dataset (time series).
2. Pre-processing data (if not done)
3. Fit several different ARIMA-models and select best three. Use AIC or LL as criterion.
5. Find innovative and additive outliers from residuals of 1-3 ARIMA-models. (Add a feature to detect level shifts?)
6. Generate summary tables and output.
7. Output: Output most likely outliers. (Score outliers according to three models and return most likely outliers.)

Outlier detection with subsampling and Mahalanobis distance

1. Sample small number of rows from matrix (for example n = 3): X
2. Calculate covariance matrix
3. Calculate inverse of covariance matrix
4. Calculate Mahalanobis distances for all observations to sample X
5. Select minimum distance
6. Stantardize and z-test
