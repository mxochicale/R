#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#
#
# FileName:           plotly05.R
# FileDescription:
#
#
# Reference:
#           fromthebottomoftheheap.net/2013/10/23/time-series-plots-with-lattice-and-ggplot
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

set.seed(1)

tdat <- data.frame( Site=rep( paste0("Site", c("A","B")),each = 100),
                    Date=rep( seq(Sys.Date(), by="1 day", length=100), 2),
                    Fitted=c(cumsum(rnorm(100)), cumsum(rnorm(100))),
                    Signf=rep(NA,200)
                    )

tdat <- transform(tdat, Upper=Fitted+1.5, Lower=Fitted-1.5)
## select 1 region per Site as signif
take <- sample(10:70,2)
take[2] <- take[2] + 100
tdat$Signf[take[1]:(take[1] + 25)] <- tdat$Fitted[take[1]:(take[1] + 25)]
tdat$Signf[take[2]:(take[2] + 25)] <- tdat$Fitted[take[2]:(take[2] + 25)]


ggplot( tdat, aes(x=Date, y= Fitted, group=Site) )+
  geom_line()+
  geom_line(mapping=aes(y=Upper),lty="dashed")+
  geom_line(mapping=aes(y=Lower),lty="dashed")+
  geom_line(mapping=aes(y=Signf), lwd=1.3, colour= "red") +
  facet_wrap(~ Site)
