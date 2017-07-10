#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#
#
# FileName:     *.R
# Description:
# ExecutionTime: Time difference of 12.76124 mins
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
library(data.table) # for manipulating data
library("caret")# for createDataPartition()
library(xgboost)
library(ggplot2)


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

#### xgboost trees
trainix <- createDataPartition(fdt$label, p = .85,    list = FALSE, times = 1)
traindt <- fdt[trainix, ]
testdt <- fdt[-trainix, ]
xgtrain <- xgb.DMatrix(as.matrix(traindt[, -"label", with = F]), label = as.numeric(traindt$label)-1)
xgtest <- xgb.DMatrix(as.matrix(testdt[, -"label", with = F]), label = as.numeric(testdt$label)-1 )
wl <- list(eval = xgtest)


#train
xgbt <- xgb.train(data = xgtrain, max.depth = 7, eta = .4 , nrounds=250, watchlist = wl,
                  objective = "multi:softmax", num_class=5, early.stop.round = 15,
                  verbose = 1, maximize = F)

# The early.stop.round value determines how many consecutive rounds of accuracy
# decline we allow before halting the learning and keeping the last best score,
# very useful to save some time!

#test
xgpred <- predict(xgbt,xgtest)
xgpred <- as.factor(as.character(xgpred))
levels(xgpred) <- levels(fdt$label)
xg.cm <- confusionMatrix(testdt$label, xgpred)



#compute importance of model features
xgb.imp <- xgb.importance(feature_names = names(fdt), model=xgbt)

#diy importance plot
nfeatures=25
ggplot(data = xgb.imp[1:nfeatures], aes(y=Gain, x=Feature)) + geom_bar(stat="identity", width = 0.5) +
                             scale_x_discrete(limits=xgb.imp[nfeatures:1,Feature]) +
                             theme(text = element_text(size=14),axis.text = element_text(size=14)) +
                             ggtitle("Importance Plot for Gradient Boosted Trees") +
                             coord_flip()


# Stop the clock!
end.time <- Sys.time()
end.time - start.time


################################################################################
################################################################################
setwd(r_scripts_path) ## go back to the r-script source path
