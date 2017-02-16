#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#
#
# FileName:           lorenz00.R
# FileDescription:
#
#
# Reference:
#          # wget grrrraphics.blogspot.co.uk/2012/06/coding-dynamic-systems-and-controlling.html
#
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# Miguel P. Xochicale [http://mxochicale.github.io]
# Doctoral Researcher in Human-Robot Interaction
# University of Birmingham, U.K. (2014-2018)
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#
#
#


# library('data.table')


# Multiple plot function
#
# ggplot objects can be passed in ...or to plotlist (as a list of ggplot objects)
# - cols: Numbers of columns in layout
# - layout: A matrix specifying the layout. If present, 'cols' is ignored.
#
# If the layout is something like matrix(c(1,2,3,3), nrow=2, byrow=TRUE),
# then plot 1 will go in the upper left, 2 will go in the upper right, and
# 3 will go all the way across the bottom.
multiplot <- function(..., plotlist=NULL, file, cols=1, layout=NULL){
  library(grid)

  #Make a list from the ... arguments and plotlist
  plots <- c(list(...), plotlist)

  numPlots = length(plots)

  #If layout is NULL, then use 'cols' to determine layout
  if(is.null(layout)){
    # Make the panel
    # ncol: Number of columns of plots
    # nrow: Number of row needed, calculated from # of cols
    layout <- matrix(seq(1,cols*ceiling(numPlots/cols)),
                      ncol=cols, nrow=ceiling(numPlots/cols))
  }

if (numPlots==1){
  print(plots[[1]])
} else{
  # Set up the page
  grid.newpage()
  pushViewport( viewport(layout=grid.layout(nrow(layout),ncol(layout)) ) )

    # Make each plot in the correct location
    for (i in 1:numPlots){
      #Get the i,j, matrix positions of the regions that contain this subplot
      matchidx <- as.data.frame(which(layout==i, arr.ind=TRUE))
      print(plots[[i]], vp=viewport(layout.pos.row=matchidx$row,
                                    layout.pos.col=matchidx$col))
    }
  }
}








###################################

library(ggplot2)
library(deSolve)

Lorenz <- function(t, state, parameters){
          with(as.list( c(state,parameters)),
              {
              #rate of change
              dX <- a*X + Y*Z
              dY <- b*(Y-Z)
              dZ <- -X*Y + c*Y - Z

              # return the rate of change
              list( c(dX, dY, dZ) )
              }
          )# end with(as.list...
}

#define controlling parameters
parameters <- c(a= -8/3, b=-10, c=28)

#define initial state
state <- c(X=1, Y=1, Z=1)

# define integrations times
times <- seq(0,100, by=0.001)

#perform the integration and assign it to variable 'out'
out <- ode(y=state, times= times, func=Lorenz, parms=parameters)



library(ggplot2)
pXY <- ggplot( as.data.frame(out)) + geom_path( aes(X,Y, col=time, alpha=Z))
pZY <- ggplot( as.data.frame(out)) + geom_path( aes(Z,Y, col=time, alpha=X))
pXZ <- ggplot( as.data.frame(out)) + geom_path( aes(X,Z, col=time, alpha=Y))

# + theme(legend.position="none")+ theme(legend.position="none") + theme(legend.position="none")
p3D <- ggplot(as.data.frame(out)) + geom_path( aes(X*Y, X*Z, col=time, alpha=Y*Z)) + scale_alpha(range=c(0.4,0.8))


multiplot(pXY, pZY, pXZ, p3D, cols=2)





#
