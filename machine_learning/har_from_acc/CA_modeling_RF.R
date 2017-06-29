#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#
#
# FileName:     *.R
# Description:
# ExecutionTime: 3.660269 hours
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
fdt <- fread(file="featuresdatatable")
# fdtb <- fread(file="fdt")



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




## RANDOM FOREST

# rf.fit <- randomForest(label ~  ., data = fdt, importance = T, ntree=600, nodesize = 4)
# (proc.time() - ptm)/60
# varImpPlot(rf.fit,n.var=40)
# imp <- importance(rf.fit )
# plabel <- predict(rf.fit)
# rf.cm <- confusionMatrix(fdt$label,plabel)



registerDoParallel(cores=4)
ntree <- 600 #split between number of nodes/cores
rf.par <- foreach(ntreepar=rep(ntree/4, 4), .combine=combine, .packages='randomForest') %dopar%
  randomForest(label ~  ., data = fdt, importance = T, ntree=ntreepar)


varImpPlot(rf.par,n.var=40)
imp <- importance(rf.par)
plabel <- predict(rf.par)
rf.cm <- confusionMatrix(fdt$label,plabel)

 # varImpPlot(rf.par,n.var=35, main = "Variable Importance Plot", pch=16, scale = F)

# Stop the clock!
end.time <- Sys.time()
end.time - start.time


################################################################################
################################################################################
setwd(r_scripts_path) ## go back to the r-script source path
