Upgrading R
---


1. Add an appropriate mirror to your source.list
```
sudo -H gedit /etc/apt/sources.list
deb http://cran.ma.imperial.ac.uk/bin/linux/ubuntu trusty/
```

2. Set the keyserver, update and install R
```
gpg --keyserver keyserver.ubuntu.com --recv-key E084DAB9
gpg -a --export E084DAB9 | sudo apt-key add -
sudo apt-get update
sudo apt-get install r-base r-base-dev
```

Main Reference https://cran.rstudio.com/bin/linux/ubuntu/  
Mirrors https://cran.r-project.org/mirrors.html  



# My packages
```
install.packages("devtools")
```
```
devtools::install_github("Rdatatable/data.table", build_vignettes=FALSE)
#https://github.com/Rdatatable/data.table/wiki/Installation
```
```
devtools::install_github("prospectr", "antoinestevens")
#https://github.com/antoinestevens/prospectr
# Warning message:
# Username parameter is deprecated. Please use antoinestevens/prospectr
```
```
install.packages("signal") # for savitzly-golay filter
```

```
#Optional
install.packages("lubridate") # for working with date/times
install.packages("dplyr") # for manipulating data
install.packages("tidyr") # for tydying data
install.packages("plotly") # for beuatiful ploting
#Hadley Wickham
install.packages("zoo") # for databases
install.packages("plyr") # for databases
```

# R Upgrages Log

### R version 3.3.2 (2016-10-31)
```
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


### UBUNTU VERSION
```
$ lsb_release -a
No LSB modules are available.
Distributor ID:	Ubuntu
Description:	Ubuntu 14.04.5 LTS
Release:	14.04
Codename:	trusty
```
