#----------------------------------------------------------------
#
#
# Miguel P. Xochicale [http://mxochicale.github.io]
# Doctoral Researcher in Human-Robot Interaction
# University of Birmingham, U.K. (2014-2018)
#
#
#------------------------------------------------------------
#
# https://rawgit.com/wiki/Rdatatable/data.table/vignettes/datatable-intro.html#data

#  wget https://raw.githubusercontent.com/wiki/arunsrinivasan/flights/NYCflights14/flights14.csv


library('data.table')

DT = data.table(ID = c('b','b','b','a','a','c'), a=1:6, b=7:12, c=13:18 )
DT
class(DT$ID)

flights <- fread('flights14.csv')
flights
dim(flights)

#######################
# Get all flights with "JFK" as the origin airport in the month of June
ans <- flights[origin == 'JFK' & month == 6L]
head(ans)

#######################
# Get the first two rows from flights
ans <- flights[1:2]
ans


#######################
# Sort flights first by column 'origin' in ascending order, and then by 'dest'
# in descending order:
ans <- flights[ order(origin, -dest) ]
ans


#######################
# Select arr_delay column, but return it as a vector.
ans <- flights[,arr_delay]
head(ans)

#######################
# Select arr_delay column, but return it as a data.table instead.
ans <- flights[,list(arr_delay)]
head(ans)


#######################
# Select both arr_delay column and dep_delay column  and return it as a data.table
ans <- flights[, .(arr_delay,dep_delay)]
head(ans)

#######################
# Select both arr_delay and dep_delay columns and rename them to delay_arr and delay_dep.
ans <- flights[, .(delay_arr = arr_delay, delay_dep = dep_delay)]
head(ans)


#######################
# (e) How many trips have had total delay < 0?
ans <- flights[, sum(  (arr_delay + dep_delay)  < 0 )  ]
ans


#######################
# (f) Calculate the average arrival and departure delay for all flights
# with 'JFK' as the origin airport in the month of June
ans <- flights[ origin == 'JFK' & month == 6L , .( m_arr = mean(arr_delay),m_dep = mean(dep_delay)  )]
ans


#######################
# How many trips have been made in 2014 from 'JFK' airport in the month of June?
#ans <- flights[origin =='JFK' & month == 6L, ]
ans <- flights[origin =='JFK' & month == 6L, length(dest)]
ans

# .N is a special in-built variable that holds the number of observations in the current group.
ans <- flights[origin =='JFK' & month == 6L, .N]
ans


#######################
# (g) Select both arr_delay and dep_delay columns the data.frame way.
ans <- flights[ , c('arr_delay', 'dep_delay'), with = FALSE]
ans


DF = data.frame( x= c(1,1,1,2,2,3,3,3), y=1:8 )
# (1) normal way
DF[DF$x >1,]
# (2) using with
DF[ with(DF, x>1 ), ]

# return all columns except arr_delay and dep_delay
ans <- flights[, !c("arr_delay","dep_delay") , with=FALSE]
ans

ans <- flights[, -c("arr_delay","dep_delay") , with=FALSE]
ans

# return year, month and day
ans <- flights [, year:day, with=FALSE ]
ans
# returns all columns except year, month and day.
ans <- flights [, -(year:day), with=FALSE ]
ans





#######################
# (2) Aggreatations
# (a) How can we get the number of trips corresponding to each origin airport?
ans <- flights[ , .(.N), by= .(origin)]
ans

# How can we calculate the number of trips of each origin airport for carrier code "AA"?
ans <- flights[ carrier =='AA', .(.N), by = .(origin)]
ans


# How can we calculate the number of trips for each origin,dest pair for carrier code 'AA'?
ans <- flights[ carrier =='AA', .(.N), by = .(origin,dest)]
head(ans)

# How can we get the average arrival and departure delay for each origing,dest pair for
# each month for arrier code 'AA'?
ans  <- flights [
                  carrier =='AA',
                  .(m_arr = mean(arr_delay), m_dep = mean(dep_delay) ),
                  by = .(origin, dest, month)]
ans



#######################
# (b) keyby
ans  <- flights [ carrier =='AA',
                  .(m_arr = mean(arr_delay), m_dep = mean(dep_delay) ),
                  keyby = .(origin, dest, month)]
ans

#######################
# (c) Chaining
# How can we order ans using the columns origin in ascending order, and dest in
# descending order?
ans <- ans[ order(origin, -dest) ]
ans

ans  <- flights [ carrier =='AA',
                  .( .N ),
                  by = .(origin, dest)][ order(origin, -dest)]
head(ans,10)


#######################
# (d) Expressions in by
# Can by accept expressions as well or just take columns?
ans <- flights[, .N, .(dep_delay >0, arr_delay>0)]
ans






#######################
# Subset of Data SD
# (e) Do we have to compute mean() for each column individually?
DT
DT[, print(.SD), by = ID]
# To compute on (multiple) columns,we can then simply use the baseR function lapply()
DT[, lapply(.SD, mean), by = ID]


# How can we specify just the columns we would like to compute the mean() on?
# Let us try to use .SD along wioth .SDcols to get the mean() of arr_delay and
# dep_delay columns grouped by origin,dest pair and month
ans <- flights[ carrier == 'AA',            ##Only on trips with carrier "AA"
                lapply(.SD, mean),                      ## compute the mean
                by = .(origin, dest, month),            ## for every 'origin, dest, month'
                .SDcols = c("arr_delay", "dep_delay")   ## for just those specified in .SDcols
                 ]
ans


#######################
# (f) How can we return the first two rows for each month ?
ans <- flights[, head(.SD,2), by= month]
head(ans)











#######################
# ()
