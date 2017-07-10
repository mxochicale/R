derivatives
---

#### Package Dependencies


```
R
install.packages("prospectr", repos='https://www.stats.bris.ac.uk/R/', dependencies = TRUE)
```



# derivatives00.R



```
DerOne <- as.data.table(  diff( as.matrix(raw), differences=1,lag=1 )  )
```
```
DerTwo <- as.data.table(  diff( as.matrix(raw), differences=2,lag=1 )  )
```
```
gsDerOne <- gapDer(X=t(raw),m=1,w=11,s=10)
```

When using diff method, the lenght of the final vector is always decreasing in length
which depends on the difference and the lag value.
Similarly, when using the method of gap-segment derivative (gsDerOne):


* DerOne is of size 699 but maximum size is 700
* DerTwo is of size 698 but maximum size is 700
* gsDerOne is of size 670 but maximum size is 700.


# smooth_derivative.R

After some testing with the script, I have found that creating noisy data
then smoothing it with Savitzky-Golay Filter and then derivate it
produce some strange smooth plots (pX) that I believe are becaseu of the
the given window for the local polynomial reggresion.
With these results, I conclude that the method of gap
segmened derivative which provides a smoother versions of the data
"gapDer(X = NIRsoil$spc, m = 1, w = 11, s = 10)"
http://antoinestevens.github.io/prospectr/


However, we have to deal with the problem of the decrease of lenght.




# Comments about the use of derivatives with raw data

#### prospectr package  
2017-02-17 16:14

prospectr package in R by Stevens and Ramirez-Lopez
is a set of prepropressing tools in spectroscopy.
Two of the tools I am interested in this package
are the gap-derivative and the Savitzky-Golay filter.
(i) the gap-derivative function which
smooth the data given and then a gap-derivative is applied
and
(ii) the Savitzky-Golay filter which
mathematically speaking is a weighted sum of neighboring values
where it is fitted a local polynomial regression
on a given window.
The advantage of using this package is that both the
gapDer() and savitzkyGolay() work  with data.frames and matrix.

Similarly, in the documentation of prospectr [2.2 Derivatives]
is pointed out that derivatives can have positive and negative
effects on the signal to be derived
(-)risk of overfitting the calibration model
(-)increase noise, smoothing required
(-)increase uncertainty in model coefficients
(-)complicated spectral interpretation
(-)remove the baseline
(+)Reduce of baseline offset
(+)resolve the absorption of overlapping
(+)compensate for instrumental drift
(+)enhances small spectral absortions
(+)increase predictive accuracy of complex datasets




### Comments on differencing raw data
2017-02-14 23:25

standard deviation of the standard deviation is not jerk.
"I think it is conservative to describe this as merely silly"
[stat.ethz.ch/pipermail/r-help/2006-January/086184.html]


I am parting from the fact that
I am using inertial sensors to capture human movement.
Considering that I am using acceleremeters,
going in the direction of understanding the physical variables.
There is a concept call Jerk which is the rate of change of acceleration
or more appropriately as the derivative of acceleration with respect of time.

jerk can be seen in environment where the human body loss control of motion
such as in elevators, trams, or when driving with beginners whose
provide a jerky ride.
[WP Jerk_(physics)]


therefore, I started to explore how can I derive the data from the acceleremoters
and I found interesting commends on different Internet forums

(i)
in which is mentioned that for instance
"numeric differentiation is known as error multiplier"
to which it is suggested to smooth the data before computing a derivative
~carl witthoft
[stackoverflow/questions/14082525/how-to-calculate-first-derivative-of-time-series]


(ii)
on another post carl witthoft emphasise that the noise in the data should be well known
and filter it out prior to differentiation.
[stackoverflow/questions/11081069/calculate-the-derivative-of-a-data-function-in-r]


(iii)
it is generally known that differencing raw data amplifies noise.
therefore, it is recommended to smooth it to eliminate much of the noise.
Ramsay and Silverman suggest to use quintic splines to perform second derivative
as they are cubic splines.
"the first derivative of a spline of order k is a spline of order k-1"
[nabble.com/how-to-calculate-derivative-td3054536.html]


# Issues

## gapDer() is decreasing the length of the original vector
https://github.com/antoinestevens/prospectr/issues/2
