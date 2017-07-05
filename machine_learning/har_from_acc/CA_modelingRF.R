#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#
#
# FileName:     *.R
# Description:
# ExecutionTime:
# NORMAL COMPUTATION:   Time difference of 1.072159 hours
# PARALELL COMPUTATION: Time difference of 3.660269 hours for fdt0
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
library(data.table) # for manipulating data
library(caret) #for findCorrelation():
library(randomForest)
library(doParallel)

#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# Defining paths for main_path, r_scripts_path, ..., etc.
# setwd("../")
r_scripts_path <- getwd()
main_data_path <- paste("/home/map479/mxochicale/github/DataSets/activity_recognition_accelerometer_dataset/data",sep="")
main_data_output_path <- paste("/home/map479/mxochicale/github/DataSets/activity_recognition_accelerometer_dataset/output",sep="")


## Setting up path and loading data
setwd(main_data_output_path)
# fdt <- fread(file="fdt0")
# fdt <- fread(file="fdt1")
fdt <- fread(file="fdt2")

#make label into factor for fdt
fdt[,label := factor(label) ]


# Start the clock!
start.time <- Sys.time()



################################################################################
################################################################################
## Modeling


# reduction of features that are hightly correlated in order to avoid higher computing times
corrmat <- cor(fdt[,-("label"),with = F]) #compute correlation matrix
#highcorr contains the first elements of all pairs of highly correlated features
highcorr <- findCorrelation(na.omit(corrmat), cutoff = 0.8, names = T, exact = T)
fdt <- fdt[,-highcorr,with=F]



#### RANDOM FOREST

# NORMAL COMPUTATION
rf.fit <- randomForest(label ~  .,
                        data = fdt,
                        importance = TRUE,
                        ntree=600,
                        nodesize = 4)



varImpPlot(rf.fit,n.var=40, main = "Variable Importance Plot", pch=16, scale = F)
imp <- importance(rf.fit )
plabel <- predict(rf.fit)
rf.cm <- confusionMatrix(fdt$label,plabel)


# > rf.cm
# Confusion Matrix and Statistics
#
#           Reference
# Prediction     1     2     3     4     5
#          1  4647   275   588   735    54
#          2    46 22024  2481  1797   324
#          3     3   141 73041   573   298
#          4     0   278   411 43625   178
#          5     0    34   972    69 74868
#
# Overall Statistics
#
#                Accuracy : 0.9593
#                  95% CI : (0.9585, 0.9601)
#     No Information Rate : 0.3407
#     P-Value [Acc > NIR] : < 2.2e-16
#
#                   Kappa : 0.9439
#  Mcnemar's Test P-Value : < 2.2e-16
#
# Statistics by Class:
#
#                      Class: 1 Class: 2 Class: 3 Class: 4 Class: 5
# Sensitivity           0.98957  0.96800   0.9425   0.9322   0.9887
# Specificity           0.99258  0.97729   0.9932   0.9952   0.9929
# Pos Pred Value        0.73774  0.82573   0.9863   0.9805   0.9858
# Neg Pred Value        0.99978  0.99637   0.9710   0.9827   0.9944
# Prevalence            0.02065  0.10003   0.3407   0.2057   0.3329
# Detection Rate        0.02043  0.09682   0.3211   0.1918   0.3291
# Detection Prevalence  0.02769  0.11726   0.3256   0.1956   0.3339
# Balanced Accuracy     0.99107  0.97265   0.9679   0.9637   0.9908




# # PARALELL COMPUTATION
# registerDoParallel(cores=4)
# ntree <- 600 #split between number of nodes/cores
# rf.par <- foreach(ntreepar=rep(ntree/4, 4), .combine=combine, .packages='randomForest') %dopar%
#   randomForest(label ~  ., data = fdt, importance = T, ntree=ntreepar)
#
# varImpPlot(rf.par,n.var=40, main = "Variable Importance Plot", pch=16, scale = F)
# imp <- importance(rf.par)
# plabel <- predict(rf.par)
# rf.cm <- confusionMatrix(fdt$label,plabel)
# # > rf.cm <- confusionMatrix(fdt$label,plabel)
# # Error in confusionMatrix.default(fdt$label, plabel) :
# #   The data contain levels not found in the data.




# Stop the clock!
end.time <- Sys.time()
end.time - start.time


################################################################################
################################################################################
setwd(r_scripts_path) ## go back to the r-script source path
