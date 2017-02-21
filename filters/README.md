Savitzky-Golay Filter
=========


Savitzky-Golay (SG) filter is a smooth noisy data.
The method of DG filter to smooth data is based on local least-squares polynomial approximation [RW Schafer2011].
SG filter is very useful when the filtered signal  needs to be preserved as weel as it removes higher frequencies [W Resch 2014]

wresch.github.io/2014/06/26/savitzly-golay.html


#### SavitzkyGolay.R

Compute the Savitzky-Golay Filter
using the signal library which is used as follows

```
sg <- sgolay(p=1,n=13 ,m=0)
dt$sg <- filter(sg, dt$noisy)
```



# TO-DO List
* compare the outcomes when using
 signal:sgolay or prospectr:savitzkyGolay
