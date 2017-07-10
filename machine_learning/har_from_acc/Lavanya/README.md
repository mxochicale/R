Human Activity Recognition using smartphones
---

Lavanya, Reyne and Kalpana, August 15, 2015  
http://rstudio-pubs-static.s3.amazonaws.com/100601_62cc5079d5514969a72c34d3c8228a84.html


The following project is good as a reference for modeling your data
using different algorithms*, however, the code is not available for replication purposes
https://rpubs.com/mlavanya92/Project



```
## Call:
## C5.0.formula(formula = Activity ~ `tGravityAcc-mean()-X`
##  + `tGravityAcc-mean()-Y` + `tGravityAcc-energy()-Y`
##  + `tGravityAcc-energy()-Z` + subject, data = newTraindata)
```

```
## Call:
## C5.0.formula(formula = Activity ~ `angle(Y,gravityMean)` + subject
##  + `fBodyAccMag-energy()` + `tGravityAcc-energy()-Y`
##  + `fBodyAcc-bandsEnergy()-1,8`, data = newTraindata)
```



```
## Call:
## C5.0.formula(formula = Activity ~ ., data = newTraindata, rules = TRUE)
```

```
## Call:
## C5.0.formula(formula = Activity ~ `tBodyAccJerk-max()-X`
##  + `tBodyAccJerk-arCoeff()-Z,3` + subject, data = newTraindata, rules
##  = TRUE)
```


```
## Call:
## multinom(formula = Activity ~ ., data = newTraindata)
```


```
## Call:
## multinom(formula = Activity ~ subject + `angle(X,gravityMean)` +
##     `angle(Y,gravityMean)` + `fBodyAccMag-energy()` + `tGravityAcc-energy()-Y` +
##     `fBodyAcc-bandsEnergy()-1,8`, data = newTraindata)
```


```
## Call:
## multinom(formula = Activity ~ subject + +poly(`angle(X,gravityMean)`,
##     4) + poly(`angle(Y,gravityMean)`, 4) + `fBodyAccMag-energy()` +
##     `tGravityAcc-energy()-Y` + I(`tGravityAcc-energy()-Y`^2) +
##     `fBodyAcc-bandsEnergy()-1,8`, data = newTraindata)
```

```
Rpart algorithm
```
