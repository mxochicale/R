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
#


library(plot3D)



par(mfrow = c(1, 4), mar = c(5, 3, 5, 3))
### mfrow = c(a?, b?)
# Set up plotting in a? rows and b? columns, plotting along rows first.
### mar = c(bottom, left, top, right)
# - Set the margins for a single figure. Note that this parameter can
#   be set on a per-figure basis since each figure can have unique margins.
# - If you do not redefine the mar parameter after this, all figures will
#   use this setting.
# http://rgraphics.limnology.wisc.edu/rmargins_mfcol.php



# col.v <- sqrt(x^2 + y^2)

minval <- 0
maxval <- 20

## Variable for coloring points
# z <- seq(-10, 10, 0.01)
col.v <- seq(minval, maxval, 0.2)

# x, y coordinates
x <- cos(col.v)
# y <- sin(col.v)
y <- sin(col.v)*col.v



scatter3D(
  x, y, col.v, colvar = col.v, bty = "u", type = "b", lwd=5,
	axis.scales = TRUE,
	# xlim=c(-1,1),ylim= c(-1,1),zlim=c(-10,30),
  main = "XYZ",
  xlab = 'X', ylab ='Y', zlab = 'Z',
  colkey = list(length = 0.3, width = 0.8, cex.clab = 0.75)
  )


scatter2D(
  x, y, colvar = col.v, bty = "n", pch = ".",
  type='l', lwd=5,
  cex = 5, colkey = TRUE,
  main = "XY",
  xlab = 'X', ylab ='Y'
  )

scatter2D(
  y, col.v, colvar = col.v, bty = "n", pch = ".",
  type='l', lwd=5,
  cex = 5, colkey = TRUE,
  main = "YZ",
  xlab = 'Y', ylab ='Z'
  )

scatter2D(
  x, col.v, colvar = col.v, bty = "n", pch = ".",
  type='l', lwd=5,
  cex = 5, colkey = TRUE,
  main = "XZ",
  xlab = 'X', ylab ='Z'
  )
