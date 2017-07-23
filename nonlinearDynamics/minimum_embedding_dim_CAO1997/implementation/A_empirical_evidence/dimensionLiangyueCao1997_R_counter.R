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

ndp <- 20
tau <- 1

maxd <-10


#Sample, Time, YAW, PITCH, ROLL
setwd(getwd()); # set and get the current working directory
#x <- read.csv('lorenz_N10.dat', header = FALSE, sep=' ');
x <- read.csv('henon_xn.dat', header = FALSE, sep=' ');


dimensionCao <- function(x,tau,maxd) {

  E1 <- matrix(0,1,maxd)  
  E2 <- matrix(0,1,maxd) 
  
  a <- matrix(0,1,maxd)
  ya <- matrix(0,1,maxd)

  counter <- 0
  
  #+++++++++++++++++++++++++++++++++++++++++++
  for(d in 1:maxd) {
    

    v <- matrix(0,1,d)

    
    
    #di <- d;
    #xi <- x[di,1]
    #print("====")
    
    
    
    cat(sprintf("====================\n"))
    cat(sprintf("====   d= %d \n", d))
    cat(sprintf("====================\n"))
    
    
    
    ng <-ndp - d*tau
    v <- matrix(0,1,d)
    
    #cat(sprintf("  ng= %d \n", ng))
    
      #######################################
      # This section is for configuring the for loops
      # that do not cotemplate the negatives values of ng in the i-th loop
      forloop_ij_start <- ifelse(ng > 0, 1, 0)
      ng <- ifelse(ng <= 0, 0, ng)
      #######################################
      
      #+++++++++++++++++++++++++++++++++++++++++++
      for(i in forloop_ij_start:ng) {
        v0 <- 1e30
        
        cat(sprintf("----------------------\n"))
        cat(sprintf("----   i= %d \n", i))
        cat(sprintf("----------------------\n"))
        

            #+++++++++++++++++++++++++++++++++++++++++++
            for (j in forloop_ij_start:ng){
              
              cat(sprintf("----   j= %d \n", j))
              
              if(j==i){
                #print("equal")
              }
              else
              {
                #cat(sprintf("j and i are different\n"))
                
                
                for(k in 1:d){
                  #cat(sprintf("k= %d, i+(k-1)*tau = %d, x[i+(k-1)*tau,1]= %f\n", k, i+(k-1)*tau,x[i+(k-1)*tau,1]))
                  #cat(sprintf("k= %d, j+(k-1)*tau = %d, x[j+(k-1)*tau,1]= %f\n", k, j+(k-1)*tau,x[j+(k-1)*tau,1]))
                  v[1,k]=abs( x[i+(k-1)*tau,1] - x[j+(k-1)*tau,1] )
                  cat(sprintf ("k %d , v(k)=|xi-xj| %f \n" ,k, v[1,k] )  ) 
                  
                  #cat(sprintf("k %d \n", k ))
                  
                  counter = counter + 1
                  
                  cat(sprintf("kkkounter= %d \n ",counter ))
                }
                if (d==1){
                  vij=v[1,d]
                  #cat(sprintf("vij =v(d) %f \n", vij ))
                  
                  #cat(sprintf("(vij <= v0) %s \n", (vij <= v0) ))
                  #cat(sprintf("(vij != 0) %s \n", (vij != 0) ))
                  
                  ##SUNTHAX ERROR WITH THE ORIGINAL VERSION OF .lt. lessthan operation 
                  #if((vij <= v0) & (vij != 0)  ){
                    if((vij < v0) & (vij != 0)  ){
                    n0=j
                    v0=vij                    
                    #cat(sprintf("n0= %f \n", n0 ))
                    #cat(sprintf("v0= %f \n", v0 ))
                  }
                
                }
                else ##if d != than 1
                {
                  
                  for(k in 1:(d-1)){
                    v[1,k+1] = max(v[1,k],v[1,k+1])
                    cat(sprintf("k= %d,  v[1,k+1] = max(v[1,k],v[1,k+1]) = %f \n", k, v[1,k+1]))                    
                    counter = counter + 1
                    cat(sprintf("kounter= %d \n",counter ))
                  }
                  vij=v[1,d]
                  #cat(sprintf("(vij <= v0) %s \n", (vij <= v0) ))
                  #cat(sprintf("(vij != 0) %s \n", (vij != 0) ))
                  
                  
                  ####if((vij <= v0) & (vij != 0)  ){
                    ######################
                    ######################
                    ##ERROR WITH THE .lt. lessthan operation in fortran
                    #j=06 1.6883493065834045     
                    #j=10 1.6883493065834045 
                  ###henceforth, it should be changed to
                    
                    
                    
                  if((vij < v0) & (vij != 0)  ){
                    n0=j
                    v0=vij                    
                    #cat(sprintf("n0= %f \n", n0 ))
                    #cat(sprintf("v0= %f \n", v0 ))
                  }
                  
                }
                
                
              }
              
              cat(sprintf(" counter = %d \n", counter ))      
              
              
            }#-------------------------------------------
        #cat(sprintf(">>>>>>>>>>>>>>>>>>>>\n"))
        #cat(sprintf("v0= %f \n", v0 ))
        #cat(sprintf("i+d*tau =  %d,  %f\n", i+d*tau , x[i+d*tau,1]))
        #cat(sprintf("n0+d*tau =  %d,  %f\n", n0+d*tau , x[n0+d*tau,1]))
        #cat(sprintf("abs(x[i+d*tau,1]-x[n0+d*tau,1]= %f \n", (abs(x[i+d*tau,1]-x[n0+d*tau,1]) )))
        #cat(sprintf("(max(v0,abs(x[i+d*tau,1]-x[n0+d*tau,1]))/v0)= %f \n", (max(v0,abs(x[i+d*tau,1]-x[n0+d*tau,1]))/v0) ))
        
        
        a[1,d]=a[1,d] + (max(v0,abs(x[i+d*tau,1]-x[n0+d*tau,1]))/v0)
        #cat(sprintf("a( %d )= a(d)+ max(..)= %f \n",d, a[1,d] ))
        
        #cat(sprintf("--------------------\n"))
        #cat(sprintf("i+d*tau =  %d,  %f\n", i+d*tau , x[i+d*tau,1]))
        #cat(sprintf("n0+d*tau =  %d,  %f\n", n0+d*tau , x[n0+d*tau,1]))
        #cat(sprintf("abs(x[i+d*tau,1]-x[n0+d*tau,1]= %f \n", (abs(x[i+d*tau,1]-x[n0+d*tau,1]) )))
        ya[1,d]=ya[1,d] + (abs(x[i+d*tau,1]-x[n0+d*tau,1]))
        #cat(sprintf("ya( %d )= ya(d)+ abs(..)= %f \n",d, ya[1,d] ))  
        
        #cat(sprintf("<<<<<<<<<<<<<<<<<<<<\n"))
        
        counter = counter + 1
        
        cat(sprintf("kkkkkkkkkkounter= %d \n ",counter ))
        
      }#-------------------------------------------

    #cat(sprintf("E1E2E1E2E1E2E1E2E1E2E1E2E1E2E1E2E1E2\n"))
    
    a[1,d]=a[1,d]/ng
    ya[1,d]=ya[1,d]/ng
    #cat(sprintf("a[1,%d] = a[1,d]/ng = %f \n",d, a[1,d] ))
    #cat(sprintf("ya[1,%d] = ya[1,d]/ng = %f \n",d, ya[1,d] ))
    
    #cat(sprintf("E1E2E1E2E1E2E1E2E1E2E1E2E1E2E1E2E1E2\n"))
    
    
    if (d >=2 ){

      E1[1,d]=a[1,d]/a[1,d-1]
      E2[1,d]=ya[1,d]/ya[1,d-1]
      
      #cat(sprintf("%d , E1=%f, E2=%f \n", d-1, a[1,d]/a[1,d-1], ya[1,d]/ya[1,d-1] ))      
#      cat(sprintf("%d , E2=%f \n", d-1, ya[1,d]/ya[1,d-1]  ))      
      
    }
    
    
  }#-------------------------------------------

cat(sprintf(" ENDcounter = %d \n", counter ))      

  #return(E1,E2)
  list(E1=E1, E2=E2)

}






# ###FUNCTION
# E1 <- 
EE <- dimensionCao(x,tau,maxd)
EE$E1
EE$E2

dimension_ith <- 1:maxd

xyplot(EE$E1 + EE$E2 ~ dimension_ith,
       pch=16, col.line = c('red', 'blue'), type = c("l","g"), lwd=3,
       main=list(label="", cex=2.5),
       xlab=list(label="Dimension", cex=3),
       ylab=list(label="E1 & E2", cex=3),
       scales=list(cex=1.5),# labels from the 
       auto.key=list(
         points = F, lines = T, border= "grey", cex=2, corner=c(0.95,0.05)
      #   columns=2,
      )
      )

