Upgrading R and  Installing packages for R  
====


# Installation Ubuntu

R packages for Ubuntu on i386 and amd64 are available for all stable Desktop releases
of Ubuntu until their official end of life date. 


## 1. Add an appropriate mirror to your source.list

"deb https://<my.favorite.cran.mirror>/bin/linux/ubuntu distro/""


###  Ubuntu 14.04 x64

```
sudo sh -c 'echo "deb https://www.stats.bris.ac.uk/R/bin/linux/ubuntu trusty/" >> /etc/apt/sources.list'
```


Add debug packages
```
sudo gedit /etc/apt/sources.list
deb http://archive.ubuntu.com/ubuntu/ trusty main restricted universe multiverse
deb http://archive.ubuntu.com/ubuntu/ trusty-security main restricted universe multiverse
deb http://archive.ubuntu.com/ubuntu/ trusty-updates main restricted universe multiverse
deb http://archive.ubuntu.com/ubuntu/ trusty-proposed main restricted universe multiverse
#deb http://archive.ubuntu.com/ubuntu/ trusty-backports main restricted universe multiverse
```





## 2. Set the keyserver, update and install R
```
gpg --keyserver keyserver.ubuntu.com --recv-key E084DAB9
gpg -a --export E084DAB9 | sudo apt-key add -
```

run
```
./install-R.sh
```
which run the following commands
```
sudo apt-get update
sudo apt-get --yes install gfortran
sudo apt-get --yes install libblas-dev libatlas-base-dev liblapack-dev libatlas-base-dev libncurses5-dev
sudo apt-get --yes install cdbs
sudo apt-get --yes install r-base r-base-dev
```




## Sources

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

# Install Packages


## Basic packages


`chmod +x packages-dependencies.sh`

```
./packages-dependencies.sh
```


`source(paste(getwd(),"/install-basic-packages.R", sep=""), echo=FALSE)` which install the following packages:
```
devtools
data.table
ggplot2
signali for savitzly-golay filter
car, scatterplot3d, plot3D
```


## Extra packages

`source(paste(getwd(),"/install-extra-packages.R", sep=""), echo=FALSE)` install many package
for which, it is suggested to check out the r-script






