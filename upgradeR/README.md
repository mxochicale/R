Upgrading R and  Installing packages for R  
====


# Installation Ubuntu

R packages for Ubuntu on i386 and amd64 are available for all stable Desktop releases
of Ubuntu until their official end of life date. As of May 3, 2017 the supported releases
are Xenial Xerus (16.04; LTS) Trusty Tahr (14.04; LTS), etc.


1. Add an appropriate mirror to your source.list

"deb https://<my.favorite.cran.mirror>/bin/linux/ubuntu distro/""


* Ubuntu 14.04 x64
```
sudo sh -c 'echo "deb https://www.stats.bris.ac.uk/R/bin/linux/ubuntu trusty/" >> /etc/apt/sources.list'
```


Debug packages
```
sudo gedit /etc/apt/sources.list
deb http://archive.ubuntu.com/ubuntu/ trusty main restricted universe multiverse
deb http://archive.ubuntu.com/ubuntu/ trusty-security main restricted universe multiverse
deb http://archive.ubuntu.com/ubuntu/ trusty-updates main restricted universe multiverse
deb http://archive.ubuntu.com/ubuntu/ trusty-proposed main restricted universe multiverse
```
 #deb http://archive.ubuntu.com/ubuntu/ trusty-backports main restricted universe multiverse



* Ubuntu 16.04 x64
```
sudo sh -c 'echo "deb https://www.stats.bris.ac.uk/R/bin/linux/ubuntu xenial/" >> /etc/apt/sources.list'
```

Debug packages
```
sudo gedit /etc/apt/sources.list
# Debug packages for Ubuntu 16.04 x64
deb http://archive.ubuntu.com/ubuntu/ xenial main restricted universe multiverse
deb http://archive.ubuntu.com/ubuntu/ xenial-security main restricted universe multiverse
deb http://archive.ubuntu.com/ubuntu/ xenial-updates main restricted universe multiverse
deb http://archive.ubuntu.com/ubuntu/ xenial-proposed main restricted universe multiverse
```
 #deb http://archive.ubuntu.com/ubuntu/ xenial-backports main restricted universe multiverse




2. Set the keyserver, update and install R
```
gpg --keyserver keyserver.ubuntu.com --recv-key E084DAB9
gpg -a --export E084DAB9 | sudo apt-key add -
```

```
sudo apt-get update
sudo apt-get install gfortran
sudo apt-get install libblas-dev libatlas-base-dev liblapack-dev libatlas-base-dev libncurses5-dev
sudo apt-get install cdbs
sudo apt-get install r-base r-base-dev
```

Output
```
$ sudo apt-get install r-base r-base-dev
Reading package lists... Done
Building dependency tree       
Reading state information... Done
The following packages were automatically installed and are no longer required:
  libreadline5 linux-headers-4.4.0-31 linux-headers-4.4.0-31-generic linux-headers-4.4.0-75 linux-headers-4.4.0-75-generic linux-image-4.4.0-31-generic linux-image-4.4.0-75-generic
  linux-image-extra-4.4.0-31-generic linux-image-extra-4.4.0-75-generic ubuntu-core-launcher
Use 'sudo apt autoremove' to remove them.
The following additional packages will be installed:
  libreadline-dev libreadline6-dev r-base-core r-base-html r-cran-boot r-cran-class r-cran-cluster r-cran-codetools r-cran-foreign r-cran-kernsmooth r-cran-lattice r-cran-mass r-cran-matrix r-cran-mgcv
  r-cran-nlme r-cran-nnet r-cran-rpart r-cran-spatial r-cran-survival r-doc-html r-recommended
Suggested packages:
  readline-doc ess r-doc-info | r-doc-pdf r-mathlib texlive-base texlive-latex-base texlive-generic-recommended texlive-fonts-recommended texlive-fonts-extra texlive-extra-utils
  texlive-latex-recommended texlive-latex-extra texinfo
The following packages will be REMOVED
  libreadline-gplv2-dev
The following NEW packages will be installed
  libreadline-dev libreadline6-dev r-base r-base-core r-base-dev r-base-html r-cran-boot r-cran-class r-cran-cluster r-cran-codetools r-cran-foreign r-cran-kernsmooth r-cran-lattice r-cran-mass
  r-cran-matrix r-cran-mgcv r-cran-nlme r-cran-nnet r-cran-rpart r-cran-spatial r-cran-survival r-doc-html r-recommended
0 to upgrade, 23 to newly install, 1 to remove and 181 not to upgrade.
Need to get 40.5 MB of archives.
After this operation, 62.8 MB of additional disk space will be used.
Do you want to continue? [Y/n] Y
```

