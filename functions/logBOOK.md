logBOOK
---



# Ollin Cecah Function

## TODO

* [ ] Update `ollin_cencah.R` for packages dependencies:

```
#mirror_repo <- 'https://www.stats.bris.ac.uk/R/'
#packagename <- 'lattice'
#if (!require(packagename)) install.packages(packagename, repos=mirror_repo, dependencies = TRUE) 


#if (!require("lattice")) install.packages("lattice")
library(lattice) ##xyplot

require(tseriesChaos)
require(rgl)

library(latticeExtra)  ##overlay xyplots a + as.layer(b)
library(ggplot2) ## percentage of variance bar plot

```

(added:30march2018 1358, sorted:???)





* [ ] test the following code to avoid installing libraries 
```
#mirror_repo <- 'https://www.stats.bris.ac.uk/R/'
#packagename <- 'lattice'
#if (!require(packagename)) install.packages(packagename, repos=mirror_repo, dependencies = TRUE) 
```
	** (added:6march2018,13h39; sorted: )

* [ ] Add an exmaple for each function

* [ ] Create a main directory for the function file and mix all the functions for   the Human Variability Project


* [ ] clean the function: `ollin_cencah.R`, `functions_freq_features.R`,
`functions_inertial_sensors.R`, `functions_matrix_stats.R`, `functions_muse_sensor.R`

* [ ] Add description for the R functions in the README.md files with subfunctions

* [ ] Add documentation on how to use the functions


## SORTED

* [x] create an independent repository with proper name  (tavand)
	[Tools-for-analysis-of-variability-with-nonlinear-dynamics] 
	(use the same history)
	(added:30march2018 1526 sorted:30march2018 2006)



* [x] tyding up : 6march2018
* [x]  Add rotated_angle function to rotate euler angles (6th of October 2016)
* [x] adding `split_path` (sorted: 6 Sep 2016)


