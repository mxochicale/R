#------------------------------------------------------------
#   Functions
#   Frequency Features
#
#
#  Miguel P. Xochicale [http://mxochicale.github.io]
#  Doctoral Researcher in Human-Robot Interaction
#  University of Birmingham, U.K. (2014-2018)
#
#------------------------------------------------------------


#--------------------- Loading Functions --------------------
#
# source("~/mxochicale/phd/r-code/functions/functions_freq_features.R")
#



# TODO
# *  Freq Energy  READ MORE [https://cran.r-project.org/web/packages/psd/vignettes/normalization.pdf]
# * Add an exmaple for each function
# * Create a main directory for the function file and mix all the functions for
#   the Human Variability Project


#if (!require("stats")) install.packages("stats") ##2: package ‘stats’ is a base package, and should not be updated 
library(stats) ##fft

#if (!require("base")) install.packages("base") ##2: package ‘base’ is a base package, and should not be updated
require(base)# which.min(x) or which.max(x)

if (!require("lattice")) install.packages("lattice")
library(lattice) # for xyplot


#
#-------------------- plot.timeseries( x(t), t) function  --------------------------
#
plot.timeseries <- function(time.series, tn) {

xyplot( time.series ~ tn,
                    col.line = c('red'), type = c("b"), lty=1, lwd=3,
                    pch=1, cex=1.5,
                    xlab=list(label="sample", cex=2),
                    ylab=list(label="x(t)", cex=2),
                    scales=list(font=1, cex=2
                                #,y=list(at=seq(-2,2,1),limits=c(-2.1,2.1))
                                #x=list(at=seq(-5,5,2),limits=c(-7,7))
                    ),
                    abline=list(h=c(0),lwd=4,lty=2),

                    ##function to modify the grid pattern
                    panel=function(...) {
                      panel.xyplot(...)
                      panel.grid(h=-20, v=-1, col.line="blue", lwd=0.5, lty=3 )
                    }

  )

}


#
#-------------------- plot.frequency.spectrum( X,f ) function  --------------------------
#
plot.frequency.spectrum <- function(X,f){

xyplot( X ~ f,
                   col.line = c('red'),
                   type = c("b"), lty=1, lwd=3,
                   pch=1, cex=1.5,
                   xlab=list(label="Frequency (Hz)", cex=2),
                   ylab=list(label="Strength", cex=2),
                   scales=list(font=1, cex=2,
                     y=list(limits=c( 0,  max(X) +  (20*max(X))/100   ) )
                     ),
                   ##function to modify the grid pattern
                   panel=function(...) {
                     panel.xyplot(...)
                     panel.grid(h=-20, v=-1, col.line="blue", lwd=0.5, lty=3 )
                   }

                   )

}




plot.timeseries.frequency.spectrum <- function(y,t,Xf,f){
  pts <- plot.timeseries(y,t)
  pfs <- plot.frequency.spectrum( Xf, f)
  print(pts, split = c(1, 1, 1, 2), more = TRUE)
  print(pfs, split = c(1, 2, 1, 2), more = FALSE)

}





##################################################################
# Frequency Domain Features function
#
freqfeatures <- function(mag){

  ### * DC Component
  DC_component <- mag[1]

  ### * Energy  READ MORE [https://cran.r-project.org/web/packages/psd/vignettes/normalization.pdf]
  energy <- sum(mag)

  ### * ratio between the maximum magnitude and the sum of all the magnitude values
  max_sum_mag_ratio <- max(mag) / sum(mag)

  ### * frequency bin that contains the maxium magnitude value
  max_mag_bin <- which.max(mag)
  freq_bin <- f[max_mag_bin]

  freq.feat <- c(DC_component, energy, max_sum_mag_ratio, freq_bin)

return(freq.feat)


}
