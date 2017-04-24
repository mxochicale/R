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


z <- seq(0, 10, 0.2)
x <- cos(z);
y <- sin(z)*z



par(mfrow = c(1, 4),  mar = c(1, 2, 1, 2))

scatter3D(x, y, z, colkey = FALSE, phi = 0, pch = 20, ticktype = "detailed")
text3D(x = cos(1:10), y = (sin(1:10)*(1:10) - 1), # add text
       z = 1:10, colkey = FALSE, add = TRUE,
       labels = LETTERS[1:10], col = "black")

# line plot (bty = "g" greyish background)
scatter3D(x, y, z, colkey = TRUE, phi = 0, bty = "g",
          type = "l", ticktype = "detailed", lwd = 4)

# points and lines
scatter3D(x, y, z, colkey = FALSE, phi = 0, bty = "g",
          type = "b", ticktype = "detailed", pch = 20)

# vertical lines
scatter3D(x, y, z, colkey = TRUE, phi = 0, bty = "g",
          type = "h", ticktype = "detailed")
