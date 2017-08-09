Cao's Algorithm
---


# Setup for Cao's Algorithm

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

Remember to source the cao97_functions.R file to call cao97sub(x,maxd,tau) function
```
################################################################################
source('~/mxochicale/github/r-code_repository/functions/embedding_parameters/withCao1997/cao97_functions.R')
```
