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


#### example01.R
data.table
aspline(): Univariate Akima interpolation




# Comments about the use of aspline()
2017-02-22 14:112017-02-22 14:11

Four interpolation methods have been tested using the akima package:
(A) spline(x, y, n=200)
(B) aspline(x, y, n=200)
(C) aspline(x, y, n=200, method="improved")
(D) aspline(x, y, n=200, method="improved", degree=10)
on  the example01.R script. For this test, the data is irregular spaced
[sort(runif(10, max=10))] to visualise how robust are the methods.

The methods of spline(x, y, n=200) and aspline(x, y, n=200, method="improved")
appear to be closely similar and smoothed.
(WORD FOR TRANSITION)
Generally, the aspline line make sharp interpolation when there is a 90 degree change in the plot.
which is very different when using only spline which shows a very smothed signal
that is approximated to the sine signals.









# TODO List
* ?
