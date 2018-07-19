#----------------------------------------------------------------
#
# Miguel P. Xochicale [http://mxochicale.github.io]
# Doctoral Researcher in Human-Robot Interaction
# University of Birmingham, U.K. (2014-2018)
#
#
#------------------------------------------------------------
#


library(plot3D)


pdf(file='save.pdf')

persp3D(
	z = volcano, zlim = c(-60, 200), 
	phi = 20, 
	colkey = list(length = 0.2, width = 0.4, shift = 0.15,cex.axis = 0.8, cex.clab = 0.85), 
	lighting = TRUE,  #If notFALSEthe facets will be illuminated, and colors may appear more bright
	lphi = 90,
	clab = c("","height","m"), 
	bty = "f", 
	plot = TRUE)

# create gradient in x-direction
Vx <- volcano[-1, ] - volcano[-nrow(volcano), ]

# add as image with own color key, at bottom
image3D(
	z = -60, 
	colvar = Vx/10, 
	add = TRUE,
	colkey = list(length = 0.2, width = 0.4, shift = -0.15,cex.axis = 0.8, cex.clab = 0.85),
	clab = c("","gradient","m/m"), 
	plot = TRUE)

# add contour
contour3D(
	z = -60+0.01, 
	colvar = Vx/10, 
	add = TRUE,
	col = "black", 
	plot = TRUE
	)


dev.off()



