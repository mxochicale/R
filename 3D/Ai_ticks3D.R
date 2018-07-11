#----------------------------------------------------------------
#
# Miguel P. Xochicale [http://mxochicale.github.io]
# Doctoral Researcher in Human-Robot Interaction
# University of Birmingham, U.K. (2014-2018)
#
#
#------------------------------------------------------------
#
# Reference
# https://cran.r-project.org/web/packages/plot3D/plot3D.pdf
# page32

library(plot3D)

## =======================================================================
## Use of panel.first
## =======================================================================

par(mfrow = c(1, 1))
# A function that is called after the axes were drawn

panelfirst <- function(trans) {
	zticks <- seq(100, 180, by = 20)
	len <- length(zticks)
	XY0 <- trans3D(x = rep(1, len), y = rep(1, len), z = zticks,pmat = trans)
	XY1 <- trans3D(x = rep(1, len), y = rep(61, len), z = zticks,pmat = trans)
	segments(XY0$x, XY0$y, XY1$x, XY1$y, lty = 2)
	
	rm <- rowMeans(volcano)
	XY <- trans3D(x = 1:87, y = rep(ncol(volcano), 87),z = rm, pmat = trans)
	lines(XY, col = "blue", lwd = 2)
	}

persp3D(
	z = volcano, x = 1:87, y = 1: 61, 
	scale = FALSE, 
	theta = 10,
	expand = 0.2, 
	panel.first = panelfirst, 
	colkey = FALSE
	)


