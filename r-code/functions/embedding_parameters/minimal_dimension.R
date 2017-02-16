#
#
#       Minimal Dimension Function
# 
#   > Miguel Perez-Xochicale <perez.xochicale AT gmail.com>
#   > Doctoral Researcher in Human-Robot Interaction
#   > University of Birmigham, U.K. (2014-2017)
#   > https://twitter.com/mperezxochicale
#
#

############
# How to use 
# add the following line to your main script 
# for the directory where the functions and the R scripts lives, you have to add
#
#     source("~/mxochicale/phd/r-code/functions/embedding_parameters/minimal_dimension.R")
#  
#




######################
# MODIFICATIONS

# 
#
#
# *2nd of December 2015
#  modification
#    function(E,maxd) to function(E) using length
# 
# *creation 1st December 2015


# TODO
# * cao97sub return matrix instead of a list object



library(lattice) ##xyplot




#-----------------------------------------------------------------------------
#--------------------  cao97 FORTRAN subrutine wraped in R  --------------------------
#build dll to wrap f function in R
#R CMD SHLIB cao97sub.f
# which produce cao97sub.so and cao97sub.o

cao97sub <- function(x,maxd,tau) {
  dyn.load("~/mxochicale/phd/r-code/functions/embedding_parameters/cao97sub.so")
  lx = length(x)
  retdata <- .Fortran("cao97sub",
                      x = as.double(x),
                      lx = as.integer(lx),
                      maxd = as.integer(maxd),
                      tau = as.integer(tau),
                      e1 = double(maxd),
                      e2 = double(maxd)
  )
  return(list(retdata$e1[1:maxd-1], retdata$e2[1:maxd-1]))
}
##example
## e1 <- cao97sub(Gy_zmuv,20,10)





#-----------------------------------------------------------------------------
#--------------------  Plot E1 values  --------------------------
plot_E1_values <- function(E,k) {
plot <- xyplot( E[[1]] +  E[[3]] +  E[[5]]  +  E[[7]] +  E[[9]] +
          E[[11]] +  E[[13]] +  E[[15]]  +  E[[17]] +  E[[19]] 
        ~ 1: ( length(E) -1),
        type = "b", lwd=4,
        pch=1:10, # control the plot characters, 
        col.line= c(1:10),
        cex=3, # control the characther expansion for characters     
        main=list(label=paste("participant_",k,sep=""), cex=3, fontfamily="Times"), #Control the character expansion ratio (cex)
        xlab=list(label="Dimension", cex=3, fontfamily="Times"),
        ylab=list(label="E1 values", cex=3, fontfamily="Times"),
        scales=list(
          y=list(limits=c(-0.07,1.15)),
          font=2, cex=1.5),# size of the number labels from the x-y axes
        grid = TRUE,
        
        key=list(  
          text = list(c(expression(paste(tau, "=1")),
                        expression(paste(tau, "=2")),
                        expression(paste(tau, "=3")),
                        expression(paste(tau, "=4")),
                        expression(paste(tau, "=5")),
                        expression(paste(tau, "=6")),
                        expression(paste(tau, "=7")),
                        expression(paste(tau, "=8")),
                        expression(paste(tau, "=9")),
                        expression(paste(tau, "=10"))
          )
          ),
          lines = list(pch=c(1:10), col= c(1:10) ),
          type="b",
          cex=2, # control the character expansion  of the symbols
          corner=c(0.95,0.05) # position
        ) 
)


print(plot)
}
##example
##plot_E1_values(E,maxdim)




#-----------------------------------------------------------------------------
#--------------------  Plot E2 values  --------------------------
plot_E2_values <- function(E,k) {
  plot <- xyplot( E[[2]] +  E[[4]] +  E[[6]]  +  E[[8]] +  E[[10]] +
                        E[[12]] +  E[[14]] +  E[[16]]  +  E[[18]] +  E[[20]] 
                      ~ 1: ( length(E) -1),
                      type = "b", lwd=4,
                      pch=1:10, # control the plot characters, 
                      col.line= c(1:10),
                      cex=3, # control the characther expansion for characters     
                  main=list(label=paste("participant_",k,sep=""), cex=3, fontfamily="Times"), #Control the character expansion ratio (cex)
                      xlab=list(label="Dimension", cex=3, fontfamily="Times"),
                      ylab=list(label="E2 values", cex=3, fontfamily="Times"),
                      scales=list(
                        y=list(limits=c(-0.07,1.15)),
                        font=2, cex=1.5),# size of the number labels from the x-y axes
                      grid = TRUE,
                    
                    key=list(  
                      text = list(c(expression(paste(tau, "=1")),
                                    expression(paste(tau, "=2")),
                                    expression(paste(tau, "=3")),
                                    expression(paste(tau, "=4")),
                                    expression(paste(tau, "=5")),
                                    expression(paste(tau, "=6")),
                                    expression(paste(tau, "=7")),
                                    expression(paste(tau, "=8")),
                                    expression(paste(tau, "=9")),
                                    expression(paste(tau, "=10"))
                      )
                      ),
                      lines = list(pch=c(1:10), col= c(1:10) ),
                      type="b",
                      cex=2, # control the character expansion  of the symbols
                      corner=c(0.95,0.05) # position
                    ) 
            )
  
  print(plot)
  
    
}
##example
##plot_E2_values(E,maxdim)



# 
# #
# # E1 values
# #
# png(filename="E1_values.png", height=900, width=1500,bg="white")
#
# dev.off() # Turn off device driver (to flush output to PNG)
# 
# 
