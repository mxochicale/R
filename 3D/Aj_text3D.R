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
# page75

library(plot3D)

## =======================================================================
## text3D to label x- and y axis
## =======================================================================

par(mfrow = c(1, 1))

hist3D (x = 1:5, y = 1:4, z = VADeaths,
	bty = "g", phi = 20,  
	theta = -60,
	xlab = "", 
	ylab = "", 
	zlab = "", 
	main = "VADeaths",
	col = "#0072B2", 
	border = "black", 
	shade = 0.8,
	ticktype = "detailed", 
	space = 0.15, 
	d = 2, 
	cex.axis = 1e-9)

text3D(x = 1:5, y = rep(0.5, 5), z = rep(3, 5),
	labels = rownames(VADeaths),
	add = TRUE, adj = 0)

text3D(x = rep(1, 4),   y = 1:4, z = rep(0, 4),
	labels  = colnames(VADeaths),
	add = TRUE, adj = 1)


