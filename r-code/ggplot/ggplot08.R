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

ggplot( subset(housing, State %in% c("AK", "MA", "TX")),
        aes(x=Date,
            y=Home.Value,
            color=State))+
geom_line()
