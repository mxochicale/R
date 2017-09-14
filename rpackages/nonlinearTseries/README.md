## What is `nonlinearTseries`
[`nonlinearTseries`](https://github.com/constantino-garcia/nonlinearTseries)
provides functions for nonlinear time series analysis. This package permits the computation of the most-used nonlinear statistics/algorithms including generalized correlation dimension, information dimension, largest Lyapunov exponent, sample entropy and Recurrence Quantification Analysis (RQA), among others. Basic routines for surrogate data testing are also included. The package is largely inspired by the book [Nonlinear time series analysis](https://www.amazon.com/Nonlinear-Time-Analysis-Holger-Kantz/dp/0521529026) by Holger Kantz and Thomas Schreiber.

*NB* Many thanks to [constantino-garcia](https://github.com/constantino-garcia/)
for making the [`nonlinearTseries`](https://github.com/constantino-garcia/nonlinearTseries)
package available in GitHub.

## Installation
You can install the he latest released version from
[CRAN](https://cran.r-project.org/web/packages/nonlinearTseries/index.html) with:

```
install.packages("nonlinearTseries")
```

## Getting started
For a quick introduction to `nonlinearTseries`, see its
[vignette](https://cran.r-project.org/web/packages/nonlinearTseries/vignettes/nonlinearTseries_quickstart.html).




## For developing

```
cd ~/mxochicale/github/rpackages/
R
library(roxygen2); library("devtools")
install('nonlinearTseries')
library('nonlinearTseries')
```

```
buildTakens(1:20,embedding.dim=5,time.lag=3)
```


## Loading nonlinearTseries from a given path

```
library(devtools)
load_all('~/mxochicale/github/r-code_repository/rpackages/nonlinearTseries')
buildTakens(1:20,embedding.dim=5,time.lag=3)
```

or
```
library(devtools)
install('~/mxochicale/github/r-code_repository/rpackages/nonlinearTseries')
library('nonlinearTseries')
buildTakens(1:20,embedding.dim=5,time.lag=3)
```
