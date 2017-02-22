#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#
#
# FileName:           example00.R
# FileDescription:
# aspline(): Univariate Akima interpolation
#
# Reference: [akima.pdf](https://cran.r-project.org/web/packages/akima/akima.pdf)
#
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# Miguel P. Xochicale [http://mxochicale.github.io]
# Doctoral Researcher in Human-Robot Interaction
# University of Birmingham, U.K. (2014-2018)
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

library(akima)
library(data.table)
library(ggplot2)
############################################
# aspline(): Univariate Akima interpolation


# ## regular spaced data
# signal <- data.table(
#   x = 1:10,
#   y = c(rnorm(5), c(1,1,1,1,3))
#   )


## irregular spaced data
signal <- data.table(
    x = sort(runif(10, max=10)),
    y = c(rnorm(5), c(1,1,1,1,3))
    )

xnew = seq(-1, 11, 0.1)
yInter <-       spline(signal$x, signal$y, xmin=min(xnew), xmax=max(xnew), n=length(xnew))
yInterOne <-    aspline(signal$x, signal$y, xnew)
yInterTwo <-    aspline(signal$x, signal$y, xnew, method="improved")
yInterThree <-  aspline(signal$x, signal$y, xnew, method="improved", degree=10)



INT <- data.table(
  xnew,
  yInter = yInter$y,
  yInterOne = yInterOne$y,
  yInterTwo = yInterTwo$y,
  yInterThree = yInterThree$y
  )


## Ploting the result
p <- ggplot(INT)+
  geom_line(aes(xnew,yInter),     colour="blue",  linetype="solid",     size=1)+
  geom_line(aes(xnew,yInterOne),  colour="red",   linetype="dashed",    size=1)+
  geom_line(aes(xnew,yInterTwo),  colour="black", linetype="dotted",    size=1)+
  geom_line(aes(xnew,yInterThree),  colour="green", linetype="dotdash",   size=1)+
  theme_bw()
p




# ## an example of Akima, 1991
# x <- c(-3, -2, -1, 0,  1,  2, 2.5, 3)
# y <- c( 0,  0,  0, 0, -1, -1, 0,   2)
# plot(x, y, ylim=c(-3, 3))
# lines(spline(x, y, n=200), col="blue")
# lines(aspline(x, y, n=200), col="red")
# lines(aspline(x, y, n=200, method="improved"), col="black", lty="dotted")
# lines(aspline(x, y, n=200, method="improved", degree=10), col="green", lty="dashed")
