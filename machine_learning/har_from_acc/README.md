Example of HAR from ACC data
---

I am following the example of  [Human Activity Recognition from Accelerometer Data](http://rstudio-pubs-static.s3.amazonaws.com/165795_92b97c49b5a74d04940670469a9a40f2.html)
to replicate the setup and data preparation, feature extraction and modeling.

# Downloading the data
```
cd  ~/mxochicale/github/DataSets/ && mkdir -p activity_recognition_accelerometer_dataset && cd activity_recognition_accelerometer_dataset
wget http://archive.ics.uci.edu/ml/machine-learning-databases/00287/Activity%20Recognition%20from%20Single%20Chest-Mounted%20Accelerometer.zip
unzip Activity\ Recognition\ from\ Single\ Chest-Mounted\ Accelerometer.zip
mv Activity\ Recognition\ from\ Single\ Chest-Mounted\ Accelerometer data
rm -rf __MACOSX/
```

# R code
* lowpass_butterworth.R
* A_setup_preparation.R
* B_feature_extraction.R
* CA_modelingRF.R7
* CB_modelingGBT.R
* CC_modelingWkNN.R


# packages dependencies

for kurtosis and skewness:
install.packages("moments", repos='https://www.stats.bris.ac.uk/R/', dependencies = TRUE)

for entropy:
install.packages("entropy", repos='https://www.stats.bris.ac.uk/R/', dependencies = TRUE)

for findCorrelation(): # it takes a while (~10-20 minutes)
install.packages("caret", repos='https://www.stats.bris.ac.uk/R/', dependencies = TRUE)

for randomForest
install.packages("randomForest", repos='https://www.stats.bris.ac.uk/R/', dependencies = TRUE)

install.packages("doParallel", repos='https://www.stats.bris.ac.uk/R/', dependencies = TRUE)

install.packages("foreach", repos='https://www.stats.bris.ac.uk/R/', dependencies = TRUE)

it takes a while (like 10-15 minutes)
install.packages("xgboost", repos='https://www.stats.bris.ac.uk/R/', dependencies = TRUE)

install.packages("kknn", repos='https://www.stats.bris.ac.uk/R/', dependencies = TRUE)


# TODO
* I have notice that I got slightly different results from
[L. Zertuche](http://rstudio-pubs-static.s3.amazonaws.com/165795_92b97c49b5a74d04940670469a9a40f2.html)
in the confusion matrixes, the classification accuracies and different feature
order for the variable of importance plots. With that in mind, I believe that
further exploration has to be made in order to understand about the differences of
performances between methods and maybe(machines).
