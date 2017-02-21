#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#
#
# FileName:           intro_datatable02.R
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


dt <- data.table(mtcars)[,.(cyl,gear)]

dt[, unique(gear), by=cyl]


##################################
# summary table (short and narrow)
dt <- data.table(mtcars)[,.(cyl,gear)]
dt[,gearsL:=.( .(unique(gear)) ), by=cyl ] # original and uggly
head(dt)


##################################
# Accessing elements from a column of lists
# Extract second element of each list in gearsL and create row gearL1
dt[,gearL1:=lapply(gearsL, `[`,2)]#dt[ , gearL1:= lapply(gearsL, function(x) x[2])]
dt[,gearS1:=sapply(gearsL, `[`,2)]#dt[ , gearS1:= sapply(gearsL, function(x) x[1])]
head(dt)

str( head(dt[,gearL1]  ) )
str( head(dt[,gearS1]  ) )

# Calculate all the gear s for all cars of each cyl (excluding the current current row).
dt[,other_gear:=mapply(setdiff, gearsL, gear)] #dt[,other_gear:=mapply(function(x,y) setdiff(x,y), x=gearsL, y=gear)]
head(dt)



###################################
# Suppressing intermediate output wiht {}
dt <- data.table(mtcars)

dt[, {tmp1= mean(mpg); tmp2=mean(abs(mpg-tmp1)); tmp3=round(tmp2,2)  }, by=cyl]
#we can be more explicit by passing a named list of what we want to keep.
dt[, {tmp1= mean(mpg); tmp2=mean(abs(mpg-tmp1)); tmp3=round(tmp2,2); .(tmp1=tmp1, tmp2=tmp2, tmp3=tmp3)  }, by=cyl]

#without semicolons
dt[, {  tmp1= mean(mpg)
        tmp2=mean(abs(mpg-tmp1))
        tmp3=round(tmp2,2)
        .(tmp1=tmp1, tmp2=tmp2, tmp3=tmp3) },
    by=cyl]



dt <- data.table(mtcars)[,.(cyl,mpg)]
dt[,tmp1:=mean(mpg), by=cyl][,tmp2:=mean(abs(mpg-tmp1)),by=cyl][,tmp1:=NULL]
head(dt)



###############################
# Fast looping with set
M = matrix(1, nrow=100000, ncol=100)
DF = as.data.frame(M)
DT = as.data.table(DF)

system.time(for (i in 1:1000) DF[i,1L] <- i )
system.time(for (i in 1:1000) DT[i,V1:=i] )
system.time(for (i in 1:1000) M[i,1L] <- i )
system.time(for (i in 1:1000) set(DF,i,1L,i)   )

dt <- data.table(mtcars)[,1:5,with=F]
for(j in c(1L,2L,4L)) set(dt, j=j, value=-dt[[j]]  ) # integers using L passed
for(j in c(3L,5L)) set(dt, j=j, value= paste0(dt[[j]],'**'))
head(dt)


############################
# Using shift for  to lead/lag vectors and lists
dt <- data.table(mtcars)[,.(mpg,cyl)]
dt[,mpg_lag1:=shift(mpg,1)]
dt[,mpg_forward1:=shift(mpg,1, type='lead')]
head(dt)

############################
# Shift with by

n <- 30
dt <- data.table(
  date=rep( seq( as.Date('2010-01-01'), as.Date('2015-01-01'), by='year' ), n/6 ),
  ind=rpois(n,5),
  entity=sort( rep(letters[1:5], n/5) )
  )
setkey(dt, entity, date)   # important for ordering
dt[,indpct_fast:=(ind/shift(ind,1))-1, by=entity]
head(dt,10)

lagpad <- function(x,k) c(rep(NA,k),x)[1:length(x)]
dt[,indpct_slow:=(ind/lagpad(ind,1))-1, by=entity]
head(dt,10)

#################################
# Create multiple columns with := in one statement

dt <- data.table(mtcars)[,.(mpg,cyl)]
dt[, ':='(avg=mean(mpg), med=median(mpg), min= min(mpg)), by=cyl]
head(dt,10)


#################################
# Assign a column with := named with a character object

dt <- data.table(mtcars)[,.(cyl,mpg)]
thing2 <- 'mpgx2'
dt[,(thing2):=mpg*2]
head(dt,10)

#################################
#################################
####
###      2 BY
####
#################################
#################################

#################################
# Calculate a function over a group (using by)
# excluding each entity in a second category
dt <- data.table(mtcars)[,.(cyl,gear,mpg)]
dt[,mpg_biased_mean:=mean(mpg), by=cyl]
# head(dt,10)
