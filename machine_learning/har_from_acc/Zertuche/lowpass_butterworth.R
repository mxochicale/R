#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#
#
# FileName:           script.R
# FileDescription:
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
library(signal)# for butterworth filter
library(ggplot2)

options(digits=15)



#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# Defining paths for main_path, r_scripts_path, ..., etc.
r_scripts_path <- getwd()


# One key insight about this data-set is that there might be important features
# in the low and high frequency spectra of our time series, so it would be
# pertinent to split them using a low pass filter. Lets specify and test
# a butterworth digital filter before we apply it to our data.


sf <- 52 #sample freq
cf <- 3 #cutoff freq
secs <-  1
t <- seq(0, secs, len = sf*secs*2)
x <- sin(2*pi*t*1) # 1hz signal
noise <-  .5*sin(2*pi*t*10) #10 Hz noise
xnoise <- x + noise
f <- butter(7, cf/(sf/2)) #7th order, cutoff freq as normalized to nyquist freq
xclean <- filtfilt(f, xnoise)

ggplot() + geom_line(aes(x = t, y = x, color = "a" ), size=2)  +
           geom_line(aes(x = t, y = noise, color = "b") , size = 1) +
           geom_line(aes(x = t, y = xnoise, color = "c"), size = 1) +
           geom_line(aes(x = t, y = xclean, color = "d"),size = 1)  +
           scale_color_manual ("", values = c("a"="red","b"="blue", "c"="green","d"="yellow" ),
                               label=c("Original", "HF-noise", "Orig+Noise","Filtered" ))





#############################################
setwd(r_scripts_path) ## go back to the r-script source path
