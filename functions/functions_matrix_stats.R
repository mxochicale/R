#------------------------------------------------------------
#   Functions
#   to perform statics with matrix
#
#
#
# Miguel P. Xochicale [http://mxochicale.github.io]
# Doctoral Researcher in Human-Robot Interaction
# University of Birmingham, U.K. (2014-2018)
#
#
#------------------------------------------------------------




############
# How to use
# add the following line to your main script
# for the directory where the functions and the R scripts lives, you have to add
# source(  paste(getwd(),"/functions.R",sep="") )


if (!require("matrixStats")) install.packages("matrixStats")
library('matrixStats')


colSD <- function(x, na.rm=TRUE) {
  if (na.rm) {
    n <- colSums(!is.na(x)) # thanks @flodel
  } else {
    n <- nrow(x)
  }
  colVar <- colMeans(x*x, na.rm=na.rm) - (colMeans(x, na.rm=na.rm))^2
  return(sqrt(colVar * n/(n-1)))
}



RMS <- function(num) {

return(  sqrt(sum(num^2)/length(num)) )
}
