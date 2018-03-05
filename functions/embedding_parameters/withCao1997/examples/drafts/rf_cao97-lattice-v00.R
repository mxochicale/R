library(lattice) ##xyplot

rawdata <- NULL;
rawdata<-read.csv("datafile", header=TRUE, sep=',');
X <-rawdata[,]
rawdata <- NULL;

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


maxdim <- 50
maxtau <-30

E <- NULL
for (j_tau in 1:maxtau){
  message( 'tau: ', j_tau)
  E<- append (  E,  cao97sub(X,maxdim,j_tau)  )

}


#
# E1 values
#
# png(filename="E1_values.png", height=900, width=1500,bg="white")
e1plot <- xyplot(
  E[[1]] +  E[[3]] +  E[[5]]  +  E[[7]] +  E[[9]] + E[[11]] +  E[[13]] +  E[[15]]  +  E[[17]] +  E[[19]] + #1-10
  E[[21]] +  E[[23]] +  E[[25]]  +  E[[27]] +  E[[29]] + E[[31]] +  E[[33]] +  E[[35]]  +  E[[37]] +  E[[39]] + #11-20
  E[[41]] +  E[[43]] +  E[[45]]  +  E[[47]] +  E[[49]] + E[[51]] +  E[[53]] +  E[[55]]  +  E[[57]] +  E[[59]] #21-30
        ~ 1: (maxdim-1),
        type = "b", lwd=4,
        pch=1:maxtau, # control the plot characters,
        col.line= c(1:maxtau),
        cex=3, # control the characther expansion for characters
        main=list(label="", cex=2.5), #Control the character expansion ratio (cex)
        xlab=list(label="Dimension",  font=2, cex=2),
        ylab=list(label="E1 values",  font=2, cex=2),
        scales=list(font=1, cex=2,
                    y=list(at=seq(0,1,0.2)),x=list(at=seq(0,41,5))
        ),# size of the number labels from the x-y axes
        grid = TRUE,


        key=list(
          text = list(c(
                        expression(paste(tau, "=1")),
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
          cex=0.5, # control the character expansion  of the symbols
          corner=c(0.95,0.05) # position
        ),


        abline=list(h=1.0,lwd=3,lty=3,label = "dsfd"),
        ylim=c(-0.1,1.1)
)
# e1plot
# dev.off() # Turn off device driver (to flush output to PNG)



#
# E2 values
#
# png(filename="E2_values.png", height=900, width=1500,bg="white")
e2plot <- xyplot( E[[2]] +  E[[4]] +  E[[6]]  +  E[[8]] +  E[[10]] +
        E[[12]] +  E[[14]] +  E[[16]]  +  E[[18]] +  E[[20]]
        ~ 1: (maxdim-1),
        type = "b", lwd=4,
        pch=1:10, # control the plot characters,
        col.line= c(1:10),
        cex=3, # control the characther expansion for characters
        main=list(label="", cex=2.5), #Control the character expansion ratio (cex)
        xlab=list(label="Dimension",  font=2, cex=2),
        ylab=list(label="E2 values",  font=2, cex=2),
        scales=list(font=1, cex=2,
                    y=list(at=seq(0,1,0.2)),x=list(at=seq(0,41,5))
        ),# size of the number labels from the x-y axes

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
        ),
        abline=list(h=1.0,lwd=3,lty=3,label = "dsfd"),
        ylim=c(-0.1,1.1)


)
# e2plot
# dev.off() # Turn off device driver (to flush output to PNG)
