################################################################################
#
#
# FileName:
# reading_TIS_DATA_p01p22.R
# FileDescription:
#
# Discarded Participants (p13 & p16)
# The instructions for participant 13 were given wrongly
# that is that the activity 03 were performed first and activity 01 were performed as the third one
# to which the data was not considered for further analysis.
#
# For participant 16,
# the data is not well syncrohised due to the careless procedure when computing
# the  values for the clock time alignment to which, data fro this participant
# were descarded
#
#
#
################################################################################
# Miguel P. Xochicale [http://mxochicale.github.io]
# Doctoral Researcher in Human-Robot Interaction
# University of Birmingham, U.K. (2014-2018)
################################################################################


library(data.table)
library(ggplot2)



################################################################################
# (1) Defining paths for main_path, r_scripts_path, ..., etc.
r_scripts_path <- getwd()

setwd("../")
main_path <- getwd()

data_path <- paste(main_path,"/timeseries",sep="")
setwd(file.path(data_path))


################################################################################
# (2) Reading data
signals <- fread("periodic.dt", header=TRUE)
# signals <- fread("chaotic.dt", header=TRUE)


################################################################################
# (2) CAO's Algorithm
setwd(file.path(r_scripts_path))



cao97sub <- function(x,maxd,tau) {
    dyn.load("cao97_subroutine.so")
    lx = length(x)
    retdata <- .Fortran("cao97_subroutine",
                        x = as.double(x),
                        lx = as.integer(lx),
                        maxd = as.integer(maxd),
                        tau = as.integer(tau),
                        e1 = double(maxd),
                        e2 = double(maxd)
                        )
    return(list(retdata$e1[1:maxdim-1], retdata$e2[1:maxdim-1]))
 }


# X <- signals$xnsin
# X <- signals$xnsinnoise
# X <- signals$xnsincos
X <- signals$xnsincosnoise

# X <- signals$Xl


maxdim <-50
maxtau <-30

e <- NULL
for (j_tau in 1:maxtau){
  message( 'tau: ', j_tau)
  # E<- append (  E,  cao97sub(X,maxdim,j_tau)  )

  tmp <- as.data.table(cao97sub(X,maxdim,j_tau))
  tmp[,dim:=seq(.N)]
  setcolorder(tmp,c( (ncol(tmp)),1:(ncol(tmp)-1) ))

  if (j_tau == 1){
  fsNNtmp <-function(x) {list("T01")}
  } else if (j_tau == 2){
  fsNNtmp <-function(x) {list("T02")}
  } else if (j_tau == 3){
  fsNNtmp <-function(x) {list("T03")}
  } else if (j_tau == 4){
  fsNNtmp <-function(x) {list("T04")}
  } else if (j_tau == 5){
  fsNNtmp <-function(x) {list("T05")}
  } else if (j_tau == 6){
  fsNNtmp <-function(x) {list("T06")}
  } else if (j_tau == 7){
  fsNNtmp <-function(x) {list("T07")}
  } else if (j_tau == 8){
  fsNNtmp <-function(x) {list("T08")}
  } else if (j_tau == 9){
  fsNNtmp <-function(x) {list("T09")}
  } else if (j_tau == 10){
  fsNNtmp <-function(x) {list("T10")}
  } else if (j_tau == 11){
  fsNNtmp <-function(x) {list("T11")}
  } else if (j_tau == 12){
  fsNNtmp <-function(x) {list("T12")}
  } else if (j_tau == 13){
  fsNNtmp <-function(x) {list("T13")}
  } else if (j_tau == 14){
  fsNNtmp <-function(x) {list("T14")}
  } else if (j_tau == 15){
  fsNNtmp <-function(x) {list("T15")}
  } else if (j_tau == 16){
  fsNNtmp <-function(x) {list("T16")}
  } else if (j_tau == 17){
  fsNNtmp <-function(x) {list("T17")}
  } else if (j_tau == 18){
  fsNNtmp <-function(x) {list("T18")}
  } else if (j_tau == 19){
  fsNNtmp <-function(x) {list("T19")}
  } else if (j_tau == 20){
  fsNNtmp <-function(x) {list("T20")}
  } else if (j_tau == 21){
  fsNNtmp <-function(x) {list("T21")}
  } else if (j_tau == 22){
  fsNNtmp <-function(x) {list("T22")}
  } else if (j_tau == 23){
  fsNNtmp <-function(x) {list("T23")}
  } else if (j_tau == 24){
  fsNNtmp <-function(x) {list("T24")}
  } else if (j_tau == 25){
  fsNNtmp <-function(x) {list("T25")}
  } else if (j_tau == 26){
  fsNNtmp <-function(x) {list("T26")}
  } else if (j_tau == 27){
  fsNNtmp <-function(x) {list("T27")}
  } else if (j_tau == 28){
  fsNNtmp <-function(x) {list("T28")}
  } else if (j_tau == 29){
  fsNNtmp <-function(x) {list("T29")}
  } else if (j_tau == 30){
  fsNNtmp <-function(x) {list("T30")}
  }

  # tj<-paste('T',j_tau,sep='')
  # tmp[,c("TAU") := .(list(NULL) ) ]
  # tmp[,c("TAU"):=function(x) {list(tj)}, ]
  # tmp[,c("TAU"):=list(function(x) tj ), ]

  tmp[,c("TAU"):=fsNNtmp(), ]
  setcolorder(tmp,c( (ncol(tmp)),1:(ncol(tmp)-1) ))

  colnames(tmp)[3:4] <- c('E1','E2')

  # e <- append (  e,   tmp )
  e <- rbind (  e,   tmp )

}

E<-as.data.table(e)
# E[,dim:=seq(.N)]
# setcolorder(E,c( (ncol(E)),1:(ncol(E)-1) ))




################################################################################
# (2) Plotting


e1 <- ggplot(E, aes(x=dim, y=E1, colour=TAU, group=TAU)) + geom_line() +theme_bw(20)
e2 <- ggplot(E, aes(x=dim, y=E2, colour=TAU, group=TAU)) + geom_line() +theme_bw(20)



#
# # png(filename="E2_values.png", height=900, width=1500,bg="white")
# # dev.off() # Turn off device driver (to flush output to PNG)



################################################################################
setwd(r_scripts_path) ## go back to the r-script source path
