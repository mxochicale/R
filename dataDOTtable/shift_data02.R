#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#
#
# FileName:           shift_data02.R
# FileDescription:
#                     Examples Usage in R documentation
#
# Reference:
#           hpps://rdocumentation.org/packages/data.table/versions/1.10.4/topics/shift
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
# on vectors, returns a vector as long as(n) == 1
x=1:5
#lag with n=1 and pad with NA (returns vector)
shift(x, n=1, fill=NA, type="lag")



############################
# on data.tables
DT = data.table(
  year=2010:2014,
  v1=runif(5),
  v2=1:5,
  v3=letters[1:5])
cols = c("v1","v2","v3")
anscols = paste("lead", cols, sep="_")
DT[, (anscols):= shift(.SD, n=1, fill=NA, type="lead"), .SDcols=cols ]




############################
# return a new data.table instead of updating
# with names automatically set
DT2 = data.table(
   year=2010:2014,
   v1=runif(5),
   v2=1:5,
   v3=letters[1:5])
DT2[,shift(.SD, n=c(1,3), fill=NA, type="lead", give.names=TRUE), .SDcols=2:4]



##############################
# lag/lead in the right order
DT3 = data.table(
	year=2010:2014,
	v1=runif(5),
	v2=1:5,
   	v3=letters[1:5]
	)
DT3 = DT3[sample(nrow(DT3))] # reorganise DT randomly with sample
# add lag=1 for columns "v1","v2","v3" in increasing order of 'year'
cols = c("v1","v2","v3")
anscols = paste("lead", cols, sep="_")

#DT3[            , (cols):= shift(.SD, 2, type="lag"), .SDcols=cols ]  ## add two NA values at the beginning
DT3[order(year), (anscols):= shift(.SD, 2, type="lag"), .SDcols=cols ] ## add randomly two NA values
#DT3[order(year)]



##############################
# while grouping
DT4 = data.table(
	year=rep(2010:2012, each=5),
	v1=1:15
	)
DT4[, c("lag1", "lag2"):= shift(.SD, c(1,3),fill=NA, type='lead'), by=year]
