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
library(randomForest)


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


#Create kmeans model with this command: (You need to put the number how many
# cluster you want, in this case I use 3 because we already now in iris data we have 3 classes)

kc <- kmeans(x,3)



#After we know the result, we need to know how many error and missing data,
#so we need to compare the clustering result with the species/classes iris data.


table(y,kc$cluster)

# "Sepal.Length" "Sepal.Width"  "Petal.Length" "Petal.Width"  "Species"
plot(x[c("Sepal.Length", "Sepal.Width")], col=kc$cluster)
points(kc$centers[,c("Sepal.Length", "Sepal.Width")], col=1:3, pch=16, cex=3)






# Stop the clock!
end.time <- Sys.time()
end.time - start.time


################################################################################
################################################################################
setwd(r_scripts_path) ## go back to the r-script source path
