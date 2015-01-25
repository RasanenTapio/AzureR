# Used in logit tree
# Remove columns and use split to test

trainset <- maml.mapInputPort(1) # class: data.frame
testset <- maml.mapInputPort(2) # class: data.frame

message("Read Success")

###### PARAMETERS ############
PAR_other_limit <- 0.01
PAR_plot <- FALSE

# ...

# Select data.frame to be sent to the output Dataset port
maml.mapOutputPort("tulos2");