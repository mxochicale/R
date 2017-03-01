#------------------------------------------------------------
#   Functions for muse senosr
#
#
#
#
# Miguel P. Xochicale [http://mxochicale.github.io]
# Doctoral Researcher in Human-Robot Interaction
# University of Birmingham, U.K. (2014-2018)
#
#
#------------------------------------------------------------


# The data from the muse sensor has the following description

# TimestampRx	TimestampTx	AccX	AccY	AccZ	MagnX	MagnY	MagnZ	GyroX	GyroY	GyroZ	qW	qX	qY	qZ	HDR_AccX	HDR_AccY	HDR_AccZ
# 1           2           3     4     5     6     7     8     9     10    11    12  13  14  15  16        17        18




############
# How to use
# add the following line to your main script
# for the directory where the functions and the R scripts lives, you have to add
# source(  paste(getwd(),"/functions.R",sep="") )







#-------------------- zero mean unit variance function  --------------------------

#Sphering the data (whitening)
ZeromeanUnitvariance_muse <- function ( x )
{
  # convert data as a matrix object
  x <- as.matrix(x)

  #column zero mean
  mx <- mean( x )

  zmx <-  x - matrix(rep( mx,dim(x)[1] ),ncol=dim(x)[2])

  sd_zmx <- sd(zmx)
  zmuv <- zmx/sd_zmx
  return( zmuv )
}



#-------------------- Plotting Accelerometer Values --------------------------
#
# TimestampRx	TimestampTx	AccX	AccY	AccZ
# 1           2           3     4     5
#
plot_acc_muse<- function(data,windowframe)

{
  ymaxminlimit <- 2000
  plot = xyplot(  data[windowframe,3]+data[windowframe,4]+data[windowframe,5] ~ data[windowframe,2],
                            pch=16, col.line = c('red', 'blue', 'yellow3'), type = c("l","g"), lwd=3,
                            main=list(label=paste(" ",sep=""), cex=2.5),
                            xlab=list(label="Samples", cex=3, fontfamily="Times"),
                            ylab=list(label="Raw Data", cex=3, fontfamily="Times"),
                            scales = list(font=1, cex=2,
                                          y=list(
                                            at=seq(-ymaxminlimit,ymaxminlimit,ymaxminlimit/2),limits=c(-ymaxminlimit - (0.1*ymaxminlimit),ymaxminlimit+ (0.1*ymaxminlimit) )
                                          )
                            ),

                            ## LABELS
                            key=list(
                              border= "grey",
                              text = list(c(expression(A[x]), expression(A[y]), expression(A[z]))),
                              lines = list(pch=c(1,2,3), col= c('red','blue','yellow3')), type="l", lwd=6,
                              cex=2.25, # control the character expansion  of the symbols
                              corner=c(1,0) # position
                            ),
                            #function to modify the grid pattern
                            panel=function(...) {
                              panel.xyplot(...)
                              panel.grid(h=-40, v=-1, col.line="blue", lwd=1, lty=3 )
                            }
  )


  print(plot)
}
# Usage
# plot_acc_muse(sn88, 0:dim(sn88)[1])#(data,windowframe)





#-------------------- Plotting Gyroscope Values --------------------------
#
# TimestampRx	TimestampTx	...	GyroX	GyroY	GyroZ
# 1           2               9     10    11
#
plot_gyr_muse<- function(data,windowframe)

