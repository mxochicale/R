#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#
#
# FileName:           plotly10.R
# FileDescription:
#
#
# Reference:
#          # wget http://tutorials.iq.harvard.edu/R/Rgraphics/dataSets/landdata-states.csv
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
library('data.table')

DT <- fread('landdata-states.csv')

## \/ Rename State for "groupVar"
referenceLines <- DT[,]
names(referenceLines)[names(referenceLines)=="State"] <- "groupVar"



p <- ggplot( DT,aes(x=Date, y=Home.Value))
p <- p + geom_line( data = referenceLines, # Plotting the underlayer
                     aes(x=Date, y=Home.Value, group = groupVar),
                     colour = "GRAY", alpha = 1/2, size =1/2)
p <- p + geom_line( size=1.5, aes(color=State) )  # Drawing the "overlayer"
p <- p + facet_wrap(~State, ncol=10)
p <- p + theme(legend.position="none") # for no axes legends
p
