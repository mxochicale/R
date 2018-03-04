#!/bin/bash  

##USAGE:
#chmod +x file
#./file




sudo apt-get update
sudo apt-get --yes install gfortran
sudo apt-get --yes install libblas-dev libatlas-base-dev liblapack-dev libatlas-base-dev libncurses5-dev
sudo apt-get --yes install cdbs
sudo apt-get --yes install r-base r-base-dev

