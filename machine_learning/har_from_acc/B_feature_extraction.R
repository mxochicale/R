#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#
#
# FileName:     *.R
# Description:
# ExecutionTime: 1.01780143254333 hours
#
#
# NOTE:
#
#
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# Miguel P. Xochicale [http://mxochicale.github.io]
# Doctoral Researcher in Human-Robot Interaction
# University of Birmingham, U.K. (2014-2018)
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++



#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# Loading Functions and Libraries and Setting up digits
library(data.table) # for manipulating data
library(ggplot2)
library(signal)# for butterworth filter

library(scales)# centering
library(moments) #kurtosis and skewness
library(entropy)# entropy

options(digits=15)



#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# Defining paths for main_path, r_scripts_path, ..., etc.
# setwd("../")
r_scripts_path <- getwd()
main_data_path <- paste("/home/map479/mxochicale/github/DataSets/activity_recognition_accelerometer_dataset/data",sep="")
main_data_output_path <- paste("/home/map479/mxochicale/github/DataSets/activity_recognition_accelerometer_dataset/output",sep="")



# Start the clock!
start.time <- Sys.time()



# Setting Output Paths
setwd(main_data_output_path)
ts <- fread(file="ts")




################################################################################
################################################################################
## Feature Extraction
# We will slide a short time window of 1.5 seconds over each action in our data
# and compute a list of statics and metrics to construct a feature vector.
# The short time windows will overlap by 10%, The elements of the feature vector consist of:
#    Mean
#    Standard deviation
#    Number of Zero crossings (after centering)
#    Peak-to-peak value
#    Root Mean Squared value
#    Kurtosis
#    Skewness
#    Crest Factor
#    RMS of the Integral (RMS Velocity)
#    Signal Entropy
#
#
# We’ll define a function to perform feature extraction on a single time window
# and then apply it over the whole data set. We will also need to keep track of
# the features and programmatically construct a list of feature names based on
# the input timeseries and the feature applied.
# This will come very handy later on when we are interested in exploring
# which features are useful for our task.


feature.extract <- function (dt) {
  #utililty functions feature extraction
  zerocross <- function (x) { return (sum(diff(sign(x)) != 0)) }
  peak2peak <- function (x) { return (max(x) - min(x)) }
  rms <- function (x) { return (sqrt(mean(x^2))) }
  #center and subset relevant cols
  dt[, c("lax", "lay", "laz","hax", "hay","haz","lamag", "hamag") :=
       lapply(.(lax, lay, laz, hax, hay, haz, lamag, hamag), scale, center=T, scale=F)]

  dts <- dt[ ,.(lax, lay, laz, hax, hay, haz, lamag, hamag, lpc1, lpc2, lpc3, hpc1, hpc2, hpc3)]
  #names of all time series
  namevec <- names(dts)
  #mean
  means <- lapply(dts, mean)
  names(means) <- lapply(namevec, paste0, ".avg" )
  #stdev
  sds <- lapply(dts, sd)
  names(sds) <- lapply(namevec, paste0, ".sd" )
  #zero crossings
  zcs <- lapply(dts, zerocross)
  names(zcs) <- lapply(namevec, paste0, ".zc" )
  #peak2peak
  p2p <- lapply(dts, peak2peak)
  names(p2p) <- lapply(namevec, paste0, ".p2p" )
  #rms
  rmsvec <- lapply(dts, rms)
  names(rmsvec) <- lapply(namevec, paste0, ".rms" )
  #kurtosis
  kurt <- lapply(dts, kurtosis)
  names(kurt) <- lapply(namevec, paste0, ".kur" )
  #skew
  skew <- lapply(dts, skewness)
  names(skew) <- lapply(namevec, paste0, ".skw" )
  #crest factor (peak/rms)
  cfvec <-mapply(`/`, lapply(dts, max), rmsvec)
  names(cfvec) <- lapply(namevec, paste0, ".cf" )
  #rms for velocity
  rmsvec.vel <- lapply(dts, function (x) rms(diffinv(as.vector(x))) )
  names(rmsvec.vel) <- lapply(namevec, paste0, ".Vrms" )
  #entropy
  entr <- lapply(dts, function(x) entropy(discretize(x, numBins = 10 )))
  names(entr) <- lapply(namevec, paste0, ".ent" )
  #correct label
  label <- dt[1, action]
  names(label) <- "label"
  return ( c(zcs, p2p, rmsvec, kurt, skew, cfvec, rmsvec.vel, entr, label) )
}


sampleHz <- 52

#sliding window parameters
winsecs = 1.5 #window length in seconds
winsize = sampleHz*winsecs
overlap = .10
ix = 1
hop = round(winsize * overlap)
#pre allocate feature object, aprox size
ffrows <- round(nrow(ts)/(winsize*overlap))
nfeat <- length( feature.extract (ts[1:(1 + winsize), ]) )
#feature dt
fdt <- data.table(matrix(data = 0.0, nrow = ffrows, ncol = nfeat) )
names(fdt) <- names( feature.extract (ts[1:(1+ winsize), ]) )




ix <- 1  #index for time series
rx <- 1L #index for feature dt
while ((ix) <= nrow(ts)-winsize ) { # nrow(ts)-winsize = 1,827,451
  #ensure whole window has the same action label
  if (ts[ix, action] == ts[ix + winsize, action] ) {
    #extract and load into fdt
    set(fdt,rx, 1:nfeat, feature.extract(ts[ix:(ix + winsize), ]) )
    rx = rx + 1L
    #move to next window
    ix <- ix + hop
  } else {
      ix <- ix + 1
  }
}

#remove few extra rows created during prealloc
fdt <- fdt[lax.p2p != 0 & lpc1.rms != 0 & lpc2.rms != 0,]
#make label into factor for fdt
fdt[,label := factor(label) ]

fwrite(fdt, file='fdt')



# Stop the clock!
end.time <- Sys.time()
end.time - start.time



#############################################
setwd(r_scripts_path) ## go back to the r-script source path
