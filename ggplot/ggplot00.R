#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#
#
# FileName:           plotly00.R
# FileDescription:
#
#
# Reference:
#           hpps://plot.ly/ggplot2/time-series
#
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# Miguel P. Xochicale [http://mxochicale.github.io]
# Doctoral Researcher in Human-Robot Interaction
# University of Birmingham, U.K. (2014-2018)
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#
#
#

library(ggplot2)
library(zoo)



# data("AirPassangers")
myData <- data.frame( Year  = c( floor( time(AirPassengers) + 0.1)),
                      Month = c(cycle( AirPassengers )),
                      Value = c(AirPassengers))

# convert month numbers to names
myData$Month <- factor(myData$Month)
levels(myData$Month) <- month.abb

# plotting refernce lines across each facet
referenceLines <- myData     #  \/ Rename Month
colnames(referenceLines)[2] <- "groupVar"


zp <- ggplot( myData,
              aes(x= Year, y=Value))
zp <- zp + geom_line( data = referenceLines, # Plotting the underlayer
                     aes(x=Year, y=Value, group = groupVar),
                     colour = "GRAY", alpha = 1/2, size =1/2)
zp <- zp + geom_line(size =1) # Drawing the "overlayer"
zp <- zp + facet_wrap(~ Month)
zp <- zp + theme_bw()
zp
# ggplotly(zp)