3. Sources

* Main Reference https://cran.rstudio.com/bin/linux/ubuntu/  
* [List of mirrors](https://cran.r-project.org/mirrors.html)
* [how-to-set-up-r-on-ubuntu-14-04](https://www.digitalocean.com/community/tutorials/how-to-set-up-r-on-ubuntu-14-04)
* UK Mirrors
  ```
  https://www.stats.bris.ac.uk/R/
  http://www.stats.bris.ac.uk/R/
  https://mirrors.ebi.ac.uk/CRAN/
  http://mirrors.ebi.ac.uk/CRAN/
  https://cran.ma.imperial.ac.uk/
  http://cran.ma.imperial.ac.uk/
  http://mirror.mdx.ac.uk/R/
  ```


# TODO

* create sh or Makefile for automatic upgrade of R






# Basic packages

Using Bristol repo!:
install.packages('package-name', repos='https://www.stats.bris.ac.uk/R/')


### devtools

devtools dependencies

```
sudo apt-get install libssl-dev libcurl4-openssl-dev
```

```
install.packages("devtools", repos='https://www.stats.bris.ac.uk/R/', dependencies = TRUE)
```


#### [data.table]([https://github.com/Rdatatable/data.table/wiki/Installation)
```
library(devtools)
install_github("Rdatatable/data.table", build_vignettes=FALSE)
```
[MORE](https://github.com/Rdatatable/data.table/wiki/Installation#why-we-recommend-installpackages-above-rather-than-devtoolsinstall_github)



### ggplot2
It takes a while of time for the installation, perhaps 3 min.
for percentage of variance bar plot and error bars
```
install.packages("ggplot2", repos='https://www.stats.bris.ac.uk/R/', dependencies = TRUE)
#or
# if (!require("ggplot2")) install.packages("ggplot2", repos='https://www.stats.bris.ac.uk/R/', dependencies = TRUE)
* DONE (ggplot2)
```

### latex2exp
```
install.packages("latex2exp", repos='https://www.stats.bris.ac.uk/R/', dependencies = TRUE)
```




### tseriesChaos
```
install.packages("tseriesChaos", repos='https://www.stats.bris.ac.uk/R/', dependencies = TRUE)
#or
# if (!require("tseriesChaos")) install.packages("tseriesChaos", repos='https://www.stats.bris.ac.uk/R/')
```

####  for savitzly-golay filter
```
install.packages("signal", repos='https://www.stats.bris.ac.uk/R/', dependencies = TRUE)
```
#### Interpolation of Irregular and Regularly Spaced Data
```
install.packages("akima", repos='https://www.stats.bris.ac.uk/R/', dependencies = TRUE)
```



### rgl

It takes a while of time for the installation, perhaps 5 min.
```
.packages <- ("rgl")
lapply(.packages, install.packages, dependencies = TRUE, repos='https://www.stats.bris.ac.uk/R/')
```

## plot3D

```
.packages <- c('car', 'scatterplot3d', 'plot3D')
lapply(.packages, install.packages, dependencies = TRUE, repos='https://www.stats.bris.ac.uk/R/')
```


### pals: Color Palettes, Colormaps, and Tools to Evaluate Them
install.packages("pals", repos='https://www.stats.bris.ac.uk/R/', dependencies = TRUE)


## More packages



### latice

```
install.packages("lattice", repos='https://www.stats.bris.ac.uk/R/')
#or
# if (!require("lattice")) install.packages("lattice", repos='https://www.stats.bris.ac.uk/R/')  ##xyplot
```

### latticeExtra
```
install.packages("latticeExtra", repos='https://www.stats.bris.ac.uk/R/')
# or
# if (!require("latticeExtra")) install.packages("latticeExtra", repos='https://www.stats.bris.ac.uk/R/')   ##overlay xyplots a + as.layer(b)

```



#### [prospectr](https://github.com/antoinestevens/prospectr)
```
devtools::install_github("prospectr", "antoinestevens")

# Warning message:
# Username parameter is deprecated. Please use antoinestevens/prospectr
```



# extras

### 'quantmod' wrapper to load data from different sources
install.packages("quantmod", repos='https://www.stats.bris.ac.uk/R/')

### 'plyr' tools for splitting, appliying and combining data
install.packages("plyr", repos='https://www.stats.bris.ac.uk/R/')



### 'fNonlinear' tools
install.packages("fNonlinear", repos='https://www.stats.bris.ac.uk/R/')


### 'nonlinearTseries' tools for nonlinear time series analysis
install.packages("nonlinearTseries", repos='https://www.stats.bris.ac.uk/R/')




```
install.packages("matrixStats", repos='https://www.stats.bris.ac.uk/R/')
install.packages("reshape", repos='https://www.stats.bris.ac.uk/R/')



install.packages("lubridate") # for working with date/times
install.packages("dplyr") # for manipulating data
install.packages("tidyr") # for tydying data
install.packages("plotly") # for beuatiful ploting
#Hadley Wickham
install.packages("zoo") # for databases
install.packages("plyr") # for databases



install.packages("gplots", dependencies = TRUE) #for heatmaps
install.packages("RColorBrewer", dependencies = TRUE)
install.packages("scatterplot3d")
install.packages("latticeExtra")

install.packages('fractal', repos='https://www.stats.bris.ac.uk/R/', dependencies = TRUE)

install.packages("ROCR") #visualizing classifier performance
install.packages("pROC") #Display and Analyze ROC Curves
```






# R Upgrades Log


### R version 3.3.3 (2017-03-06)
#### Machine

#### OS

```
$ lsb_release -a
No LSB modules are available.
Distributor ID:	Ubuntu
Description:	Ubuntu 14.04.3 LTS
Release:	14.04
Codename:	trusty
```

#### R Version


```
$ R
> version


platform       x86_64-pc-linux-gnu         
arch           x86_64                      
os             linux-gnu                   
system         x86_64, linux-gnu           
status                                     
major          3                           
minor          3.3                         
year           2017                        
month          03                          
day            06                          
svn rev        72310                       
language       R                           
version.string R version 3.3.3 (2017-03-06)
nickname       Another Canoe        
```






### R version 3.3.2 (2016-10-31)

#### Machine

#### OS

#### R Version

```
$ R
> version

platform       x86_64-pc-linux-gnu
arch           x86_64
os             linux-gnu
system         x86_64, linux-gnu
status
major          3
minor          3.2
year           2016
month          10
day            31
svn rev        71607
language       R
version.string R version 3.3.2 (2016-10-31)
nickname       Sincere Pumpkin Patch
```




### R version 3.2.2 (2015-08-14)


#### Machine

#### OS

```
$ lsb_release -a
No LSB modules are available.
Distributor ID:	Ubuntu
Description:	Ubuntu 14.04.5 LTS
Release:	14.04
Codename:	trusty
```


#### R version

```
$ R
> version

platform       x86_64-pc-linux-gnu
arch           x86_64
os             linux-gnu
system         x86_64, linux-gnu
status
major          3
minor          2.2
year           2015
month          08
day            14
svn rev        69053
language       R
version.string R version 3.2.2 (2015-08-14)
nickname       Fire Safety
```








### R version 3.4.0 (2017-04-21)

#### Machine
Xeon Server
CPU E5-2608 @ 2.40 GHz  
GPU Nvidia GeForce GTX680  
RAM 32GB

#### OS
```
$ lsb_release -a
No LSB modules are available.
Distributor ID:	Ubuntu
Description:	Ubuntu 16.04.2 LTS
Release:	16.04
Codename:	xenial
```

#### R version
```
$ R
> version
               _                           
platform       x86_64-pc-linux-gnu         
arch           x86_64                      
os             linux-gnu                   
system         x86_64, linux-gnu           
status                                     
major          3                           
minor          4.0                         
year           2017                        
month          04                          
day            21                          
svn rev        72570                       
language       R                           
version.string R version 3.4.0 (2017-04-21)
nickname       You Stupid Darkness        
```
