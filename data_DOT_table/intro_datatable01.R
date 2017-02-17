#----------------------------------------------------------------
#
# Miguel P. Xochicale [http://mxochicale.github.io]
# Doctoral Researcher in Human-Robot Interaction
# University of Birmingham, U.K. (2014-2018)
#
#
#------------------------------------------------------------
#
# Main Reference
# labbcb.github.io/basics/ggplotBasics.html

# wget https://dl.dropboxusercontent.com/u/83643/AirlineSubset1pct.csv.gz
# gunzip AirlineSubset1pct.csv.gz



library('data.table') # for manipulating data
library('dplyr') # for manipulating data
library('ggplot2') # for visualising data

fname <- '/home/map479-admin/mxochicale/phd/r-code/data_analysis/AirlineSubset1pct.csv'
airline <- fread(fname)
# airline <- read.csv(fname, header=TRUE)

airline <- data.table(airline)
airline[ , 1:7, with=FALSE]
summary (  airline[ , 1:7, with=FALSE]  )
dim(airline)

# Will convert Year/Month/DayOfWeek/DayofMonth to ordered factors
airline$Year = factor(airline$Year, ordered=TRUE)
airline$Month = factor(airline$Month, ordered=TRUE)
airline$DayOfWeek = factor(airline$DayOfWeek, ordered=TRUE)
airline$DayofMonth = factor(airline$DayofMonth, ordered=TRUE)


# Keep only flights that were not cancelled
airline = subset(airline, Cancelled==0)
dim(airline)



# ##################################
# # Making histograms with ggplot2
# # ggplot2 requires data in the long-format
# # always use ggplot to start and combine aes() to define plot details (x,y,color)
# # always use a geom_ to define plot type
# myp = ggplot(airline, aes(ArrDelay)) + geom_histogram(binwidth=1)
# myp + xlim(-60,60)
#
#
# # Making stratified density plots -I
# myp = ggplot(airline, aes(ArrDelay)) + geom_density()
# myp +  facet_grid(DayOfWeek ~ . )  +  xlim(-60,60)
#
#
# # Making stratified density plots -II
# myp = ggplot(airline, aes(ArrDelay, colour=Month) )
# myp + geom_density() + xlim(-100, 100)


# Operating with 'dplyr' for plotting
tmp = group_by(airline, Year, Month, DayofMonth)
delays = summarise(tmp, prop= mean (ArrDelay>15, na.rm=TRUE)  )
delays


library(lubridate)
cal = function(dt){
  year = year(dt)
  month = month(dt)
  day = day(dt)
  first = ymd( paste( year, month, 1, sep='-' ))
  wday_first = wday(first)
  offset = 5 + wday_first
  weekrow = ((day+offset) %/% 7) -1
  daycol = (day+offset) %% 7
  cbind(weekrow, daycol)
}


tmp = cal( with(delays, paste(Year, Month, DayofMonth, sep='-') ) )
delays$weekrow = factor(tmp[,1], levels=5:0, ordered=TRUE)
delays$daycol = factor(tmp[,2], levels=0:6, ordered=TRUE)

logit = function(p) log(p/(1-p))
head(delays)

myp = ggplot(delays, aes(daycol, weekrow, fill=logit(prop)) )
myp = myp + geom_tile() + facet_grid(Month ~ Year)
myp = myp + scale_fill_continuous(low='green', high='red')
myp = myp + theme(axis.ticks=element_blank(),
                  axis.title.x=element_blank(),
                  axis.title.y=element_blank(),
                  axis.text.x=element_blank(),
                  axis.text.y=element_blank(),
                  legend.position='none'
                  )
myp




#
