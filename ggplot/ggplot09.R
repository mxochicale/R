#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#
#
# FileName:           plotly08.R
# FileDescription:
#
#
# Reference:
#           docs.ggplot2.org/current/aes_group_order.html
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

# wget http://tutorials.iq.harvard.edu/R/Rgraphics/dataSets/landdata-states.csv

housing <- read.csv("landdata-states.csv")

# reference lines across each facet
referenceLines <- housing     #  \/ Rename State
colnames(referenceLines)[1] <- "groupVar"


p <- ggplot( housing,aes(x=Date, y=Home.Value))
p <- p + geom_line( data = referenceLines, # Plotting the underlayer
                     aes(x=Date, y=Home.Value, group = groupVar),
                     colour = "GRAY", alpha = 1/2, size =1/2)
p <- p + geom_line( size=1.5, aes(color=State) )  # Drawing the "overlayer"
p <- p + facet_wrap(~State, ncol=10)
p <- p + theme(legend.position="none") # for no axes legends
p







# geom_line( aes(color=State) )+
# facet_wrap(~State, ncol=10)
