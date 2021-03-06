library(data.table)
library(deSolve)
library(ggplot2)
library(RColorBrewer)






################################################################################
# Lorenz Function
Lorenz <- function(t, state, parameters){
          with(as.list( c(state,parameters)),
              {
              #rate of change
              dX <- sigma*(Y-X)
              dY <- rho*X - X*Z - Y
              dZ <- X*Y - beta*Z

              # return the rate of change
              list( c(dX, dY, dZ) )
              }
          )# end with(as.list...
}


################################################################################
# Lorenz time-series

#define controlling parameters
# rho     - Scaled Rayleigh number.
# sigma   - Prandtl number.
# beta   - Geometry ascpet ratio.
parameters <- c(rho=28, sigma= 10, beta=8/3)

#define initial state
state <- c(X=1, Y=1, Z=1)
# yini <- c(X = 0.01, Y = 0.001, Z = 0.001)
# state <- c(X=20, Y=41, Z=20)


# define integrations times
# times <- seq(0,100, by=0.001)
times <- seq(0,150, by=0.1)
# timeserie <- seq(0, 150, by = 0.1)

#perform the integration and assign it to variable 'out'
out <- ode(y=state, times= times, func=Lorenz, parms=parameters)
maxLength <- dim(out)[1]


# Lorenz Time series as data.table object
lts <- as.data.table(out)
func <-function(x) {list("Lorenz")}
lts[,c("type"):=func(), ]
lts[,n:=seq(.N)]
setcolorder(lts, c(5,6,1:4))



################################################################################
### (4.1) Windowing Data
###
windowframe = 1000:maxLength;
lts <- lts[,.SD[windowframe],by=.(type)];


################################################################################
### Plot time series
p <- ggplot(lts) +
   geom_line(aes(x=n,y=X,col='x'),lwd = 1,alpha=0.8)+
   geom_line(aes(x=n,y=Y,col='y'),lwd = 1,alpha=0.8)+
   geom_line(aes(x=n,y=Z,col='z'),lwd = 1,alpha=0.8)+
   facet_wrap(~type, scales = 'free', nrow = 4)+
   theme_bw(20)

# dev.new(xpos=0,ypos=0,width=18, height=6)
# p



################################################################################
## CAO's Algorithm
##
source('~/mxochicale/github/R/functions/embedding_parameters/withCao1997/cao97_functions.R')

maxdim <- 31
maxtau <- 15

E <- data.table()
for (tau_i in 1:maxtau){
    Et<- as.data.table(cao97sub(lts$X,maxdim,tau_i) )
    func <-function(x) {list( tau_i )}
    Et[,c("tau"):=func(), ]
    Et[,dim:=seq(.N)]
    setcolorder(Et, c(3,4,1:2))
    E <- rbind(E, Et )
}

names(E) <- gsub("V1", "E1", names(E))
names(E) <- gsub("V2", "E2", names(E))



################################################################################
### Plot E values
e1 <- ggplot(E) +
    geom_line( aes(x=dim,y=E1, colour=factor(tau) ),lwd = 3,alpha=0.5)+
    geom_point( aes(x=dim,y=E1, shape=factor(tau), colour=factor(tau)), size=5, stroke =1 )+
    scale_color_manual(values = colorRampPalette(brewer.pal(n = 8, name="Blues"))(maxtau) ) +
    scale_shape_manual(values= 1:(maxtau))+
    labs(x='Embedding dimension')+
    coord_cartesian(xlim = c(0, (maxdim-1) ), ylim = c(0, 1.5 ) )+
    theme(legend.position = c(0.9, 0.3) )+
    theme( axis.title.x = element_text(size = rel(2.5), angle = 0),
           axis.text.x = element_text(size = rel(2), angle = 0),
           axis.title.y = element_text(size = rel(2.5), angle = 90),
           axis.text.y = element_text(size = rel(2), angle = 90)
           )+
    theme(legend.title = element_text(size = rel(1.5)),
          legend.text = element_text(size = rel(1.5))
          )
#e1

e2 <- ggplot(E) +
    geom_line( aes(x=dim,y=E2, colour=factor(tau) ),lwd = 3,alpha=0.5)+
    geom_point( aes(x=dim,y=E2, shape=factor(tau), colour=factor(tau)), size=5, stroke =1 )+
    scale_color_manual(values = colorRampPalette(brewer.pal(n = 8, name="Blues"))(maxtau) ) +
    scale_shape_manual(values= 1:(maxtau))+
    labs(x='Embedding dimension')+
    coord_cartesian(xlim = c(0, (maxdim-1) ), ylim = c(0, 1.5 ) )+
    theme(legend.position = c(0.9, 0.3) )+
    theme( axis.title.x = element_text(size = rel(2.5), angle = 0),
           axis.text.x = element_text(size = rel(2), angle = 0),
           axis.title.y = element_text(size = rel(2.5), angle = 90),
           axis.text.y = element_text(size = rel(2), angle = 90)
           )+
    theme(legend.title = element_text(size = rel(1.5)),
          legend.text = element_text(size = rel(1.5))
          )

#e2

# dev.new(xpos=0,ypos=0,width=18, height=6)