{
  ymaxminlimit <- 250
  plot = xyplot(  data[windowframe,9]+data[windowframe,10]+data[windowframe,11] ~ data[windowframe,2],
                            pch=16, col.line = c('red', 'blue', 'yellow3'), type = c("l","g"), lwd=6,
                            main=list(label=paste(" ",sep=""), cex=2.5),
                            xlab=list(label="Samples", cex=3, fontfamily="Times"),
                            ylab=list(label="Raw Data", cex=3, fontfamily="Times"),
                            scales = list(font=1, cex=2,
                                          y=list(
                                            at=seq(-ymaxminlimit,ymaxminlimit,ymaxminlimit/2),limits=c(-ymaxminlimit - (0.1*ymaxminlimit),ymaxminlimit+ (0.1*ymaxminlimit) )
                                          )
                            ),

                            ## LABELS
                            key=list(
                              border= "grey",
                              text = list(c(expression(G[x]), expression(G[y]), expression(G[z]))),
                              lines = list(pch=c(1,2,3), col= c('red','blue','yellow3')), type="l", lwd=6,
                              cex=2.25, # control the character expansion  of the symbols
                              corner=c(1,0) # position
                            ),
                            #function to modify the grid pattern
                            panel=function(...) {
                              panel.xyplot(...)
                              panel.grid(h=-40, v=-1, col.line="blue", lwd=1, lty=3 )
                            }
  )


  print(plot)
}
# Usage
# plot_gyr_muse(sn88, 0:dim(sn88)[1])#(data,windowframe)





#-------------------- Ploting Quaternions Values --------------------------
#
# TimestampRx	TimestampTx ... qW	qX	qY	qZ
# 1           2           ... 12  13  14  15
#
plot_quat_muse<- function(data,windowframe)

{
  ymaxminlimit <- 1
  plot = xyplot(  data[windowframe,12]+data[windowframe,13]+data[windowframe,14]+data[windowframe,15]  ~ data[windowframe,2],
                            pch=16, col.line = c('red', 'blue', 'yellow3', 'green'), type = c("l","g"), lwd=6,
                            main=list(label=paste(" ",sep=""), cex=2.5),
                            xlab=list(label="Samples", cex=3, fontfamily="Times"),
                            ylab=list(label="Raw Data", cex=3, fontfamily="Times"),
                            scales = list(font=1, cex=2,
                                          y=list(
                                            at=seq(-ymaxminlimit,ymaxminlimit,ymaxminlimit/2),limits=c(-ymaxminlimit - (0.1*ymaxminlimit),ymaxminlimit+ (0.1*ymaxminlimit) )
                                          )
                            ),

                            ## LABELS
                            key=list(
                              border= "grey",
                              text = list(c(expression(q[W]), expression(q[X]), expression(q[Y]), expression(q[Z]) )),
                              lines = list(pch=c(1,2,3,4), col= c('red','blue','yellow3','green')), type="l", lwd=6,
                              cex=2.25, # control the character expansion  of the symbols
                              corner=c(1,0) # position
                            ),
                            #function to modify the grid pattern
                            panel=function(...) {
                              panel.xyplot(...)
                              panel.grid(h=-40, v=-1, col.line="blue", lwd=1, lty=3 )
                            }
  )


  print(plot)
}
# Usage
# ????????????????????????




plot_muse_one_axis<- function(matrix_data, axis_number,window)
{
  ymaxminlimit <- 5000
  plot = xyplot(  matrix_data[window,axis_number]   ~ matrix_data[window,1],
                  pch=16, col.line = c( 'red'), type = c("l","g"), lwd=4,
                  main=list(label=paste("","",sep=""), cex=2.5),
                  xlab=list(label="Samples", cex=3, fontfamily="Times"),
                  ylab=list(label="Raw Data", cex=3, fontfamily="Times"),
                  scales = list(font=2, cex=2,
                                y=list(
                                  at=seq(-ymaxminlimit,ymaxminlimit,ymaxminlimit/2),limits=c(-ymaxminlimit - (0.1*ymaxminlimit),ymaxminlimit+ (0.1*ymaxminlimit) )
                                )
                  ),
                  ## labels
                  key=list(
                    border= "grey",
                    text = list(c( expression(VB[ya])  )),
                    lines = list(pch=c(1), col= c('red')), type="l", lwd=4,
                    cex=2, # control the character expansion  of the symbols
                    corner=c(0,0) # position
                  ),
                  ##function to modify the grid pattern
                  panel=function(...) {
                    panel.xyplot(...)
                    panel.grid(h=-50, v=-1, col.line="blue", lwd=1, lty=3 )
                  }
  )# < xyplot

  print(plot)

}
# Usage
# plot_muse_one_axis(sn88, 3, 0:dim(sn88)[1]) #(matrix_data, axis_number,window)








