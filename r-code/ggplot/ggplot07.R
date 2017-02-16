#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#
#
# FileName:           plotly07.R
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


# Using linetypes

rescale01 <- function(x) (x-min(x)) / diff(range(x))

ec_scaled <- data.frame(
            date=economics$date,
            plyr::colwise(rescale01)(economics[,-(1:2)])
  )


ecm <- reshape2::melt(ec_scaled, id.vars= "date")

f <- ggplot(ecm, aes(date,value))
f + geom_line(aes(linetype=variable))
