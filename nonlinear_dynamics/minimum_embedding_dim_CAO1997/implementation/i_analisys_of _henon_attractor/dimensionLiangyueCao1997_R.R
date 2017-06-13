
###################################################
###################################################
### NOTA BENE:
### 
###  R source code takes around 4 hours to compute
###  the E1 and E2 values for the current parameters
###  while fortran code only takes less than 5 seconds
###  
###  ***MEASURE THE TIME OF PERFORMANCE
### 
### Perez Xochicale M. A.
### Tue Dec 16 15:43:19 GMT 2014
###
###################################################
###

###

#***************************************************************************
#*      Pratical method for determing the minimum embedding dimension      *
#*                     of a scalar time series                             *
#*           L. Cao, Physica D, 110 (1 & 2), 43-52, 1997.                  *
#*                                                                         *
#*   Notices:   This program is ONLY used for your researches.             *
#*                                                                         *
#*                                  Liangyue Cao       March,1997.         *
#***************************************************************************
#
# 
# Fortran Version by Christophe LETELLIER
# France 03/04/2013
# [www.atomosyd.net/spip.php?article128]
# 
# R Version byPerez-Xochicale M. A. 
# December 2014 
# CONACYT Mexico - University of Birmingham, UK
# [https://sites.google.com/site/perezxochicale/????????????????????]
# 
####learn how to use github so as to upload all my scripts
#

library(lattice) ##xyplot


x <- NULL;
v <- NULL;
v0 <- NULL;
vij <- NULL;
a <- NULL;
ya <- NULL;
d <- NULL;
tau <- NULL;


#
# ndp - is the number of data points used for computations
# tau - is the time-delay embedding parameter
# maxd - is the maximum dimension which you want to test.
#

ndp <- 1000
tau <- 1

maxd <-10


#Sample, Time, YAW, PITCH, ROLL
setwd(getwd()); # set and get the current working directory
x <- read.csv('henon_xn_N1000.dat', header = FALSE, sep=' ');


dimensionCao <- function(x,tau,maxd) {

  E1 <- matrix(0,1,maxd)  
  E2 <- matrix(0,1,maxd) 
  
  a <- matrix(0,1,maxd)
  ya <- matrix(0,1,maxd)

  
  #+++++++++++++++++++++++++++++++++++++++++++
  for(d in 1:maxd) {
    
    v <- matrix(0,1,d)
    
    ng <-ndp - d*tau
    v <- matrix(0,1,d)
    
    
      #######################################
      # This section is for configuring the for loops
      # that do not cotemplate the negatives values of ng in the i-th loop
      forloop_ij_start <- ifelse(ng > 0, 1, 0)
      ng <- ifelse(ng <= 0, 0, ng)
      #######################################
      
      #+++++++++++++++++++++++++++++++++++++++++++
      for(i in forloop_ij_start:ng) {
        v0 <- 1e30

            #+++++++++++++++++++++++++++++++++++++++++++
            for (j in forloop_ij_start:ng){
                            
              if(j==i){
                #print("equal")
              }
              else
              {
                #cat(sprintf("j and i are different\n"))
                
                for(k in 1:d){
                  v[1,k]=abs( x[i+(k-1)*tau,1] - x[j+(k-1)*tau,1] )
                }
                if (d==1){
                  vij=v[1,d]
                    if((vij < v0) & (vij != 0)  ){
                    n0=j
                    v0=vij                    
                  }
                }
                else ##if d != than 1
                {
                  
                  for(k in 1:(d-1)){
                    v[1,k+1] = max(v[1,k],v[1,k+1])
                   
                  }
                  vij=v[1,d]
                  
                    
                  if((vij < v0) & (vij != 0)  ){
                    n0=j
                    v0=vij                    

                  }
                  
                }
                
                
              }
              
              
              
            }#-------------------------------------------
        
        
        a[1,d]=a[1,d] + (max(v0,abs(x[i+d*tau,1]-x[n0+d*tau,1]))/v0)

        ya[1,d]=ya[1,d] + (abs(x[i+d*tau,1]-x[n0+d*tau,1]))
        
        
        
        
      }#-------------------------------------------

    
    a[1,d]=a[1,d]/ng
    ya[1,d]=ya[1,d]/ng
    
    if (d >=2 ){

      E1[1,d]=a[1,d]/a[1,d-1]
      E2[1,d]=ya[1,d]/ya[1,d-1]
      
    }
    
    
  }#-------------------------------------------

  list(E1=E1, E2=E2)

}






# ###FUNCTION
# E1 <- 
EE <- dimensionCao(x,tau,maxd)
EE$E1
EE$E2

write(EE$E1, file = "E1_R.dat", ncolumns=1)
write(EE$E2, file = "E2_R.dat", ncolumns=1)

dimension_ith <- 1:maxd

xyplot(EE$E1 + EE$E2 ~ dimension_ith,
       pch=16, col.line = c('red', 'blue'), type = c("l","g"), lwd=3,
       main=list(label="", cex=2.5),
       xlab=list(label="Dimension", cex=3),
       ylab=list(label="E1 & E2", cex=3),
       scales=list(cex=1.5),# size of the number labels from the axes
       auto.key=list(points = F, lines = T, border= "grey", cex=2, corner=c(0.95,0.05))
      )


