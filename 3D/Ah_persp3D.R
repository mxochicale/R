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
# 6. Composite figure
# https://cran.r-project.org/web/packages/plot3D/vignettes/plot3D.pdf



library(plot3D)



ii <- which(Hypsometry$x > -50 & Hypsometry$x < -20) 
jj <- which(Hypsometry$y >  10 & Hypsometry$y <  40) 
zlim <- c(-50000, 0) 

# Actual bathymetry, 4 times increased resolution, with contours
persp3D(
	z = Hypsometry$z[ii,jj],

	xlab = "longitude", 
	ylab = "latitude", 
	zlab = "depth", 
	clab = "depth, m",
	cex.axis = 1.2, # change the font size of the values in each of the axis 
	cex.lab = 2,# change font size of the labels 

	ticktype = "detailed",
	
	#bty ="bl",   #Black panel background wiht blank grid 
	#bty ="bl2",   #The perspective figure is made with black side-panels (bty)
	#bty = "g", #greyish background
	#bty = "b", # blank background
	bty = "b2", # white with gray grid background
	#bty = "f", # float cube blank grid background
	#bty ="u", #white panels
	#bty ="n", #no panels
	
	expand = 0.5, 
	d = 2, 
	phi = 20, 
	theta = 30, 
	resfac = 0.4,# The resolution is increased(resfac) to make smoother image
	contour = list(col = "grey", side = c("zmin", "z")),
	#contour = list(col = "grey", side = c("z")),
	zlim = zlim, 
	colkey = list(side = 1, length = 0.5), 
	lighting = FALSE #If notFALSEthe facets will be illuminated, and colors may appear more bright
	)

#Grey contour lines are addedon the bottom panel ("zmin") 
#and on the persp plot itself ("z"). 
