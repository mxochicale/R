#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#
#
# FileName:           example00.R
# FileDescription:
# https://www.r-bloggers.com/ggplot2-time-series-heatmaps/
# https://gist.github.com/theHausdorffMetric/2387786
#
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# Miguel P. Xochicale [http://mxochicale.github.io]
# Doctoral Researcher in Human-Robot Interaction
# University of Birmingham, U.K. (2014-2018)
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++



#################
# Start the clock!
start.time <- Sys.time()


###############
# Load Packages
require(ggplot2)
require(quantmod) #wrapper to load data from different sources
require(plyr) #tools for splitting, appliying and combining data



################################################################################
# (1) Defining paths for main_path, r_scripts_path, ..., etc.
r_scripts_path <- getwd()



setwd("../")
setwd("../")
main_repository_path <- getwd()
# setwd("../")
# main_path <- getwd()


outcomes_path <- paste(main_repository_path,"/DataSets/vix",sep="")



# Download some Data, e.g. the CBOE VIX
# https://uk.finance.yahoo.com/quote/%5EVIX/history?p=%5EVIX
getSymbols("^VIX",src="yahoo")

# Make a dataframe
dat<-data.frame(date=index(VIX),VIX)

# We will facet by year ~ month, and each subgraph will
# show week-of-month versus weekday
# the year is simple
dat$year<-as.numeric(as.POSIXlt(dat$date)$year+1900)
# the month too
dat$month<-as.numeric(as.POSIXlt(dat$date)$mon+1)
# but turn months into ordered facors to control the appearance/ordering in the presentation
dat$monthf<-factor(dat$month,levels=as.character(1:12),labels=c("Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"),ordered=TRUE)
# the day of week is again easily found
dat$weekday = as.POSIXlt(dat$date)$wday
# again turn into factors to control appearance/abbreviation and ordering
# I use the reverse function rev here to order the week top down in the graph
# you can cut it out to reverse week order
dat$weekdayf<-factor(dat$weekday,levels=rev(1:7),labels=rev(c("Mon","Tue","Wed","Thu","Fri","Sat","Sun")),ordered=TRUE)


# the monthweek part is a bit trickier
# first a factor which cuts the data into month chunks
dat$yearmonth<-as.yearmon(dat$date)
dat$yearmonthf<-factor(dat$yearmonth)

# then find the "week of year" for each day
dat$week <- as.numeric(format(dat$date,"%W"))



# and now for each monthblock we normalize the week to start at 1
dat<-ddply(dat,.(yearmonthf),transform,monthweek=1+week-min(week))






# Now for the plot
P<- ggplot(dat, aes(monthweek, weekdayf, fill = VIX.Close)) +
    geom_tile(colour = "white") + facet_grid(year~monthf) + scale_fill_gradient(low="red", high="yellow")
    #+opts(title = "Time-Series Calendar Heatmap") +  xlab("Week of Month") + ylab("")
P








#################
# Stop the clock!
end.time <- Sys.time()
end.time - start.time


################################################################################
setwd(r_scripts_path) ## go back to the r-script source path
