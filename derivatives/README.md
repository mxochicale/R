2017-02-14 23:25

standard deviation of the standard deviation is not jerk.
"I think it is conservative to describe this as merely silly"
[stat.ethz.ch/pipermail/r-help/2006-January/086184.html]


I am parting from the fact that
I am using inertial sensors to capture human movement.
Considering that I am using acceleremeters,
going in the direction of understanding the physical variables.
There is a concept call Jerk which is the rate of change of acceleration
or more appropriatelyy  as the derivative of acceleration with respect of time.

jerk can be seen in enviromenent where the human body loss control of motion
such as in elevators, trams, or when driving with beginners whose
provide a jerky ride.
[WP Jerk_(physics)]



therefore, I started to explore how can I derive the data from the acceleremoters
and I found interesting commends on different internet forums

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
