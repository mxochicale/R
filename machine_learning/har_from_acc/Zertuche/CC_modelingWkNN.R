#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#
#
# FileName:     *.R
# Description:
# ExecutionTime: Time difference of 33.44067 mins
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
library(kknn)


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

trainix <- createDataPartition(fdt$label, p = .85,    list = FALSE, times = 1)
traindt <- fdt[trainix, ]
testdt <- fdt[-trainix, ]

wknn <- kknn(label ~ . , train = traindt, test = testdt, kernel = "optimal", k=5)
wknn.cm <- confusionMatrix(wknn$fitted.values, testdt$label)

# Stop the clock!
end.time <- Sys.time()
end.time - start.time


################################################################################
################################################################################
setwd(r_scripts_path) ## go back to the r-script source path
