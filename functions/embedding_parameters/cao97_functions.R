#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#
#
# FileName:    cao97_functions.R
# Description:
#
#
# NOTE:
#
#
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# Miguel P. Xochicale [http://mxochicale.github.io]
# Doctoral Researcher in Human-Robot Interaction
# University of Birmingham, U.K. (2014-2018)
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++



#to replace NaN values, use
#X <- replace(X, is.nan(X), 0)
cao97sub <- function(x,maxd,tau) {
    dyn.load('~/mxochicale/github/r-code_repository/functions/embedding_parameters/cao97sub.so')
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
## Example
# maxd <- 20
# tau <- 5
# E <-  cao97sub(timeseries,maxd,tau)


maxylimit <- 1.4

plot_E1_values<- function(E)
{

  plot_e1 = xyplot( E[[1]] +  E[[3]] +  E[[5]]  +  E[[7]] +  E[[9]] +
                             E[[11]] +  E[[13]] +  E[[15]]  +  E[[17]] +  E[[19]]
                           ~ 1: (maxd-1),
                           type = "b", lwd=4,
                           pch=1:10, # control the plot characters,
                           col.line= c(1:10),
                           cex=3, # control the characther expansion for characters
                           main=list(label="", cex=2.5), #Control the character expansion ratio (cex)
                           xlab=list(label="Dimension",  font=2, cex=2),
                           ylab=list(label="E1 values",  font=2, cex=2),
                           scales=list(font=2, cex=1.5,
                                       y=list(limits=c(-.1,maxylimit))
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
                           )
  )


  print(plot_e1)

}




plot_E2_values<- function(E)
{
  plot_e2 = xyplot( E[[2]] +  E[[4]] +  E[[6]]  +  E[[8]] +  E[[10]] +
          E[[12]] +  E[[14]] +  E[[16]]  +  E[[18]] +  E[[20]]
        ~ 1: (maxd-1),
        type = "b", lwd=4,
        pch=1:10, # control the plot characters,
        col.line= c(1:10),
        cex=3, # control the characther expansion for characters
        main=list(label="", cex=2.5), #Control the character expansion ratio (cex)
        xlab=list(label="Dimension",  font=2, cex=2),
        ylab=list(label="E2 values",  font=2, cex=2),
        scales=list(font=2, cex=1.5,
                    y=list(limits=c(-.1,maxylimit))
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
        )
)

print(plot_e2)

}
