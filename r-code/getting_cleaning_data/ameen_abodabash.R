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


## Activities data
activitiesData <- rbind(## combine training & test rows then join with activities labels
  read.table( file.path(data_path, "train", "y_train.txt"), header=F ),
  read.table( file.path(data_path, "test", "y_test.txt"), header=F )) %>%
  ## left join activities labels to be used as described value
  left_join(read.table( file.path(data_path, "activity_labels.txt"), header=F ), by = "V1")

## Subjects data
subjectsData <-rbind(## combine training and test rows
   read.table( file.path(data_path, "train", "subject_train.txt"), header=F) ,
   read.table( file.path(data_path, "test", "subject_test.txt"), header=F)
   )


## Features data
featuresData <-rbind(## combine training and test rows
  read.table( file.path(data_path, "train", "X_train.txt"), header=F) ,
  read.table( file.path(data_path, "test", "X_test.txt"), header=F)
  )


#tidying activities data
activitiesDF <- activitiesData %>%
                select(V2)  %>% ##select only Activity Name column - no need for IDs
                setNames("activity") ## set new DF col name

#tidying activities data
subjectsDF <- subjectsData %>%
              setNames("subject") ## set new DF col name

# # #tidying features data
# featuresDF <- featuresData %>%
#                ## Select only measuraments with mean and ad using grep
#                ## resulting around 66 cols from 500+ cols
              #  select(num_range( "V", grep(x=featturesLabels$V2, "mean\\(\\)|std\\(\\)" ) ))




#############################################
setwd(r_scripts_path) ## go back to the r-script source path
