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


minval <- 0
maxval <- 20
z <- seq(minval, maxval, 0.2)#z <- seq(-10, 10, 0.01)
x <- cos(z)
y <- sin(z)


colvar <- z
panelfirst <- function(pmat) {

XY <- trans3D(x, y, z = rep(min(z), length(z)), pmat = pmat)
scatter2D(XY$x, XY$y, colvar = colvar, pch = ".", type='l', lwd=5,
           cex = 2, add = TRUE, colkey = FALSE)

YZ <- trans3D(x = rep(min(x), length(x)), y, z, pmat = pmat)
scatter2D(YZ$x, YZ$y, colvar = colvar, pch = ".", type='l', lwd=5,
          cex = 2, add = TRUE, colkey = FALSE)


XZ <- trans3D(x, y = rep(min(y), length(y)), z, pmat = pmat)
scatter2D(XZ$x, XZ$y, colvar = colvar, pch = ".", type='l', lwd=5,
          cex = 2, add = TRUE, colkey = FALSE)
}

scatter3D(x, y, z, colvar = colvar, bty = "u", type = "b", lwd=5, panel.first=panelfirst,
	axis.scales = FALSE,
	xlim=c(-2,2),ylim= c(-2,2),zlim=c(-10,30),
    colkey = list(length = 0.5, width = 0.5, cex.clab = 0.75)
  )



