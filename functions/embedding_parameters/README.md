Embedding parameters
---

# Cao's Algorithm

## Setup for Cao's Algorithm

1. Clean dll libraries for R
```
rm *.o *.so
```

2. build dll to wrap f function in R
```
R CMD SHLIB cao97sub.f
```
which creates cao97sub.o and cao97sub.so



# Usage

exampleCAO97.R

Source the cao97_functions file to call the functions
```
################################################################################
source('~/mxochicale/github/r-code_repository/functions/embedding_parameters/cao97_functions.R')
```




















# Mutual Information

4. cc -o minfo minfo5.c -lm
```
./minfo datafile -b 100 -t 100 > r.mi
```

5. comparison
```
mi_comparison.R
```



\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\


<!--
```
source('~/mxochicale/github/r-code_repository/functions/ollin_cencah.R')
``` -->

## running first time
Create a general to call cao97sub.so
set dyn.load(path/cao97sub.so )



1. extract data from either lorenz, sine or imu time-series
```
	extractdata_imu.R
	extractdata_lorenzts.R
	extractdata_sine.R
```
