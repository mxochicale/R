
library(data.table)
library(ggplot2)

################################################################################
# (1) Defining paths for main_path, r_scripts_path, ..., etc.
r_scripts_path <- getwd()



################################################################################
# (2) Reading data
X <- t(fread("datafile", header=TRUE))




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





maxdim <-20
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











################################################################################
setwd(r_scripts_path) ## go back to the r-script source path
