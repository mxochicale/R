#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#
#
# FileName:
# FileDescription:
#
#
#
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# Miguel P. Xochicale [http://mxochicale.github.io]
# Doctoral Researcher in Human-Robot Interaction
# University of Birmingham, U.K. (2014-2018)
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

# Source
# https://cran.r-project.org/web/packages/nonlinearTseries/nonlinearTseries.pdf


library('nonlinearTseries')
library('plot3D')

## Not run:
r=rossler(a = 0.2, b = 0.2, w = 5.7, start=c(-2, -10, 0.2),
time=seq(0,300,by = 0.01), do.plot=FALSE)
takens=cbind(r$x,r$y,r$z)

# calculate poincare sections
pm=poincareMap(takens = takens,normal.hiperplane.vector = c(0,1,0),
hiperplane.point=c(0,0,0) )
plot3d(takens,size=0.7)
points3d(pm$pm,col="red")
## End(Not run
