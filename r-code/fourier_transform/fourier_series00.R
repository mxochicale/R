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

#
# set.seed(12345)
# gwn <- rnorm(500, mean = 0, sd = 1)
# plot.ts(gwn, xlab = "", ylab = "")


# tn <- seq(0,5,by= 1/50)
# samples <- 1:length(tn)
#



plot.fourier <- function(fourier.series, f.0, ts) {
  w <- 2*pi*f.0
  trajectory <- sapply(ts, function(t) fourier.series(t,w))

  plotacc <- xyplot( trajectory ~ ts,
                    pch=16, col.line = c('red'), type = c("l","g"), lwd=5,
                    #         main=list(label=paste(patternN, "_", substr(filename_imuN,1,4)," acc",sep=""), cex=2.5),
                    xlab=list(label="time", cex=4),
                    ylab=list(label="f(t)", cex=4),
                    scales=list(font=1, cex=3
                                #,y=list(at=seq(-2,2,1),limits=c(-2.1,2.1))
                                #x=list(at=seq(-5,5,2),limits=c(-7,7))
                    ),
                    abline=list(h=c(0),lwd=4,lty=2),
                    #abline(v=c(15,20), col=c("blue", "red"), lty=c(1,2), lwd=c(1, 3))
                    #        abline=list(h=1,lwd=4,lty=2),
                    ## LABELS
                    key=list(
                      border= "grey",
                      text = list(c("sin")),
                      lines = list(pch=c(1), col= c('red')), type="l", lwd=3,
                      cex=2, # control the character expansion  of the symbols
                      corner=c(1,1) # position
                    ),

                    grid = TRUE
  )
  print(plotacc)
}



# An eg
#plot.fourier(function(t,w) {sin(w*t)}, 2, ts=seq(0,1,1/100))

acq.freq <- 50                    # data acquisition (sample) frequency (Hz)
time     <- 4                    # measuring time interval (seconds)
ts       <- seq(0,time-1/acq.freq, 1/acq.freq) # vector of sampling time-points (s)
f.0      <- 1/time

dc.component <- 0
component.strength <- c(2,1,1) # strength of signal components
component.freqs <- c(2,5,10)        # frequency of signal components (Hz)
component.delay <- c(0,0,0)         # delay of signal components (radians)



f   <- function(t,w) {
  dc.component +
    sum( component.strength * sin(component.freqs*w*t + component.delay))
}

plot.fourier(f, f.0, ts=ts)


plot.frequency.spectrum <- function(X.k, xlimits=c(0,length(X.k))) {
  plot.data  <- cbind(0:(length(X.k)-1), Mod(X.k))

  # TODO: why this scaling is necessary?
  plot.data[2:length(X.k),2] <- 2*plot.data[2:length(X.k),2]

  plot(plot.data, t="h", lwd=2, main="",
       xlab="Frequency (Hz)", ylab="Strength",
       xlim=xlimits, ylim=c(0,max(Mod(plot.data[,2]))))
}


w <- 2*pi*f.0
trajectory <- sapply(ts, function(t) f(t,w))
head(trajectory,n=30)

#
X.k <- fft(trajectory)    # find all harmonics with fft()
plot.frequency.spectrum(X.k, xlimits=c(0,20))
#
