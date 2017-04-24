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
# https://stanford.edu/class/cme195/lectures/Lecture5.html#/d-scatter-plots


library(plot3D)

par(mfrow = c(1, 3),  mar = c(2, 2, 2, 2))
z <- seq(0, 10, 0.2)
x <- cos(z);
y <- sin(z)*z



scatter3D(x, y, z)
scatter3D(x, y, z, colkey = FALSE, phi = 0, ticktype = "detailed")
scatter3D(x, y, z, colkey = FALSE, phi = 0, pch = 20, ticktype = "detailed")
