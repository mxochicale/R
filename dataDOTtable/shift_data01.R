#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#
#
# FileName:           shift_data01.R
# FileDescription:
#                     Advanced tutorial on the use of data.table
#
# Reference:
#           hpps://brooksandrew.github.io/simpleblog/articles/advamced-data-table
#
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# Miguel P. Xochicale [http://mxochicale.github.io]
# Doctoral Researcher in Human-Robot Interaction
# University of Birmingham, U.K. (2014-2018)
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#
#
#

library('data.table') # for manipulating data

############################
# Shift with by

n <- 30
dt <- data.table(
  date=rep( seq( as.Date('2010-01-01'), as.Date('2015-01-01'), by='year' ), n/6 ),
  ind=rpois(n,5),
  entity=sort( rep(letters[1:5], n/5) )
  )
setkey(dt, entity, date)   # important for ordering

## using shift 
dt[,indpct_fast:=( ind/ shift(ind,1) )-1, by=entity]

## using a function
lagpad <- function(x,k) c(rep(NA,k),x)[1:length(x)]
dt[,indpct_slow:=(ind/lagpad(ind,1))-1, by=entity]