plot_muse_two_axes_and_difference<- function(axis,sensorA,windowA,sensorB,windowB)
{
  ymaxminlimit <- 1000
  plot = xyplot(  sensorA[windowA,axis] + sensorB[windowB,axis]
    # +(sensorA[windowA,axis] - sensorB[windowB,axis])
                  ~ 0:length(windowA),
                  pch=16, col.line = c( 'blue', 'red', 'black'), type = c("l","g"), lwd=3,
                  main=list(label=paste("","",sep=""), cex=2.5),
                  xlab=list(label="Samples", cex=3, fontfamily="Times"),
                  ylab=list(label="Raw Data", cex=3, fontfamily="Times"),

                  scales = list(font=2, cex=2,
                                y=list(
                                  at=seq(-ymaxminlimit,ymaxminlimit,ymaxminlimit/2),limits=c(-ymaxminlimit - (0.1*ymaxminlimit),ymaxminlimit+ (0.1*ymaxminlimit) )
                                )
                  ),

                  ## labels
                  key=list(
                    border= "grey",
                    text = list(c( expression(S[a](n)  ) , expression(S[b](n)  ), expression(S[b](n) - S[b](n) ) )),
                    lines = list(pch=c(1,2), col= c('blue','red','black')), type="l", lwd=4,
                    cex=2, # control the character expansion  of the symbols
                    corner=c(0,0) # position
                  ),
                  ##function to modify the grid pattern
                  panel=function(...) {
                    panel.xyplot(...)
                    panel.grid(h=-50, v=-1, col.line="blue", lwd=1, lty=3 )
                  }
  )# < xyplot

  print(plot)

}
# example
# plot_muse_two_axes_and_difference(4,sn16,175:575,sn88,0:400)



plot_muse_four_axes_and_difference<- function(axis,sensorA,windowA,sensorB,windowB)
{
  ymaxminlimit <- 10000
  plot = xyplot(  sensorA[windowA,axis] + sensorB[windowB,axis]
    # +(sensorA[windowA,axis] - sensorB[windowB,axis])
                  ~ 0:length(windowA),
                  pch=16, col.line = c( 'blue', 'red', 'black'), type = c("l","g"), lwd=3,
                  main=list(label=paste("","",sep=""), cex=2.5),
                  xlab=list(label="Samples", cex=3, fontfamily="Times"),
                  ylab=list(label="Raw Data", cex=3, fontfamily="Times"),

                  scales = list(font=2, cex=2,
                                y=list(
                                  at=seq(-ymaxminlimit,ymaxminlimit,ymaxminlimit/2),limits=c(-ymaxminlimit - (0.1*ymaxminlimit),ymaxminlimit+ (0.1*ymaxminlimit) )
                                )
                  ),

                  ## labels
                  key=list(
                    border= "grey",
                    text = list(c( expression(S[a](n)  ) , expression(S[b](n)  ), expression(S[b](n) - S[b](n) ) )),
                    lines = list(pch=c(1,2), col= c('blue','red','black')), type="l", lwd=4,
                    cex=2, # control the character expansion  of the symbols
                    corner=c(0,0) # position
                  ),
                  ##function to modify the grid pattern
                  panel=function(...) {
                    panel.xyplot(...)
                    panel.grid(h=-50, v=-1, col.line="blue", lwd=1, lty=3 )
                  }
  )# < xyplot

  print(plot)

}
# Example of Usage
# plot_muse_two_axes_and_difference(4,sn16,175:575,sn88,0:400)
