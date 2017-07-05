#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#
#
# FileName:     *.R
# Description:
# ExecutionTime:
# 3.660269 hours for fdt0
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
library(randomForest)


#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# Defining paths for main_path, r_scripts_path, ..., etc.
# setwd("../")
r_scripts_path <- getwd()




# Start the clock!
start.time <- Sys.time()


################################################################################
################################################################################
## Modeling



#Split iris data to Training data and testing data
ind <- sample(2,nrow(iris),replace=TRUE,prob=c(0.7,0.3))
trainData <- iris[ind==1,]
testData <- iris[ind==2,]


#Generate Random Forest learning treee

iris_rf <- randomForest(Species~.,
                        data=trainData,
                        ntree=100,
                        proximity=TRUE)


table(predict(iris_rf),trainData$Species)

#Try to print Random Forest model and see the importance features
print(iris_rf)
plot(iris_rf)

importance(iris_rf)
varImpPlot(iris_rf,n.var=4, main = "Variable Importance Plot", pch=16, scale = F)


##############################################
#Try to build random forest for testing data
irisPred<-predict(iris_rf,newdata=testData)
table(irisPred, testData$Species)

#Try to see the margin, positive or negative, if positif it means correct classification
plot(margin(iris_rf,testData$Species))





# Stop the clock!
end.time <- Sys.time()
end.time - start.time


################################################################################
################################################################################
setwd(r_scripts_path) ## go back to the r-script source path
