#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#
#
# FileName:           plotly04.R
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

# library(plyr) # wrapper
library(ggplot2)


set.seed(100)
d <- diamonds[sample(nrow(diamonds),1000),]

# library(plotly)
# plot_ly(d, x=~carat, y=~price, color=~carat,
#         size=~carat, text=~paste("Clarity: ", clarity))


ggplot(data=d, aes(x=carat, y=price))+
geom_point(aes(text=paste("Clarity:", clarity) ))+
geom_smooth(aes(colour=cut, fill=cut))+
facet_wrap(~ cut)
