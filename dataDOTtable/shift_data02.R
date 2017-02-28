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
DT = data.table(year=2010:2014,
  v1=runif(5),
  v2=1:5,
  v3=letters[1:5])
cols = c("v1","v2","v3")

anscols = paste("lead", cols, sep="_")
DT[, (anscols):= shift(.SD, n=1, fill=NA, type="lead"), .SDcols=cols ]



#
# ############################
# # return a new data.table instead of updating
# # with names automatically set
# DT = data.table(year=2010:2014,
#   v1=runif(5),
#   v2=1:5,
#   v3=letters[1:5])
# DT[,shift(.SD, n=1:2, fill=NA, type="lead", give.names=TRUE), .SDcols=2:4]



# ##############################
# # lag/lead in the right order
# DT = data.table(year=2010:2014,
#   v1=runif(5),
#   v2=1:5,
#   v3=letters[1:5])
# DT = DT[sample(nrow(DT))]
# # add lag=1 for columns "v1","v2","v3" in increasing order of 'year'
# cols = c("v1","v2","v3")
# anscols = paste("lead", cols, sep="_")
#
# # DT[, (cols):= shift(.SD, 1, type="lag"), .SDcols=cols ]
# DT[order(year), (cols):= shift(.SD, 2, type="lag"), .SDcols=cols ]
# DT[order(year)]


#
# ##############################
# # while grouping
# DT = data.table(year=rep(2010:2011, each=3),
#   v1=1:6)
# # DT[, c("lag1", "lag2"):= shift(.SD, 1:2), by=year]
# DT[, c("lag1", "lag2"):= shift(.SD, 1:2), by=year]
