# Import set to reduce size and key value combinations
reduceset <- maml.mapInputPort(1) # class: data.frame
keyset <- maml.mapInputPort(2) # class: data.frame

# add a new level for all variables of trainset
for (i in 2:dim(trainset)[2]){
     trainset[,i] <- as.factor(trainset[,i])
     levels(trainset[,i]) <- c(levels(trainset[,i]), "other")
}




# Output processed reduceset
maml.mapOutputPort("betterset");