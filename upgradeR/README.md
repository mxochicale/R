Upgrading R and  Installing packages for R  
====


# Installation Ubuntu

R packages for Ubuntu on i386 and amd64 are available for all stable Desktop releases
of Ubuntu until their official end of life date. As of May 3, 2017 the supported releases
are Xenial Xerus (16.04; LTS) Trusty Tahr (14.04; LTS), etc.


1. Add an appropriate mirror to your source.list

"deb https://<my.favorite.cran.mirror>/bin/linux/ubuntu distro/""


For Ubuntu 14.04 x6
```
sudo sh -c 'echo "deb https://www.stats.bris.ac.uk/R/bin/linux/ubuntu trusty/" >> /etc/apt/sources.list'
```

For Ubuntu 16.04 x64
```
sudo sh -c 'echo "deb https://www.stats.bris.ac.uk/R/bin/linux/ubuntu xenial/" >> /etc/apt/sources.list'
```



```
sudo gedit /etc/apt/sources.list
deb http://archive.ubuntu.com/ubuntu/ trusty main restricted universe multiverse
deb http://archive.ubuntu.com/ubuntu/ trusty-security main restricted universe multiverse
deb http://archive.ubuntu.com/ubuntu/ trusty-updates main restricted universe multiverse
deb http://archive.ubuntu.com/ubuntu/ trusty-proposed main restricted universe multiverse
deb http://archive.ubuntu.com/ubuntu/ trusty-backports main restricted universe multiverse
```



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

Main Reference https://cran.rstudio.com/bin/linux/ubuntu/  
[List of mirrors](https://cran.r-project.org/mirrors.html)

* [how-to-set-up-r-on-ubuntu-14-04](https://www.digitalocean.com/community/tutorials/how-to-set-up-r-on-ubuntu-14-04)


UK Mirrors
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


# My packages

Using Bristol repo!:
install.packages('package-name', repos='https://www.stats.bris.ac.uk/R/')


### devtools

devtools dependencies

```
sudo apt-get install libssl-dev libcurl4-openssl-dev
```

```
install.packages("devtools", repos='https://www.stats.bris.ac.uk/R/')
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


### rgl

It takes a while of time for the installation, perhaps 5 min.
```
install.packages("rgl", repos='https://www.stats.bris.ac.uk/R/', dependencies = TRUE)
#or
# if (!require("rgl")) install.packages("rgl")
```




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





### tseriesChaos
```
install.packages("tseriesChaos", repos='https://www.stats.bris.ac.uk/R/')
#or
# if (!require("tseriesChaos")) install.packages("tseriesChaos", repos='https://www.stats.bris.ac.uk/R/')
```



#### [prospectr](https://github.com/antoinestevens/prospectr)
```
devtools::install_github("prospectr", "antoinestevens")

# Warning message:
# Username parameter is deprecated. Please use antoinestevens/prospectr
```

####  for savitzly-golay filter
```
install.packages("signal")
```
#### Interpolation of Irregular and Regularly Spaced Data
```
install.packages("akima")
```





#### More packages
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






# R Upgrages Log

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


```
$ lsb_release -a
No LSB modules are available.
Distributor ID:	Ubuntu
Description:	Ubuntu 14.04.3 LTS
Release:	14.04
Codename:	trusty
```


### R version 3.3.2 (2016-10-31)
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


```
$ lsb_release -a
No LSB modules are available.
Distributor ID:	Ubuntu
Description:	Ubuntu 14.04.5 LTS
Release:	14.04
Codename:	trusty
```
