Cao's draft examples
----


# TODO
* [ ] Check the paths for `paste(main_path,"/timeseries",sep="")` and 
use different time series: `fread("periodic.dt", header=TRUE)`, `fread("chaotic.dt", header=TRUE)`



# Usage

* 1 Using datafile

* 2 Build dll to wrap f function in R

```
R CMD SHLIB cao97_subroutine.f
```

```
gfortran   -fpic  -g -O2 -fstack-protector --param=ssp-buffer-size=4  -c cao97sub.f -o cao97sub.o
gcc -std=gnu99 -shared -L/usr/lib/R/lib -Wl,-Bsymbolic-functions -Wl,-z,relro -o cao97sub.so cao97sub.o -lgfortran -lm -lquadmath -L/usr/lib/R/lib -lR
```

* 3 Run `rf_cao97NN.R` to compute E1 and E2 values and print the values in plots

```
R
source(paste(getwd(),"/rf_cao97vNN.R", sep=""), echo=FALSE)
```
where NN is the number of version.


* `rf_cao97v00.R` uses `data.table` and `ggplot2` packages
* `rf_cao97v01.R` uses `data.table` and `ggplot2` packages
* `rf_cao97v02.R` uses `data.table` and `ggplot2` packages
