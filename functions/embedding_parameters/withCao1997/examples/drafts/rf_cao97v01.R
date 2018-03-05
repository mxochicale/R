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

# rawdata <- NULL;
# # rawdata<-read.csv("datafile", header=TRUE, sep=',');
# rawdata<-read.csv("data.dat", header=FALSE, sep=',');
# X <-rawdata[,]
# rawdata <- NULL;
#


################################################################################
# (2) Reading data
signals <- fread("sincos.dt", header=TRUE)


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
X <- signals$xnsinnoise

maxdim <-10
maxtau <-10

e <- NULL
for (j_tau in 1:maxtau){
  message( 'tau: ', j_tau)
  # E<- append (  E,  cao97sub(X,maxdim,j_tau)  )

  tmp <- as.data.table(cao97sub(X,maxdim,j_tau))
  colnames(tmp) <- c(paste('E1', '_T', j_tau,sep=""), paste('E2', '_T', j_tau,sep=""))

  e <- append (  e,   tmp )
  # E<- rbind (  E,  as.data.table(cao97sub(X,maxdim,j_tau))  )
}
E<-as.data.table(e)
E[,dim:=seq(.N)]
setcolorder(E,c( (ncol(E)),1:(ncol(E)-1) ))



################################################################################
# (2) Plotting

####E1
e1 <- ggplot(E,aes(x=dim,y=E1_T1)) +
    geom_line()+
    geom_line(mapping = aes(y = E1_T2))+
    geom_line(mapping = aes(y = E1_T3))+
    geom_line(mapping = aes(y = E1_T4))+
    geom_line(mapping = aes(y = E1_T5))+
    geom_line(mapping = aes(y = E1_T6))+
    geom_line(mapping = aes(y = E1_T7))+
    geom_line(mapping = aes(y = E1_T8))+
    geom_line(mapping = aes(y = E1_T9))+
    geom_line(mapping = aes(y = E1_T10))+
    labs(x= "dimension", y="E1")+
    theme_bw(20)


####E2
e2 <- ggplot(E,aes(x=dim,y=E2_T1)) +
    geom_line()+
    geom_line(mapping = aes(y = E2_T2))+
    geom_line(mapping = aes(y = E2_T3))+
    geom_line(mapping = aes(y = E2_T4))+
    geom_line(mapping = aes(y = E2_T5))+
    geom_line(mapping = aes(y = E2_T6))+
    geom_line(mapping = aes(y = E2_T7))+
    geom_line(mapping = aes(y = E2_T8))+
    geom_line(mapping = aes(y = E2_T9))+
    geom_line(mapping = aes(y = E2_T10))+
    labs(x= "dimension", y="E2")+
    theme_bw(20)



#
# # png(filename="E2_values.png", height=900, width=1500,bg="white")
# # dev.off() # Turn off device driver (to flush output to PNG)



################################################################################
setwd(r_scripts_path) ## go back to the r-script source path
