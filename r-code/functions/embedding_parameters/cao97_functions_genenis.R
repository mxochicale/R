library(lattice) ##xyplot

rawdata <- NULL;
rawdata<-read.csv("datafile", header=TRUE, sep=',');
X <-rawdata[,]
rawdata <- NULL;
          
cao97sub <- function(x,maxd,tau) {
    dyn.load("cao97sub.so")
    lx = length(x)
    retdata <- .Fortran("cao97sub",
                        x = as.double(x),
                        lx = as.integer(lx),
                        maxd = as.integer(maxd),
                        tau = as.integer(tau),
                        e1 = double(maxd),
                        e2 = double(maxd)
                        )
    return(list(retdata$e1[1:maxdim-1], retdata$e2[1:maxdim-1]))
 }


maxdim <- 30
maxtau <-10

E <- NULL
for (j_tau in 1:maxtau){
  print(j_tau)
  E<- append (  E,  cao97sub(X,maxdim,j_tau)  )
    
}


#
# E1 values
#
png(filename="E1_values.png", height=900, width=1500,bg="white")

xyplot( E[[1]] +  E[[3]] +  E[[5]]  +  E[[7]] +  E[[9]] +
          E[[11]] +  E[[13]] +  E[[15]]  +  E[[17]] +  E[[19]] 
        ~ 1: (maxdim-1),
        type = "b", lwd=4,
        pch=1:10, # control the plot characters, 
        col.line= c(1:10),
        cex=3, # control the characther expansion for characters     
        main=list(label="", cex=2.5), #Control the character expansion ratio (cex)
        xlab=list(label="Dimension",  font=2, cex=2),
        ylab=list(label="E1 values",  font=2, cex=2),
        scales=list(font=2, cex=1.5),# size of the number labels from the x-y axes
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
dev.off() # Turn off device driver (to flush output to PNG)



#
# E2 values
#
png(filename="E2_values.png", height=900, width=1500,bg="white")
xyplot( E[[2]] +  E[[4]] +  E[[6]]  +  E[[8]] +  E[[10]] +
        E[[12]] +  E[[14]] +  E[[16]]  +  E[[18]] +  E[[20]] 
        ~ 1: (maxdim-1),
        type = "b", lwd=4,
        pch=1:10, # control the plot characters, 
        col.line= c(1:10),
        cex=3, # control the characther expansion for characters     
        main=list(label="", cex=2.5), #Control the character expansion ratio (cex)
        xlab=list(label="Dimension",  font=2, cex=2),
        ylab=list(label="E2 values",  font=2, cex=2),
        scales=list(font=2, cex=1.5),# size of the number labels from the x-y axes
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
dev.off() # Turn off device driver (to flush output to PNG)