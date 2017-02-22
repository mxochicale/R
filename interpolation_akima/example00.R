#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#
#
# FileName:           example00.R
# FileDescription:
# akima(): Waveform Distortion Data for Bivariate Interpolation
# akima760():  Sample data from Akima’s Bicubic Spline Interpolation code (TOMS 760)
# aspline(): Univariate Akima interpolation
# bicubic(): Bivariate Interpolation for Data on a Rectangular grid
# bicubic.grid():  Bicubic Interpolation for Data on a Rectangular grid
# bilinear():  Bilinear Interpolation for Data on a Rectangular grid
# bilinear.grid(): Bilinear Interpolation for Data on a Rectangular grid
# franke.data(): Test datasets from Franke for interpolation of scattered data
# interp():  Gridded Bivariate Interpolation for Irregular Data
# interp.old():  Gridded Bivariate Interpolation for Irregular Data
# interp2xyz(): From interp() Result, Produce 3-column Matrix
# interpp(): Pointwise Bivariate Interpolation for Irregular Data
# interpp.old(): Pointwise Bivariate Interpolation for Irregular Data
#
# Reference: [akima.pdf](https://cran.r-project.org/web/packages/akima/akima.pdf)
#
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# Miguel P. Xochicale [http://mxochicale.github.io]
# Doctoral Researcher in Human-Robot Interaction
# University of Birmingham, U.K. (2014-2018)
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

library(akima)

############################################
# aspline(): Univariate Akima interpolation


# ## regular spaced data
# x <- 1:10
# y <- c(rnorm(5), c(1,1,1,1,3))
# xnew <- seq(-1, 11, 0.1)
# plot(x, y, ylim=c(-3, 3), xlim=range(xnew))
# lines(spline(x, y, xmin=min(xnew), xmax=max(xnew), n=200), col="blue")
# lines(aspline(x, y, xnew), col="red")
# lines(aspline(x, y, xnew, method="improved"), col="black", lty="dotted")
# lines(aspline(x, y, xnew, method="improved", degree=10), col="green", lty="dashed")




## irregular spaced data
# x <- sort(runif(10, max=10))
# y <- c(rnorm(5), c(1,1,1,1,3))
# xnew <- seq(-1, 11, 0.1)
# plot(x, y, ylim=c(-3, 3), xlim=range(xnew))
# lines(spline(x, y, xmin=min(xnew), xmax=max(xnew), n=200), col="blue")
# lines(aspline(x, y, xnew), col="red")
# lines(aspline(x, y, xnew, method="improved"), col="black", lty="dotted")
# lines(aspline(x, y, xnew, method="improved", degree=10), col="green", lty="dashed")



## an example of Akima, 1991
x <- c(-3, -2, -1, 0,  1,  2, 2.5, 3)
y <- c( 0,  0,  0, 0, -1, -1, 0,   2)
plot(x, y, ylim=c(-3, 3))
lines(spline(x, y, n=200), col="blue")
lines(aspline(x, y, n=200), col="red")
lines(aspline(x, y, n=200, method="improved"), col="black", lty="dotted")
lines(aspline(x, y, n=200, method="improved", degree=10), col="green", lty="dashed")
