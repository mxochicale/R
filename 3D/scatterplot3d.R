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
# https://casoilresource.lawr.ucdavis.edu/software/r-advanced-statistical-package/interactive-3d-plots-rgl-package


# load required packages
require(scatterplot3d)
require(rgl)



# simple function for
rng_sphere <- function(d, type='rgl')
{

n <- length(d)
nn <- n - 3

# init our x,y,z coordinate arrays
x <- array(dim=nn)
y <- array(dim=nn)
z <- array(dim=nn)

# init red,green,blue color component arrays
cr <- array(dim=nn)
cg <- array(dim=nn)
cb <- array(dim=nn)


# convert lagged random numbers from d into spherical coordinates
# then convert to cartesian x,y,z coordinates for simple display
for (i in 1:nn)
{
theta <- 2*pi*d[i]
phi <- pi*d[i+1]
r <- sqrt(d[i+2])

x[i] <- r * sin(theta) * cos(phi)
y[i] <- r * sin(theta) * sin(phi)
z[i] <- r * cos(theta)

# give each location a color based on some rules
cr[i] <- d[i] / max(d)
cg[i] <- d[i+1] / max(d)
cb[i] <- d[i+2] / max(d)

} # end function



if( type == 'rgl')
{
# setup rgl environment:
zscale <- 1

# clear scene:
clear3d("all")

# setup env:
bg3d(color="white")
light3d()

# draw shperes in an rgl window
spheres3d(x, y, z, radius=0.025, color=rgb(cr,cg,cb))
}




if(type == '2d')
{
# optional scatterplot in 2D
scatterplot3d(x,y,z, pch=16, cex.symbols=0.25, color=rgb(cr,cg,cb), axis=FALSE )
}

# optionally return results
# list(x=x, y=y, z=z, red=cr, green=cg, blue=cb)

}




################################################################################
## main

# random number with runif():
d <- runif(2500)

# plot rng sphere with rgl:
rng_sphere(d, type='rgl')

#
# # plot rng sphere with scatterplot3d:
# rng_sphere(d, type='2d')
