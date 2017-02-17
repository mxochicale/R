#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#
#
# FileName:           jonh_schroeder.R
# FileDescription:
#
#
# DOWNLOAD THE DATA:
## pwd: /home/map479-admin/mxochicale/phd/r-code/getting_cleaning_data
## mkdir data
## cd data
## wget https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
## unzip getdata%2Fprojectfiles%2FUCI\ HAR\ Dataset.zip

#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# Miguel P. Xochicale [http://mxochicale.github.io]
# Doctoral Researcher in Human-Robot Interaction
# University of Birmingham, U.K. (2014-2018)
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#
#
#

#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# Loading Functions and Libraries and Setting up digits
library('dplyr') # for
library('data.table') # for manipulating data
library('tidyr') # for tidy data

options(digits=15)


main_path <- getwd()


r_scripts_path <- paste(main_path,sep="")
main_data_directory <- "/data/UCI\ HAR\ Dataset/"
data_path <-  paste(main_path,main_data_directory,sep="")



# Read subject files
dataSubjectTrain <- tbl_df( read.table( file.path(data_path, "train", "subject_train.txt")))
dataSubjectTest  <- tbl_df( read.table( file.path(data_path, "test", "subject_test.txt")))

# Read activity files
dataActivityTrain <- tbl_df( read.table( file.path(data_path, "train", "y_train.txt")))
dataActivityTest <- tbl_df( read.table( file.path(data_path, "test", "y_test.txt")))

# Read data files
dataTrain <- tbl_df( read.table( file.path(data_path, "train", "X_train.txt")))
dataTest <- tbl_df( read.table( file.path(data_path, "test", "X_test.txt")))

##############################################
# (1) Merges the training and the test sets to create one data set.

# for both activity and subject files this will merge the training and the test
# sets by row binding and rename variables "subject" and "activityNum"
alldataSubject <- rbind(dataSubjectTrain, dataSubjectTest)
setnames(alldataSubject, "V1", "subject")

alldataActivity <- rbind(dataActivityTrain, dataActivityTest)
setnames(alldataActivity, "V1", "activityNum")

#combine the DATA training and test files
dataTable <- rbind(dataTrain, dataTest)

#name variables according to feature e.g. (V1 = "tBodyAcc-mean()-X")
dataFeatures <- tbl_df(read.table(file.path(data_path, "features.txt")))
setnames(dataFeatures, names(dataFeatures), c("featureNum","featureName"))
colnames(dataTable) <- dataFeatures$featureName

#column names for activity labels
activityLabels <- tbl_df(read.table(file.path(data_path,"activity_labels.txt")))
setnames(activityLabels, names(activityLabels), c("activityNum","activityName"))

# #Merge columns
alldataSubAct <- cbind(alldataSubject, alldataActivity)
dataTable <- cbind(alldataSubAct, dataTable)




##############################################
# (2) Extracts only the measurements on the mean and standard deviation for
# each measurement
dataFeaturesMeanStd <- grep( "mean\\(\\)|std\\(\\)", dataFeatures$featureName, value=TRUE  ) # var name

#Taking only measurements for the mean and standard deviation and add "subject", "activityNum"
dataFeaturesMeanStd <- union( c("subject", "activityNum"), dataFeaturesMeanStd)
dataTable<- subset(dataTable, select=dataFeaturesMeanStd)


##############################################
# (3) Uses descriptive activity names to name the activities in the data set
##enter name of activity into dataTable
dataTable <- merge(activityLabels, dataTable, by="activityNum", all.x=TRUE)
dataTable$activityName <- as.character(dataTable$activityName)

##create dataTable with variable means sorted by subject and Activity
dataTable$activityName <- as.character(dataTable$activityName)
dataAggr <- aggregate(. ~ subject - activityName, data=dataTable, mean)
dataTable <- tbl_df(arrange(dataAggr, subject, activityName))


##############################################
# (4) Appropriately labels the data set with descriptive variables
#Names before
head(str(dataTable),2)

names(dataTable) <- gsub("std()", "SD", names(dataTable))
names(dataTable) <- gsub("mean()", "MEAN", names(dataTable))
names(dataTable) <- gsub("^t", "time", names(dataTable))
names(dataTable) <- gsub("^f", "frequency", names(dataTable))
names(dataTable) <- gsub("Acc", "Accelerometer", names(dataTable))
names(dataTable) <- gsub("Gyro", "Gyroscope", names(dataTable))
names(dataTable) <- gsub("Mag", "Magnitude", names(dataTable))
names(dataTable) <- gsub("BodyBody", "Body", names(dataTable))
#Names after
head(str(dataTable),6)


##############################################
# (5) From the data set in 4, creates a second, independent tidy data set
# with the average of each variable for each activity and each subject

write.table(dataTable, "TidyData_jonh_schroeder.txt", row.name=FALSE)




#############################################
setwd(r_scripts_path) ## go back to the r-script source path
