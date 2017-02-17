#
#  White Gaussian Noise
#  from Razor 9DOF IMU data
#
#  Miguel Xochicale <perez.xochicale AT gmail.com>
#  University of Birmingham, UK
#  the 26th of May 2015

##################################################
# ref
# http://www.di.fc.ul.pt/~jpn/r/fourier/fourier.html


library(lattice) # for xyplot
library(stats) # for fft



plot.timeseries <- function(time.series) {

plot <- xyplot(time.series ~ 0: length(time.series),
#  plot <- xyplot( trajectory ~ ts,
                    col.line = c('red'), type = c("b"), lty=1, lwd=3,
                    pch=1, cex=1.5,
                    #         main=list(label=paste(patternN, "_", substr(filename_imuN,1,4)," acc",sep=""), cex=2.5),
                    xlab=list(label="sample", cex=2),
                    ylab=list(label="f(t)", cex=2),
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
  print(plot)
}



# set.seed(101)
acq.freq <- 50                   # data acquisition (sample) frequency (Hz)
time     <- 2                  # measuring time interval (seconds)
w        <- 2*pi/time
ts       <- seq(0,time-1/acq.freq, 1/acq.freq) # vector of sampling time-points (s)
N_length <- length(ts)
f.0      <- 1/time


dc.component <- 0
component.strength <- c(1,1,1) # strength of signal components
component.freqs <- c(4,0,0)        # frequency of signal components (Hz)
component.delay <- c(0,0,0)         # delay of signal components (radians)


f   <- function(t,w) {
  dc.component + sum( component.strength * sin(component.freqs*w*t + component.delay))
}

sd.additivenoise <- 0.5    # additive noise standard deviation
mean.amplitude <- 0

trajectory <- sapply(ts, function(t) f(t,w)) +  rnorm(length(ts), mean = mean.amplitude, sd = sd.additivenoise)

trajectory <- trajectory + 25*ts # let's create a linear trend


x11(width = 5, height = 5, xpos = 0)
plot.timeseries(trajectory)


trend <- lm(trajectory ~ts)
detrended.trajectory <- trend$residuals

 plot.timeseries(detrended.trajectory)



plot.frequency.spectrum <- function(X.k, xlimits=c(0,length(X.k))) {
  plot.data  <- cbind(0:(length(X.k)-1), Mod(X.k))

  # TODO: why this scaling is necessary?
  plot.data[2:length(X.k),2] <- 2*plot.data[2:length(X.k),2]

  plot(plot.data, t="h", lwd=2, main="",
       xlab="Frequency (Hz)", ylab="Strength",
       xlim=xlimits, ylim=c(0,max(Mod(plot.data[,2]))))
}


# X.k <- fft(trajectory)
  X.k <- fft(detrended.trajectory)

x11(width = 5, height = 5, xpos = 500)
plot.frequency.spectrum(X.k,xlimits=c(0,acq.freq/2))


#graphics.off()
