akima: Interpolation of Irregularly and Regularly Spaced Data
===========
December 20, 2016
Version: 0.6-2

Reference manual: 	[akima.pdf](https://cran.r-project.org/web/packages/akima/akima.pdf)   

[cran.r-project.org/akima](https://cran.r-project.org/web/packages/akima/index.html
)



#### example00.R
aspline(): Univariate Akima interpolation
with regular spaced data and irregular spaced data
lines(spline(x, y, n=200), col="blue")
lines(aspline(x, y, n=200, method="improved", degree=10), col="green", lty="dashed")




# TODO List
* ?
