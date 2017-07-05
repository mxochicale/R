#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#
#
# FileName:     *.R
# Description:
# ExecutionTime:
#
#
#
# NOTE:
#
#
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# Miguel P. Xochicale [http://mxochicale.github.io]
# Doctoral Researcher in Human-Robot Interaction
# University of Birmingham, U.K. (2014-2018)
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++



#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# Loading Functions and Libraries and Setting up digits
library(data.table)
library(randomForest)


#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# Defining paths for main_path, r_scripts_path, ..., etc.
# setwd("../")
r_scripts_path <- getwd()




main_data_path <- paste("~/mxochicale/github/DataSets/MarketingData",sep="")
setwd(main_data_path)


# Start the clock!
start.time <- Sys.time()


################################################################################
################################################################################
## Modeling


## Read data

# termCrosssell<-read.csv(file="bank-full.csv",header = T)
termCrosssell<-fread(file="bank-full.csv",header = T)
# termCrosssell<-fread(file="bank.csv",header = T)
## Explore data frame
names(termCrosssell)




sample.ind <- sample(2,
                     nrow(termCrosssell),
                     replace = T,
                     prob = c(0.6,0.4))
cross.sell.dev <- termCrosssell[sample.ind==1,]
cross.sell.val <- termCrosssell[sample.ind==2,]



table(cross.sell.dev$y)/nrow(cross.sell.dev)
table(cross.sell.val$y)/nrow(cross.sell.val)

#Class of target or response variable is factor, so a classification Random Forest will be built.
cross.sell.dev$y <- as.factor(cross.sell.dev$y)
class(cross.sell.dev$y)

# cross.sell.dev <- cross.sell.dev[, lapply(.SD, as.factor), ]


###############
# Make Formula

varNames <- names(cross.sell.dev)
# Exclude ID or Response variable
varNames <- varNames[!varNames %in% c("y")]

# add + sign between exploratory variables
varNames1 <- paste(varNames, collapse = "+")

# Add response variable and convert to a formula object
rf.form <- as.formula(paste("y", varNames1, sep = " ~ "))




#################################
#Building Random Forest using R
# Now, we have a sample data and formula for building Random Forest model.
#  Let’s build 500 decision trees using Random Forest.

# y ~  .
cross.sell.rf <- randomForest(y ~  .,
                              data=cross.sell.dev,
                              ntree=500,
                              importance=T
                              )


# Error in randomForest.default(m, y, ...) :
#   NA/NaN/Inf in foreign function call (arg 1)
# In addition: Warning messages:
# 1: In data.matrix(x) : NAs introduced by coercion
# SOLUTION
# This error generally occurs in randomForest due to the following reasons:
#
#     If a variable passed is character
#     actual NaNs and Infs
#https://discuss.analyticsvidhya.com/t/error-in-randomforest-default-m-y-na-nan-inf-in-foreign-function-call-arg-1-in-r/1264/2

# plot(cross.sell.rf)









# Stop the clock!
end.time <- Sys.time()
end.time - start.time


################################################################################
################################################################################
setwd(r_scripts_path) ## go back to the r-script source path
