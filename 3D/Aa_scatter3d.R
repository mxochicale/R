#----------------------------------------------------------------
#
# Miguel P. Xochicale [http://mxochicale.github.io]
# Doctoral Researcher in Human-Robot Interaction
# University of Birmingham, U.K. (2014-2018)
#
#
#------------------------------------------------------------
#
# Source
# http://www.sthda.com/english/wiki/amazing-interactive-3d-scatter-plots-r-software-and-data-visualization


# load required packages
library(car)
# require(rgl)



data(iris)

sep.l <- iris$Sepal.Length
sep.w <- iris$Sepal.Width
pet.l <- iris$Petal.Length



# # 3D plot with the regression plane
# scatter3d(x = sep.l, y = pet.l, z = sep.w)


scatter3d(x = sep.l, y = pet.l, z = sep.w, groups = iris$Species,
          grid = FALSE)
