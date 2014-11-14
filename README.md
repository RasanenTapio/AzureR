AzureR
======

Experiment of R scripts for MS Azure Machine Learning studio

======
General idea would be:

1) Input: One dataset (timeseries).

2) Pre-processing data (if not done)

3) Fit several different ARIMA-models.

4) Test BIC or AIC.

5) Findl innovative and additive outliers from residuals of 1-3 ARIMA-models.

Output1: Return Outliers of best ARIMA-model
Output2: Return Outliers of 2nd best ARIMA-model
Output3: Return Outliers of 3rd best ARIMA-model

Alternatively:
Score outliers according to Output1-Output3 and return most likely outliers.
Output1: Most likely outliers.
