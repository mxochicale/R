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
# http://www.sthda.com/english/wiki/impressive-package-for-3d-and-4d-graph-r-software-and-data-visualization


# load required packages
library("plot3D")

data(iris)

# x, y and z coordinates
x <- sep.l <- iris$Sepal.Length
y <- pet.l <- iris$Petal.Length
z <- sep.w <- iris$Sepal.Width


# scatter3D(x, y, z, clab = c("Sepal", "Width (cm)"))
#
# # type ="l" for lines only
# scatter3D(x, y, z, phi = 0, bty = "g", type = "l",
#          ticktype = "detailed", lwd = 4)

# # type ="b" for both points and lines
# scatter3D(x, y, z, phi = 0, bty = "g", type = "b",
#           ticktype = "detailed", pch = 20,
#           cex = c(0.5, 1, 1.5))
#


################################################################################
## 3D fancy Scatter plot with small dots on basal plane


# Add small dots on basal plane and on the depth plane
scatter3D_fancy <- function(x, y, z,..., colvar = z)
  {
   panelfirst <- function(pmat) {
      XY <- trans3D(x, y, z = rep(min(z), length(z)), pmat = pmat)
      scatter2D(XY$x, XY$y, colvar = colvar, pch = ".",
              cex = 2, add = TRUE, colkey = FALSE)

      XY <- trans3D(x = rep(min(x), length(x)), y, z, pmat = pmat)
      scatter2D(XY$x, XY$y, colvar = colvar, pch = ".",
              cex = 2, add = TRUE, colkey = FALSE)
  }
  scatter3D(x, y, z, ..., colvar = colvar, panel.first=panelfirst,
    colkey = list(length = 0.5, width = 0.5, cex.clab = 0.75))
}

#Fancy scatter plot:
scatter3D_fancy(x, y, z, pch = 16,
    ticktype = "detailed", theta = 15, d = 2,
    main = "Iris data",  clab = c("Petal", "Width (cm)") )
