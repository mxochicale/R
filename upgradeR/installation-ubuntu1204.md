Upgrading R and  Installing packages for R  
====


# Installation Ubuntu

R packages for Ubuntu on i386 and amd64 are available for all stable Desktop releases
of Ubuntu until their official end of life date. 


## 1. Add an appropriate mirror to your source.list

```
#sudo sh -c 'echo "deb https://www.stats.bris.ac.uk/R/bin/linux/ubuntu precise/" >> /etc/apt/sources.list'
```

Add debug packages with `sudo vim /etc/apt/sources.list`

```
# Debug packages for Ubuntu 12.04 x64
deb http://archive.ubuntu.com/ubuntu/ precise main restricted universe multiverse
deb http://archive.ubuntu.com/ubuntu/ precise-security main restricted universe multiverse
deb http://archive.ubuntu.com/ubuntu/ precise-updates main restricted universe multiverse
deb http://archive.ubuntu.com/ubuntu/ precise-proposed main restricted universe multiverse
#deb http://archive.ubuntu.com/ubuntu/ xenial-backports main restricted universe multiverse
```


## 2. Set the keyserver, update and install R
```
gpg --keyserver keyserver.ubuntu.com --recv-key E084DAB9
gpg -a --export E084DAB9 | sudo apt-key add -
```

sudo apt-get update


# OR RUN
```
sh install-R.sh
```
which run the previous commands


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





# issues


* [ ] sources

```
Get:1 https://cloud.r-project.org precise/ Release.gpg [317 B]
Ign https://cloud.r-project.org precise/ Release.gpg
Ign https://cloud.r-project.org precise/ Release
Err https://cloud.r-project.org precise/ Sources
  
Err https://cloud.r-project.org precise/ Packages
  
Ign https://cloud.r-project.org precise/ Translation-en_US
Ign https://cloud.r-project.org precise/ Translation-en
W: Failed to fetch https://cloud.r-project.org/bin/linux/ubuntu/precise/Sources  

W: Failed to fetch https://cloud.r-project.org/bin/linux/ubuntu/precise/Packages  

E: Some index files failed to download. They have been ignored, or old ones used instead.
```


added: Tue Dec 18 00:48:05 GMT 2018

