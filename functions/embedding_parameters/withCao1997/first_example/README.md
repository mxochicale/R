Cao's method to find the minimal embedding dimension
-----------------
TODO: Check the paths of the files, the code might brake because of the paths


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

* 3 Run rf_cao97.R to compute E1 and E2 values and print the values in plots

```
R
source(paste(getwd(),"/rf_cao97vNN.R", sep=""), echo=FALSE)
```
where NN is the number of version.
