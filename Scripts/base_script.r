# Map 1-based optional input ports to variables
dataset1 <- maml.mapInputPort(1) # class: data.frame

# Data frame
aineisto <- data.frame(dataset1);

# ARIMA-models and their BIC - loop over k = 1 to 3 and j = 1 to 3 (test)

# Select data.frame to be sent to the output Dataset port
maml.mapOutputPort("ulos");
