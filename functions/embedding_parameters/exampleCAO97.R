library(data.table)
library(deSolve)
library(ggplot2)

# Parameters for the solver
parameters <- c(s = 10, r = 28, b = 8/3)

##
# In initial state
yini <- c(X = 0.01, Y = 0.001, Z = 0.001)

Lorenz <- function(t, state, parameters) {
  with(as.list(c(state, parameters)), {
    dX <- s * (Y - X)
    dY <- X * (r - Z) - Y
    dZ <- X * Y - b * Z
    list(c(dX, dY, dZ))
  })
}

timeserie <- seq(0, 150, by = 0.1)
out <- ode(y = yini, times = timeserie, func = Lorenz, parms = parameters)


# Lorenz Time series as data.table object
lts.dt <- as.data.table(out)
func <-function(x) {list("Lorenz")}
lts.dt[,c("type"):=func(), ]
lts.dt[,n:=seq(.N)]
setcolorder(lts.dt, c(5,6,1:4))



################################
### (4.1) Windowing Data
windowframe = 200:1200;
lts.dt <- lts.dt[,.SD[windowframe],by=.(type)];



# #########################################
# ### Plot time series
# p <- ggplot(lts.dt) +
#    geom_line(aes(x=n,y=X,col=type),lwd = 1,alpha=0.8)+
#    facet_wrap(~type, scales = 'free', nrow = 4)+
#    theme_bw(20)
#
# dev.new(xpos=0,ypos=0,width=18, height=6)
# p



################################################################################
## CAO's Algorithm
##
source('~/mxochicale/github/r-code_repository/functions/embedding_parameters/cao97_functions.R')

maxd <- 21
maxtau <- 10

E <- data.table()
for (tau_i in 1:maxtau){
    Et<- as.data.table(cao97sub(lts.dt$X,maxd,tau_i) )
    func <-function(x) {list( tau_i )}
    Et[,c("tau"):=func(), ]
    Et[,dim:=seq(.N)]
    setcolorder(Et, c(3,4,1:2))
    E <- rbind(E, Et )
}

names(E) <- gsub("V1", "E1", names(E))
names(E) <- gsub("V2", "E2", names(E))



#########################################
### Plot E values
e1 <- ggplot(E, aes(x=dim,y=E1,colour=factor(tau), group=tau ) ) +
   geom_line(lwd = 0.5,alpha=0.9) + geom_point( aes(shape=tau),  size=2 )+
   scale_shape_identity()+
   theme(legend.position = c(0.9, 0.3)
          )+
   theme(axis.title.x = element_text(size = rel(2.5), angle = 0),
         axis.text.x = element_text(size = rel(2), angle = 0),
         axis.title.y = element_text(size = rel(2.5), angle = 90),
         axis.text.y = element_text(size = rel(2), angle = 90)
         )+
   theme(legend.title = element_text(size = rel(1.5)),
         legend.text = element_text(size = rel(1.5))
         )
e1



e2 <- ggplot(E, aes(x=dim,y=E2,colour=factor(tau), group=tau ) ) +
   geom_line(lwd = 0.5,alpha=0.9) + geom_point( aes(shape=tau),  size=2 )+
   scale_shape_identity()+
   theme(legend.position = c(0.9, 0.3)
          )+
   theme(axis.title.x = element_text(size = rel(2.5), angle = 0),
         axis.text.x = element_text(size = rel(2), angle = 0),
         axis.title.y = element_text(size = rel(2.5), angle = 90),
         axis.text.y = element_text(size = rel(2), angle = 90)
         )+
   theme(legend.title = element_text(size = rel(1.5)),
         legend.text = element_text(size = rel(1.5))
         )
e2


# # dev.new(xpos=0,ypos=0,width=18, height=6)
