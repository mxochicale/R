#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#
#
# FileName:           plotly02.R
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

library(plyr) # wrapper
library(ggplot2)

date <- rep(as.Date(1:365, origin='2011-1-1'),7  )
location <- factor(rep(1:7,365))
product <- rep(letters[1:7], each=365)
value <- c(
            sample(1:10,size=365,replace=T),
            sample(1:3,size=365,replace=T),
            sample(10:100,size=365,replace=T),
            sample(1:50,size=365,replace=T),
            sample(1:20,size=365,replace=T),
            sample(50:100,size=365,replace=T),
            sample(1:100,size=365,replace=T)
  )

dat <- data.frame(date,location,product, value)

corr_dat <- ddply(dat, .(product), summarise, value=value)
corr.df <- unstack(corr_dat, value~product)

corr_plot <- data.frame( date=max(dat$date),
                        label=paste0("rho==", round(cor(corr.df)[,1],2 ) ),
                        ddply(dat, .(product), summarise,
                              value=(min(value)+max(value))/2 ))

ggplot(dat, aes(x=date, y=value, color=location, group=location)) +
      geom_line()+
      facet_grid(product ~ ., scale = "free_y")
