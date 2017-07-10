#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#
#
# FileName:     *.R
# Description:
# ExecutionTime: ~ 10.50 seconds
#
# REFERENCE
# Lavanya, Reyne and Kalpana, August 15, 2015
# http://rstudio-pubs-static.s3.amazonaws.com/100601_62cc5079d5514969a72c34d3c8228a84.html
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
library(ggplot2)



#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# Defining paths for main_path, r_scripts_path, ..., etc.
# setwd("../")
r_scripts_path <- getwd()



################################################################################
################################################################################
## Setup and Preparation of Data

# Start the clock!
start.time <- Sys.time()



main_data_path <- "/home/map479/mxochicale/github/DataSets/UCI_HAR/UCI HAR Dataset"
setwd(main_data_path)

temp = fread("activity_labels.txt")
activityLabels = as.character(temp$V2)
temp = fread("features.txt")
attributeNames = temp$V2


Xtrain = fread("train/X_train.txt")
names(Xtrain) = attributeNames
Ytrain = fread("train/y_train.txt")
names(Ytrain) = "Activity"


Ytrain$Activity = as.factor(Ytrain$Activity)
levels(Ytrain$Activity) = activityLabels

trainSubjects = fread("train/subject_train.txt")
names(trainSubjects) = "subject"
trainSubjects$subject = as.factor(trainSubjects$subject)
train = cbind(Xtrain, trainSubjects, Ytrain)


Xtest = fread("test/X_test.txt")
names(Xtest) = attributeNames
Ytest = fread("test/y_test.txt")
names(Ytest) = "Activity"
Ytest$Activity = as.factor(Ytest$Activity)
levels(Ytest$Activity) = activityLabels
testSubjects = fread("test/subject_test.txt")
names(testSubjects) = "subject"
testSubjects$subject = as.factor(testSubjects$subject)
test = cbind(Xtest, testSubjects, Ytest)





#
#
#
# train$Partition = "Train"
# test$Partition = "Test"
#
# library(ggplot2)
# all = rbind(train,test)
#
# all$Partition = as.factor(all$Partition)
#
#
#
# #The data comes to us partitioned by human subject with 9 subjects
# #held out in test. We can use this partition of the data and use
# #these subjects as our hold out sample.
# qplot(data = all, x = subject, fill = Partition)
#
# #The graph actually shows the count of each subject and the activities carried
# #out in each case.We observe that the distribution of examples is fairly evently
# #distributed accross experimental subjects and activity types.
# qplot(data = all , x = subject, fill = Activity)
#
#
#


# Stop the clock!
end.time <- Sys.time()
end.time - start.time



#############################################
setwd(r_scripts_path) ## go back to the r-script source path
