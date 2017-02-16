#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#
#
# FileName:           prospectr.R
# FileDescription:
#
#
# Reference:
#          # antonioestevens.github.io/prospectr
#
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# Miguel P. Xochicale [http://mxochicale.github.io]
# Doctoral Researcher in Human-Robot Interaction
# University of Birmingham, U.K. (2014-2018)
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


# dt <- as.data.frame.list(NIRsoil)
# setDT(dt)


library(ggplot2)
library(prospectr)

data(NIRsoil)
str(NIRsoil)


spc <- NIRsoil$spc
noisy <- NIRsoil$spc + rnorm(length(NIRsoil$spc),0,0.001)

# Moving average or running mean
X <- movav(noisy, w=11) # window size of 11 bands


# Savitzky-Golay Filtering
# p=polynomial order; w=window size(must be odd); m=m-th derivative (0=smoothing)
sg <- savitzkyGolay(NIRsoil$spc,p=3,w=11,m=0)



# # Plot the first spectrum
# plot(as.numeric(colnames(NIRsoil$spc)), noisy[1,],type="l", xlab="wavelenght", ylab="Absorbance")
# lines(as.numeric(colnames(X)),X[1,], col="red")
# lines(as.numeric(colnames(sg)),sg[1,], col="blue")




# Derivatives

# #X=wavelenght; Y=spectral matrix; n=order
# d1 <- t(  diff( t(spc) , differences=1 )  ) # first derivative
# d2 <- t(  diff( t(spc) , differences=2 )  ) # second derivative
# plot( as.numeric(colnames(d1)), d1[1,], type="l", xlab="Wavelenght", ylab="")
# lines(as.numeric(colnames(d2)), d2[1,], col="red")
# legend("topleft",  legend= c("1st der","2nd der"), lty=c(1,1), col=1:2)


## Gap Derivatives  with diff(x,differences,lag)
#X=wavelenght; Y=spectral matrix; n=order
d1 <- t(  diff( t(spc) , differences=1 )  ) # first derivative
gd1 <- t(  diff( t(spc) , differences=1,lag=10 )  ) # second derivative
# #plotting
# plot( as.numeric(colnames(gd1)), gd1[1,], type="l", xlab="Wavelenght", ylab="")
# lines(as.numeric(colnames(d1)), d1[1,], col="red")
# legend("topleft",  legend= c("gap-segment 1nd der","1st der"), lty=c(1,1), col=1:2)


## Gap Derivatives with Gap-segment algorithm which performs first
# a smoothing under a given segment size
#m=order of the derivative, w=window size ( = {2*gap size} +1)s =
# segment size first derivative with a gap of 10 bands
gsd1 <- gapDer(X=spc,m=1,w=9,s=1)
#ploting
plot( as.numeric(colnames(d1)), d1[1,], type="l", xlab="Wavelenght", ylab="")
lines(as.numeric(colnames(gsd1)), gsd1[1,], col="red")
legend("topleft",  legend= c("1nd der","gap-1st der"), lty=c(1,1), col=1:2)
