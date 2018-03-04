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


Debug packages
```
sudo gedit /etc/apt/sources.list
deb http://archive.ubuntu.com/ubuntu/ trusty main restricted universe multiverse
deb http://archive.ubuntu.com/ubuntu/ trusty-security main restricted universe multiverse
deb http://archive.ubuntu.com/ubuntu/ trusty-updates main restricted universe multiverse
deb http://archive.ubuntu.com/ubuntu/ trusty-proposed main restricted universe multiverse
#deb http://archive.ubuntu.com/ubuntu/ trusty-backports main restricted universe multiverse
```


### Ubuntu 16.04 x64

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
#deb http://archive.ubuntu.com/ubuntu/ xenial-backports main restricted universe multiverse
```



## 2. Set the keyserver, update and install R
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

or run
```
./install-R.sh
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










### R version 3.4.3 (2018-03-04)

#### Machine
Laptop SAMSUNG

```
$ cat /proc/cpuinfo  | grep 'name'| uniq
model name	: Intel(R) Core(TM) i5-3317U CPU @ 1.70GHz
$ grep MemTotal /proc/meminfo
MemTotal:        7871624 kB
```



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
               _                           
platform       x86_64-pc-linux-gnu         
arch           x86_64                      
os             linux-gnu                   
system         x86_64, linux-gnu           
status                                     
major          3                           
minor          4.3                         
year           2017                        
month          11                          
day            30                          
svn rev        73796                       
language       R                           
version.string R version 3.4.3 (2017-11-30)
nickname       Kite-Eating Tree            
```

