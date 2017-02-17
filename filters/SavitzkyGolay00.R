#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#
#
# FileName:           SavitzkyGolay.R
# FileDescription:
# * Savitzky-Golay (SG) filter is a smooth noisy data.
# The method of DG filter to smooth data is based on local least-squares
# polynomial approximation [RW Schafer2011].
# SG filter is very useful when the filtered signal
# needs to be preserved as weel as it removes higher frequencies [W Resch 2014]
#
# Reference:
#          # wresch.github.io/2014/06/26/savitzly-golay.html
#
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# Miguel P. Xochicale [http://mxochicale.github.io]
# Doctoral Researcher in Human-Robot Interaction
# University of Birmingham, U.K. (2014-2018)
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


#
# sgolay(p,n,m)
# p filter order
# n filter length (must be odd)
# m return the m-th derivative of the filter coefficients


library(signal)
library(data.table)
library(ggplot2)


# Synthetic Data
set.seed(00)

n <- 100
x <- (1:n)/n
clean.data <- ( ( exp(1.2*x)+1.5*sin(7*x) )-1 ) / 3

dt <- data.table(
  x=x,
  clean=clean.data,
  noisy=clean.data + rnorm(n,0,0.12)
  )

# Savitzky Golay Filter
sg <- sgolay(p=1,n=13 ,m=0)



# Applied Filter to the data
dt$sg <- filter(sg, dt$noisy)


# Ploting the result
p <- ggplot(dt)+
    geom_point(aes(x,noisy), size=2)+
    geom_line(aes(x,clean), linetype="longdash")+
    geom_line(aes(x,sg), col="red2", size=1)+
    ylab("y")+
    theme_bw()

print(p)
