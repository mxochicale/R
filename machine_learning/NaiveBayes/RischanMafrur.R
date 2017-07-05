#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#
#
# FileName:     *.R
# Description:
# ExecutionTime:
# 3.660269 hours for fdt0
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
library("caret")


#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# Defining paths for main_path, r_scripts_path, ..., etc.
# setwd("../")
r_scripts_path <- getwd()




# Start the clock!
start.time <- Sys.time()


################################################################################
################################################################################
## Modeling




head(iris)
names(iris)

#In this we assign the data from column 1-4 (features) to variable x, and the class to variable y
x = iris[,-5]
y = iris$Species



# Creating the model with cross validation =10
model = train(x,y,'nb',trControl=trainControl(method='cv',number=10))

# use predict for getting prediction value, and result class:
predict(model$finalModel,x)

#  The last one, we need to know how many error classified,
# so we need to compare the result of prediction with the class/iris species.
table(predict(model$finalModel,x)$class,y)


naive_iris <- NaiveBayes(iris$Species ~ ., data = iris)
plot(naive_iris)


# Stop the clock!
end.time <- Sys.time()
end.time - start.time


################################################################################
################################################################################
setwd(r_scripts_path) ## go back to the r-script source path
