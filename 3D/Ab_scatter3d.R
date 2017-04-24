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
# https://stanford.edu/class/cme195/lectures/Lecture5.html#/section-5


library(plot3D)

dim(volcano)

# Reduce the resolution
Volcano <- volcano[seq(1, nrow(volcano), by = 3),
                   seq(1, ncol(volcano), by = 3)]



par(mfrow = c(2, 2), mar = c(3, 3, 3, 3)) # mar = c(bottom, left, top, right)
contour2D(Volcano, lwd = 2)
image2D(Volcano, clab = "height [m]")   # set the color label
image2D(Volcano, facets = FALSE)        # don't fill in the tiles
image2D(Volcano, contour = TRUE)        # include contours
