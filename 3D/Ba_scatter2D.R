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
# 3D fancy Scatter plot with small dots on basal plane
# http://www.sthda.com/english/wiki/impressive-package-for-3d-and-4d-graph-r-software-and-data-visualization


library(plot3D)




# # x, y coordinates
# set.seed(1234)
# x  <- sort(rnorm(100))
# y  <- runif(100)
# # Variable for coloring points
# col.v <- sqrt(x^2 + y^2)
#
# scatter2D(x, y, colvar = col.v, pch = 16, bty ="n",
#           type ="b")


minval <- 0
maxval <- 20
z <- seq(minval, maxval, 0.2)#z <- seq(-10, 10, 0.01)
x <- cos(z)
y <- sin(z)


scatter2D(x, y, colvar = z, pch = 16, bty ="n",
         type ="b", lwd= 4)
