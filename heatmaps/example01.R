#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#
#
# FileName:           example01.R
# FileDescription:
# http://www.sthda.com/english/wiki/ggplot2-quick-correlation-matrix-heatmap-r-software-and-data-visualization 
# 
#
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# Miguel P. Xochicale [http://mxochicale.github.io]
# Doctoral Researcher in Human-Robot Interaction
# University of Birmingham, U.K. (2014-2018)
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++



#################
# Start the clock!
start.time <- Sys.time()


###############
# Load Packages
require(ggplot2)
require(reshape2)

################################################################################
# (1) Defining paths for main_path, r_scripts_path, ..., etc.
r_scripts_path <- getwd()
setwd("../")
main_repository_path <- getwd()
setwd("../")
github_path <- getwd()
setwd("../")
main_path <- getwd()


# outcomes_path <- paste(main_repository_path,"/DataSets/vix",sep="")


### Read data
mydata <- mtcars[, c(1,3,4,5,6,7)]
head(mydata)


### Compute the correlation matrix
cormat <- round(cor(mydata),2)
head(cormat)


### Create the correlation heatmap with ggplot2
melted_cormat <- melt(cormat)
head(melted_cormat)


ggplot(data=melted_cormat, aes(x=Var1, y=Var2, fill=value)) +
	geom_tile()



#################
# Stop the clock!
end.time <- Sys.time()
end.time - start.time


################################################################################
setwd(r_scripts_path) ## go back to the r-script source path
