#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#
#
# FileName:           ameen_abodabash.R
# FileDescription:
#http://rstudio-pubs-static.s3.amazonaws.com/244526_c102f52d8aea34ffda2ea35c2c9829114.html
#http://rstudio-pubs-static.s3.amazonaws.com/244526_c102f52d8aea34ffda2ea35c2c9829114.html
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



## Subjects data
alldataSubject <-rbind(## combine training and test rows
   fread( file.path(data_path, "train", "subject_train.txt"), header=F) ,
   fread( file.path(data_path, "test", "subject_test.txt"), header=F)
   )
setnames(alldataSubject, names(alldataSubject), "subject")

## Activities data
alldataActivity <- rbind(## combine training & test rows then join with activities labels
  fread( file.path(data_path, "train", "y_train.txt"), header=F ),
  fread( file.path(data_path, "test", "y_test.txt"), header=F ))
setnames(alldataActivity, "V1", "activityNum")


## Data table
dataTable <-rbind(## combine training and test rows
  fread( file.path(data_path, "train", "X_train.txt"), header=F) ,
  fread( file.path(data_path, "test", "X_test.txt"), header=F)
  )

#name variables according to feature e.g. (V1 = "tBodyAcc-mean()-X")
dataFeatures <- fread(file.path(data_path,"features.txt"))
setnames(dataFeatures, names(dataFeatures), c("featureNum","featureName"))
colnames(dataTable) <- dataFeatures$featureName   ## Subtitute col names

#column names for activity labels
activityLabels <- fread( file.path(data_path, "activity_labels.txt"), header=F )
setnames(activityLabels, names(activityLabels), c("activityNum","activityName"))


# #Merge columns
alldataSubAct <- cbind(alldataSubject, alldataActivity)
alldataTable <- cbind(alldataSubAct, dataTable)




##############################################
# (2) Extracts only the measurements on the mean and standard deviation for
# each measurement
dataFeaturesMeanStd <- grep( "mean\\(\\)|std\\(\\)", dataFeatures$featureName, value=TRUE  ) # var name
# ##Taking only measurements for the mean and standard deviation and add "subject", "activityNum"
dataFeaturesMeanStd <- union( c("subject", "activityNum"), dataFeaturesMeanStd)
alldataTable<- subset(alldataTable, select=dataFeaturesMeanStd)


###############################################
## (3) create dataTable with variable means sorted by subject and Activity
alldataTable <- merge(activityLabels, alldataTable, by="activityNum", all.x=TRUE)
alldataTable$activityName <- as.character(alldataTable$activityName)

##create dataTable with variable means sorted by subject and Activity
dataAggr <- aggregate(. ~ subject - activityName, data=alldataTable, mean)
alldataTable <- arrange(dataAggr, subject, activityName)



##############################################
# (4) Appropriately labels the data set with descriptive variables
names(alldataTable) <- gsub("std()", "SD", names(alldataTable))
names(alldataTable) <- gsub("mean()", "MEAN", names(alldataTable))
names(alldataTable) <- gsub("^t", "time", names(alldataTable))
names(alldataTable) <- gsub("^f", "frequency", names(alldataTable))
names(alldataTable) <- gsub("Acc", "Accelerometer", names(alldataTable))
names(alldataTable) <- gsub("Gyro", "Gyroscope", names(alldataTable))
names(alldataTable) <- gsub("Mag", "Magnitude", names(alldataTable))
names(alldataTable) <- gsub("BodyBody", "Body", names(alldataTable))

head(str(alldataTable),6)


##############################################
# (5) From the data set in 4, creates a second, independent tidy data set
# with the average of each variable for each activity and each subject

write.table(dataTable, "TidyData_mxochicale.txt", row.name=FALSE)






#############################################
setwd(r_scripts_path) ## go back to the r-script source path
