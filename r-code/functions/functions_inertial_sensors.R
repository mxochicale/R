#------------------------------------------------------------
#   Functions
#   for Razor and Shimmer IMUS
#
#
#
# Miguel P. Xochicale [http://mxochicale.github.io]
# Doctoral Researcher in Human-Robot Interaction
# University of Birmingham, U.K. (2014-2018)
#
#
#------------------------------------------------------------




############
# How to use
# add the following line to your main script
# for the directory where the functions and the R scripts lives, you have to add
# source(  paste(getwd(),"/functions.R",sep="") )


####################
# Last Modication:
#


#######
# TODO
# Create a main directory for the function file and mix all the functions for
# the Human Variability Project
#
#
#





#-------------------- rotate the angles and centre them  --------------------------
#
rotated_angle <- function(eulerangle,threshold)
{
  new_ea_a <- 0;
  new_ea_b <- 0;
  new_ea <- 0;

  #calculate yaw offset
  avg_ea <- median(eulerangle)
  #define threshold based on movement range
  #thres = 200
  #find entries smaller than threshold
  aa <- which(eulerangle < (avg_ea - threshold))
  bb <- which(eulerangle > (avg_ea - threshold))

  #add 360 to move angles up
  new_ea_a[aa] <- eulerangle[aa] + 360
  new_ea_b[bb] <- eulerangle[bb] + 360

  #get offset for this signal
  avg_new_ea_a <- median(new_ea_a,na.rm = TRUE)
  avg_new_ea_b <- median(new_ea_b,na.rm = TRUE)
  #substract offset; boom   fluctuates around zero :-)
  final_ea_a = new_ea_a - avg_new_ea_a
  final_ea_b = new_ea_b - avg_new_ea_b

  new_ea[aa] <- final_ea_a[aa]
  new_ea[bb] <- final_ea_b[bb]

  return(new_ea)
}





#--------------------  getdata function  --------------------------
#
# gets data from a file and it's converted into a Matrix
# input:  filename
# output: Matrix Data (MD)
#         MD[,1] Sample
#         MD[,2] Time
#         MD[,3] Yaw
#         MD[,4] Pitch
#         MD[,5] Roll
#         MD[,6] rotated yaw
#         MD[,7] rotated pitch
#         MD[,8] rotated roll
#
getdata<- function(filename_imuN)
{
  threshold <- 1000

  rawdata<-read.csv(paste(filename_imuN,"",sep=""), sep=',');
  MD <- as.matrix(rawdata)# Matrix Data
  MD <- cbind (MD, rotated_angle(MD[,3],threshold)  )  #rotated yaw
  MD <- cbind (MD, rotated_angle(MD[,4],threshold)  )  #rotated pitch
  MD <- cbind (MD, rotated_angle(MD[,5],threshold)  )  #rotated roll

  return(MD)

}


#---------------   get_ACCMAGGYRdata  ------------------
#
#
#          get a matrix for the ACC MAG and GYR sensors
#
# gets data from a file and it's converted into a Matrix
# input:  filename
# output: Matrix Data (MD)
#
#         MD[,1] Sample
#         MD[,2] Time
#
#         MD[,3] ACCX
#         MD[,4] ACCY
#         MD[,5] ACCZ
#
#         MD[,6] MAGX
#         MD[,7] MAGY
#         MD[,8] MAGZ
#
#         MD[,9]  GYRX
#         MD[,10] GYRY
#         MD[,11] GYRZ
#
#         MD[,12] MAG_ACC
#         MD[,13] MAG_MAG
#         MD[,14] MAG_GYR
#
#         MD[,15] zeromean_unitvariance_AX
#         MD[,16] zeromean_unitvariance_AY
#         MD[,17] zeromean_unitvariance_AZ
#
#         MD[,18] zeromean_unitvariance_MX
#         MD[,19] zeromean_unitvariance_MY
#         MD[,20] zeromean_unitvariance_MZ
#
#         MD[,21] zeromean_unitvariance_GX
#         MD[,22] zeromean_unitvariance_GY
#         MD[,23] zeromean_unitvariance_GZ
#
get_ACCMAGGYRdata<- function(filename_imuN)
{

  rawdata<-read.csv(paste(filename_imuN,"",sep=""), sep=',');
  MD <- as.matrix(rawdata)# Matrix Data

  MD <- cbind (MD, sqrt(MD[,3]^2 + MD[,4]^2 + MD[,5]^2) ); # magnitude of ACC    12
  MD <- cbind (MD, sqrt(MD[,6]^2 + MD[,7]^2 + MD[,8]^2) ); # magnitude of MAG    13
  MD <- cbind (MD, sqrt(MD[,9]^2 + MD[,10]^2 + MD[,11]^2) ); # magnitude of GYR  14

  #-------------------------------------------------------------------------------------
  #-------------------- zero mean unit variance VECTOR function  --------------------------
  #
  #Sphering the data (whitening)
  MD <- cbind (MD, zeromean_unitvariance(MD[,3]) ); #AX 15
  MD <- cbind (MD, zeromean_unitvariance(MD[,4]) ); #AY 16
  MD <- cbind (MD, zeromean_unitvariance(MD[,5]) ); #AZ 17

  MD <- cbind (MD, zeromean_unitvariance(MD[,6]) ); #MX 18
  MD <- cbind (MD, zeromean_unitvariance(MD[,7]) ); #MY 19
  MD <- cbind (MD, zeromean_unitvariance(MD[,8]) ); #MZ 20

  MD <- cbind (MD, zeromean_unitvariance(MD[,9]) ); #GX 21
  MD <- cbind (MD, zeromean_unitvariance(MD[,10]) ); #GY 22
  MD <- cbind (MD, zeromean_unitvariance(MD[,11]) ); #GZ 23

  return(MD)

}






#---------------   get_ShimmerSensorData  ------------------
#
#
#          get a matrix for the shimmer sensor
#
# gets data from a file and it's converted into a Matrix
# input:  filename
# output: Matrix Data (MD)
#
#         MD[,1] RAW Timestamp
#         MD[,2] CAL Timestamp
#
#         MD[,3] RAW Wide Range Accelerometer X (no units)
#         MD[,4] CAL Wide Range Accelerometer X (m/(sec^2))
#         MD[,5] RAW Wide Range Accelerometer Y (no units)
#         MD[,6] CAL Wide Range Accelerometer Y (m/(sec^2))
#         MD[,7] RAW Wide Range Accelerometer Z (no units)
#         MD[,8] CAL Wide Range Accelerometer Z (m/(sec^2))

#         MD[,9]  RAW Gyroscope X (no units)
#         MD[,10] CAL Gyroscope X (deg/sec)
#         MD[,11] RAW Gyroscope Y (no units)
#         MD[,12] CAL Gyroscope Y (deg/sec)
#         MD[,13] RAW Gyroscope Z (no units)
#         MD[,14] CAL Gyroscope Z (deg/sec)

#         MD[,15] RAW Magnetometer X (no units)
#         MD[,16] CAL Magnetometer X (local)
#         MD[,17] RAW Magnetometer Y (no units)
#         MD[,18] CAL Magnetometer Y (local)
#         MD[,19] RAW Magnetometer Z (no units)
#         MD[,20] CAL Magnetometer Z (local)
#
#
####     zeromean_unitvariance

#         MD[,21] RAW zeromean_unitvariance Wide Range Accelerometer X (no units)
#         MD[,22] RAW zeromean_unitvariance Wide Range Accelerometer Y (no units)
#         MD[,23] RAW zeromean_unitvariance Wide Range Accelerometer Z (no units)
#         MD[,24] CAL zeromean_unitvariance Wide Range Accelerometer X (m/(sec^2))
#         MD[,25] CAL zeromean_unitvariance Wide Range Accelerometer Y (m/(sec^2))
#         MD[,26] CAL zeromean_unitvariance Wide Range Accelerometer Z (m/(sec^2))

#         MD[,27] RAW zeromean_unitvariance Gyroscope X (no units)
#         MD[,28] RAW zeromean_unitvariance Gyroscope Y (no units)
#         MD[,29] RAW zeromean_unitvariance Gyroscope Z (no units)
#         MD[,30] CAL zeromean_unitvariance Gyroscope X (deg/sec)
#         MD[,31] CAL zeromean_unitvariance Gyroscope Y (deg/sec)
#         MD[,32] CAL zeromean_unitvariance Gyroscope Z (deg/sec)

#         MD[,33] RAW zeromean_unitvariance Magnetometer X (no units)
#         MD[,34] RAW zeromean_unitvariance Magnetometer Y (no units)
#         MD[,35] RAW zeromean_unitvariance Magnetometer Z (no units)
#         MD[,36] CAL zeromean_unitvariance Magnetometer X (local)
#         MD[,37] CAL zeromean_unitvariance Magnetometer Y (local)
#         MD[,38] CAL zeromean_unitvariance Magnetometer Z (local)
get_ShimmerSensorData<- function(filename_imuN)
{

  rawdata<-read.csv(paste(filename_imuN,"",sep=""), sep=',');
  MD <- as.matrix( rawdata )# Matrix Data

  MD <- MD[-c(1,2,3),] #delete rows 1, 2 and 3 which has charactters
  MD <- MD[,-21]  #delete column 21 which has NA values


  #-------------------------------------------------------------------------------------
  #-------------------- zero mean unit variance VECTOR function  --------------------------
  #
  #Sphering the data (whitening)

  ###############################
  # Wide Range Accelerometer

  #RAW
  MD <- cbind (MD, zeromean_unitvariance( MD[,3]) ) #21
  MD <- cbind (MD, zeromean_unitvariance( MD[,5]) ) #22
  MD <- cbind (MD, zeromean_unitvariance( MD[,7]) ) #23

  #CAL
  MD <- cbind (MD, zeromean_unitvariance( MD[,4]) ) #24
  MD <- cbind (MD, zeromean_unitvariance( MD[,6]) ) #25
  MD <- cbind (MD, zeromean_unitvariance( MD[,8]) ) #26

  # X --- RAW:-0.0315744459668832  CAL: 0.0315744459668831
  # Y --- RAW:-0.0911783090969046  CAL:-0.0911783090969047
  # Z --- RAW:-0.402521144493646   CAL: 0.402521144493655

  ###############################
  # Gyroscope

  #RAW
  MD <- cbind (MD, zeromean_unitvariance( MD[,9]) )  #27
  MD <- cbind (MD, zeromean_unitvariance( MD[,11]) ) #28
  MD <- cbind (MD, zeromean_unitvariance( MD[,13]) ) #29

  #CAL
  MD <- cbind (MD, zeromean_unitvariance( MD[,10]) ) #30
  MD <- cbind (MD, zeromean_unitvariance( MD[,12]) ) #31
  MD <- cbind (MD, zeromean_unitvariance( MD[,14]) ) #32

  # X --- RAW:-0.0197699643811863  CAL: -0.0029109275587028
  # Y --- RAW:-0.00291092755870275 CAL: 0.0197699643811864
  # Z --- RAW:0.0754418791789367   CAL: -0.0754418791789366


  ###############################
  # Magnetometer

  #RAW
  MD <- cbind (MD, zeromean_unitvariance( MD[,15]) ) #33
  MD <- cbind (MD, zeromean_unitvariance( MD[,17]) ) #34
  MD <- cbind (MD, zeromean_unitvariance( MD[,19]) ) #35

  #CAL
  MD <- cbind (MD, zeromean_unitvariance( MD[,16]) ) #36
  MD <- cbind (MD, zeromean_unitvariance( MD[,18]) ) #37
  MD <- cbind (MD, zeromean_unitvariance( MD[,20]) ) #38

  # X --- RAW:-0.586056685289712    CAL: 0.586056685289709
  # Y --- RAW:-0.222022433292667     CAL:-0.222022433292666
  # Z --- RAW: 0.239425741753563    CAL:-0.239425741753561


  #MD <- as.numeric(MD) # just one row
  class(MD) <- "numeric" # https://stat.ethz.ch/pipermail/r-help/2010-January/224725.html


  return(MD)

}




#-------------------------------------------------------------------------------------
#-------------------- zero mean unit variance function  --------------------------

#Sphering the data (whitening)
zeromean_unitvariance <- function ( x )
{
  # convert data as a matrix object
  x <- as.matrix( as.numeric(x) )
  # as.numeric() is used to conver data from char to numeric to prevent error with NA values due to char values


  #column zero mean
  mx <- mean( x )
  meanmatrix <- matrix( rep(mx,dim(x)[1]),ncol=dim(x)[2] )

  zmx <-  x - meanmatrix


  sd_zmx <- sd(zmx)
  zmuv <- zmx/sd_zmx
  return( zmuv )
}




#Root Mean Square Error
#http://stackoverflow.com/questions/26237688/rmse-root-mean-square-deviation-calculation-in-r

rmse <- function(m, o){

  # m is for model (fitted) values
  # o is for observed (true) values.

  e <- sqrt(mean((m - o)^2))
  return (e)
}



rotated_angle <- function(eulerangle,threshold)
{
  new_ea_a <- 0;
  new_ea_b <- 0;
  new_ea <- 0;

  #calculate yaw offset
  avg_ea <- median(eulerangle)
  #define threshold based on movement range
  #thres = 200
  #find entries smaller than threshold
  aa <- which(eulerangle < (avg_ea - threshold))
  bb <- which(eulerangle > (avg_ea - threshold))

  #add 360 to move angles up
  new_ea_a[aa] <- eulerangle[aa] + 360
  new_ea_b[bb] <- eulerangle[bb] + 360

  #get offset for this signal
  avg_new_ea_a <- median(new_ea_a,na.rm = TRUE)
  avg_new_ea_b <- median(new_ea_b,na.rm = TRUE)
  #substract offset; boom   fluctuates around zero :-)
  final_ea_a = new_ea_a - avg_new_ea_a
  final_ea_b = new_ea_b - avg_new_ea_b

  new_ea[aa] <- final_ea_a[aa]
  new_ea[bb] <- final_ea_b[bb]

  return(new_ea)
}





################################
################################
################################
######## PLOTS TIME SERIES FROM SENSOR
################################
################################
################################

#-------------------- plot_timeserie ACC  --------------------------

plot_acc<- function(matrix_data,window)
{

 plot = xyplot( matrix_data[window,3] +  matrix_data[window,4] + matrix_data[window,5]  ~ matrix_data[window,1],
      pch=16, col.line = c('red', 'blue', 'yellow3'), type = c("l","g"), lwd=4,
      main=list(label=paste("","",sep=""), cex=2.5),
      xlab=list(label="Samples", cex=3, fontfamily="Times"),
      ylab=list(label="Raw Data", cex=3, fontfamily="Times"),
      ## labels
      key=list(
          border= "grey",
          text = list(c(expression(A[x]), expression(A[y]), expression(A[z]))),
          lines = list(pch=c(1,2,3), col= c('red','blue','yellow3')), type="l", lwd=4,
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
#Example
#plot_acc(participant0_imu0,window)




plot_mag<- function(matrix_data,window)
{
  plot = xyplot( matrix_data[window,6] +  matrix_data[window,7] + matrix_data[window,8]  ~ matrix_data[window,1],
                 pch=16, col.line = c('red', 'blue', 'yellow3'), type = c("l","g"), lwd=4,
                 main=list(label=paste("","",sep=""), cex=2.5),
                 xlab=list(label="Samples", cex=3, fontfamily="Times"),
                 ylab=list(label="Raw Data", cex=3, fontfamily="Times"),
                 ## labels
                 key=list(
                   border= "grey",
                   text = list(c(expression(M[x]), expression(M[y]), expression(M[z]))),
                   lines = list(pch=c(1,2,3), col= c('red','blue','yellow3')), type="l", lwd=4,
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

plot_gyr<- function(matrix_data,window)
{
  plot = xyplot( matrix_data[window,9] +  matrix_data[window,10] + matrix_data[window,11]  ~ matrix_data[window,1],

                 pch=16, col.line = c('red', 'blue', 'yellow3'), type = c("l","g"), lwd=4,
                 main=list(label=paste("","",sep=""), cex=2.5),
                 xlab=list(label="Samples", cex=3, fontfamily="Times"),
                 ylab=list(label="Raw Data", cex=3, fontfamily="Times"),
                 ## labels
                 key=list(
                   border= "grey",
                   text = list(c(expression(G[x]), expression(G[y]), expression(G[z]))),
                   lines = list(pch=c(1,2,3), col= c('red','blue','yellow3')), type="l", lwd=4,
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





plot_acc_zmuv<- function(matrix_data,window)
{
  plot = xyplot( matrix_data[window,15] +  matrix_data[window,16] + matrix_data[window,17]  ~ matrix_data[window,1],
                 pch=16, col.line = c('red', 'blue', 'yellow3'), type = c("l","g"), lwd=4,
                 main=list(label=paste("","",sep=""), cex=2.5),
                 xlab=list(label="Samples", cex=3, fontfamily="Times"),
                 ylab=list(label="Raw Data", cex=3, fontfamily="Times"),
                # scales=list(
                #   y=list(limits=c(-5,5)),
                #   font=1, cex=1),# size of the number labels from the x-y axes

                 ## labels
                 key=list(
                   border= "grey",
                   text = list(c(expression(A[x]), expression(A[y]), expression(A[z]))),
                   lines = list(pch=c(1,2,3), col= c('red','blue','yellow3')), type="l", lwd=4,
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
#Example
#plot_acc_zmuv(participant0_imu0,window)


plot_mag_zmuv<- function(matrix_data,window)
{
  plot = xyplot( matrix_data[window,18] +  matrix_data[window,19] + matrix_data[window,20]  ~ matrix_data[window,1],
                 pch=16, col.line = c('red', 'blue', 'yellow3'), type = c("l","g"), lwd=4,
                 main=list(label=paste("","",sep=""), cex=2.5),
                 xlab=list(label="Samples", cex=3, fontfamily="Times"),
                 ylab=list(label="Raw Data", cex=3, fontfamily="Times"),
                 ## labels
                 key=list(
                   border= "grey",
                   text = list(c(expression(M[x]), expression(M[y]), expression(M[z]))),
                   lines = list(pch=c(1,2,3), col= c('red','blue','yellow3')), type="l", lwd=4,
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

plot_gyr_zmuv<- function(matrix_data,window)
{
  plot = xyplot( matrix_data[window,21] +  matrix_data[window,22] + matrix_data[window,23]  ~ matrix_data[window,1],
                 pch=16, col.line = c('red', 'blue', 'yellow3'), type = c("l","g"), lwd=4,
                 main=list(label=paste("","",sep=""), cex=2.5),
                 xlab=list(label="Samples", cex=3, fontfamily="Times"),
                 ylab=list(label="Raw Data", cex=3, fontfamily="Times"),
                 ## labels
                 key=list(
                   border= "grey",
                   text = list(c(expression(G[x]), expression(G[y]), expression(G[z]))),
                   lines = list(pch=c(1,2,3), col= c('red','blue','yellow3')), type="l", lwd=4,
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










plot_gyr_y_zmuv<- function(matrix_data,window)
{
  plot = xyplot(  matrix_data[window,22]   ~ matrix_data[window,1],
                 pch=16, col.line = c( 'blue'), type = c("l","g"), lwd=4,
                 main=list(label=paste("","",sep=""), cex=2.5),
                 xlab=list(label="Samples", cex=3, fontfamily="Times"),
                 ylab=list(label="Raw Data", cex=3, fontfamily="Times"),
                 ## labels
                 key=list(
                   border= "grey",
                   text = list(c( expression(G[y])  )),
                   lines = list(pch=c(1), col= c('blue')), type="l", lwd=4,
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
##example
##plot_gyr_y_zmuv(datamatrix,window)








plot_one_axis<- function(matrix_data, axis_number,window)
{
  plot = xyplot(  matrix_data[window,axis_number]   ~ matrix_data[window,1],
                  pch=16, col.line = c( 'blue'), type = c("l","g"), lwd=4,
                  main=list(label=paste("","",sep=""), cex=2.5),
                  xlab=list(label="Samples", cex=3, fontfamily="Times"),
                  ylab=list(label="Raw Data", cex=3, fontfamily="Times"),


                   scales=list(
                     y=list(limits=c(-5,5)),
                     font=3, cex=2),# size of the number labels from the x-y axes

                  ## labels
                  key=list(
                    border= "grey",
                    text = list(c( expression(VB[ya])  )),
                    lines = list(pch=c(1), col= c('blue')), type="l", lwd=4,
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
# plot_one_axis(datamatrix,22,window)



plot_two_axes_and_difference<- function(matrix_data_A, axis_number_A, matrix_data_B, axis_number_B,window)
{
  plot = xyplot(  matrix_data_A[window,axis_number_A] + matrix_data_B[window,axis_number_B] +
                    (matrix_data_A[window,axis_number_A] - matrix_data_B[window,axis_number_B])
                  ~ matrix_data_A[window,1],
                  pch=16, col.line = c( 'blue', 'red', 'black'), type = c("l","g"), lwd=3,
                  main=list(label=paste("","",sep=""), cex=2.5),
                  xlab=list(label="Samples", cex=3, fontfamily="Times"),
                  ylab=list(label="Raw Data", cex=3, fontfamily="Times"),


                  scales=list(
                    y=list(limits=c(-5,5)),
                    font=3, cex=2),# size of the number labels from the x-y axes

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
#plot_two_axes_and_difference(imu0,1,imu1,1,window)






################################
################################
################################
######## PLOTS RAZOR
################################
################################
################################





###PLOT ACCELEROMETER DATA

plot_acc_razor<- function(data,windowframe)
{
  ymaxminlimit <- 500;
  plot_acc_razor = xyplot(  data[windowframe,3]+data[windowframe,4]+data[windowframe,5] ~ data[windowframe,1],
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


  print(plot_acc_razor)
}

###PLOT MAGNETOMETER DATA
plot_mag_razor<- function(data,windowframe)
{
  plot_mag_razor = xyplot(  data[windowframe,6]+data[windowframe,7]+data[windowframe,8] ~ data[windowframe,1],
                            pch=16, col.line = c('red', 'blue', 'yellow3'), type = c("l","g"), lwd=4,
                            main=list(label=paste( " ",sep=""), cex=2.5),
                            xlab=list(label="Samples", cex=3, fontfamily="Times"),
                            ylab=list(label="Raw Data", cex=3, fontfamily="Times"),
                            scales = list(font=1, cex=2,
                                          y=list(
                                            at=seq(-800,800,100),limits=c(-800,800)
                                          )
                            ),

                            ## LABELS
                            key=list(
                              border= "grey",
                              text = list(c(expression(M[x]), expression(M[y]), expression(M[z]))),
                              lines = list(pch=c(1,2,3), col= c('red','blue','yellow3')), type="l", lwd=4,
                              cex=2.25, # control the character expansion  of the symbols
                              corner=c(1,0) # position
                            ),
                            #function to modify the grid pattern
                            panel=function(...) {
                              panel.xyplot(...)
                              panel.grid(h=-50, v=-1, col.line="blue", lwd=1, lty=3 )
                            }
  )

  print(plot_mag_razor)
}

###PLOT GYROSCOPE DATA

plot_gyr_razor<- function(data,windowframe)
{

  ymaxminlimit <- 5000;

  plot_gyr_razor = xyplot(  data[windowframe,9]+data[windowframe,10]+data[windowframe,11] ~ data[windowframe,1],
                            pch=16, col.line = c('red', 'blue', 'yellow3'), type = c("l","g"), lwd=6,
                            main=list(label=paste( " ",sep=""), cex=2.5),
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
                              panel.grid(h=-50, v=-1, col.line="blue", lwd=1, lty=3 )
                            }
  )

  print(plot_gyr_razor)
}



###PLOT MAGNITUDE
#         MD[,12] MAG_ACC
#         MD[,13] MAG_MAG
#         MD[,14] MAG_GYR
plot_magnitudeACCMAGGYR_razor<- function(data,windowframe)
{

  ymaxminlimit <- 6500;
  plot_magnitude_razor = xyplot(  data[windowframe,12]+data[windowframe,13]+data[windowframe,14] ~ data[windowframe,1],
                            pch=16, col.line = c('red', 'blue', 'yellow3'), type = c("l","g"), lwd=6,
                            main=list(label=paste( " ",sep=""), cex=2.5),
                            xlab=list(label="Samples", cex=3, fontfamily="Times"),
                            ylab=list(label="Raw Data", cex=3, fontfamily="Times"),
                            scales = list(font=1, cex=2,
                              y=list(
                                at=seq(-ymaxminlimit,ymaxminlimit,ymaxminlimit/2),limits=c(-0 - (0.1*ymaxminlimit),ymaxminlimit+ (0.1*ymaxminlimit) )
                                    )
                            ),

                            ## LABELS
                            key=list(
                              border= "grey",
                              text = list(c(expression( abs(ACC) ), expression( abs(MAG) ), expression( abs(GYR)  ))),
                              lines = list(pch=c(1,2,3), col= c('red','blue','yellow3')), type="l", lwd=5,
                              cex=2.25, # control the character expansion  of the symbols
                              corner=c(0,1) # position
                            ),
                            #function to modify the grid pattern
                            panel=function(...) {
                              panel.xyplot(...)
                              panel.grid(h=-50, v=-1, col.line="blue", lwd=1, lty=3 )
                            }
  )

  print(plot_magnitude_razor)
}



#
#         MD[,15] zeromean_AX
#         MD[,16] zeromean_AY
#         MD[,17] zeromean_AZ
#

plot_acc_n_razor<- function(data,windowframe)
{

  ymaxminlimit <- 3

  plot = xyplot(  data[windowframe,15]+data[windowframe,16]+data[windowframe,17] ~ data[windowframe,1],
                            #  plot_ypr = xyplot(  data[,6]+data[,7]+data[,8] ~ data[,1],
                            pch=16, col.line = c('red', 'blue', 'yellow3'), type = c("l","g"), lwd=6,
                            main=list(label=paste( " ",sep=""), cex=2.5),
                            xlab=list(label="Samples", cex=3, fontfamily="Times"),
                            ylab=list(label="z.m.u.v.", cex=3, fontfamily="Times"),
                            scales = list(font=1, cex=2,
                                          y=list(
                                            at=seq(-ymaxminlimit,ymaxminlimit,ymaxminlimit/2),limits=c(-ymaxminlimit - (0.1*ymaxminlimit),ymaxminlimit+ (0.1*ymaxminlimit) )
                                          )
                            ),

                            ## LABELS
                            key=list(
                              border= "grey",
                              text = list(c(expression(~A[x]), expression(~A[y]), expression(~A[z]))),
                              lines = list(pch=c(1,2,3), col= c('red','blue','yellow3')), type="l", lwd=5,
                              cex=2.25, # control the character expansion  of the symbols
                              corner=c(1,0) # position
                            ),
                            #function to modify the grid pattern
                            panel=function(...) {
                              panel.xyplot(...)
                              panel.grid(h=-50, v=-1, col.line="blue", lwd=1, lty=3 )
                            }
  )

  print(plot)
}







###PLOT MAGNETOMETER normalised DATA
#         MD[,18] zeromean_MX
#         MD[,19] zeromean_MY
#         MD[,20] zeromean_MZ
#
plot_mag_n_razor<- function(data,windowframe)
{

  ymaxminlimit <- 3

  plot = xyplot(  data[windowframe,18]+data[windowframe,19]+data[windowframe,20] ~ data[windowframe,1],
                            #  plot_ypr = xyplot(  data[,6]+data[,7]+data[,8] ~ data[,1],
                            pch=16, col.line = c('red', 'blue', 'yellow3'), type = c("l","g"), lwd=6,
                            main=list(label=paste( " ",sep=""), cex=2.5),
                            xlab=list(label="Samples", cex=3, fontfamily="Times"),
                            ylab=list(label="z.m.u.v.", cex=3, fontfamily="Times"),
                            scales = list(font=1, cex=2,
                                          y=list(
                                            at=seq(-ymaxminlimit,ymaxminlimit,ymaxminlimit/2),limits=c(-ymaxminlimit - (0.1*ymaxminlimit),ymaxminlimit+ (0.1*ymaxminlimit) )
                                          )
                            ),

                            ## LABELS
                            key=list(
                              border= "grey",
                              text = list(c(expression(M[x]), expression(M[y]), expression(M[z]))),
                              lines = list(pch=c(1,2,3), col= c('red','blue','yellow3')), type="l", lwd=5,
                              cex=2.25, # control the character expansion  of the symbols
                              corner=c(1,0) # position
                            ),
                            #function to modify the grid pattern
                            panel=function(...) {
                              panel.xyplot(...)
                              panel.grid(h=-50, v=-1, col.line="blue", lwd=1, lty=3 )
                            }
  )

  print(plot)
}






#         MD[,21] zeromean_GX
#         MD[,22] zeromean_GY
#         MD[,23] zeromean_GZ
#
plot_gyr_n_razor<- function(data,windowframe)
{

  ymaxminlimit <- 3

  plot = xyplot(  data[windowframe,21]+data[windowframe,22]+data[windowframe,23] ~ data[windowframe,1],
                            #  plot_ypr = xyplot(  data[,6]+data[,7]+data[,8] ~ data[,1],
                            pch=16, col.line = c('red', 'blue', 'yellow3'), type = c("l","g"), lwd=6,
                            main=list(label=paste( " ",sep=""), cex=2.5),
                            xlab=list(label="Samples", cex=3, fontfamily="Times"),
                            ylab=list(label="z.m.u.v.", cex=3, fontfamily="Times"),
                            scales = list(font=1, cex=2,
                                          y=list(
                                            at=seq(-ymaxminlimit,ymaxminlimit,ymaxminlimit/2),limits=c(-ymaxminlimit - (0.1*ymaxminlimit),ymaxminlimit+ (0.1*ymaxminlimit) )
                                          )
                            ),

                            ## LABELS
                            key=list(
                              border= "grey",
                              text = list(c(expression(G[x]), expression(G[y]), expression(G[z]))),
                              lines = list(pch=c(1,2,3), col= c('red','blue','yellow3')), type="l", lwd=5,
                              cex=2.25, # control the character expansion  of the symbols
                              corner=c(1,0) # position
                            ),
                            #function to modify the grid pattern
                            panel=function(...) {
                              panel.xyplot(...)
                              panel.grid(h=-50, v=-1, col.line="blue", lwd=1, lty=3 )
                            }
  )

  print(plot)
}




plot_razor_one_axis<- function(data,data_axis_number,windowframe)
{
  plot = xyplot(  data[windowframe,data_axis_number]~ windowframe,
                            pch=16, col.line = c('black', 'blue', 'yellow3'), type = c("l","g"), lwd=6,
                            main=list(label=paste(" ",sep=""), cex=2.5),
                            xlab=list(label="Samples", cex=3, fontfamily="Times"),
                            ylab=list(label="Raw Data", cex=3, fontfamily="Times"),
                            scales = list(font=1, cex=2
                                          #,y=list(at=seq(-1000,1000,100),limits=c(-1050,1050))
                            ),


                            #function to modify the grid pattern
                            panel=function(...) {
                              panel.xyplot(...)
                              panel.grid(h=-50, v=-1, col.line="blue", lwd=1, lty=3 )
                            }
  )


  print(plot)
}



##############################
###PLOT data from 2 razor sensors
plot_2razor_imus<- function(data_razor_imu0,data_razor_imu1,axis_number, window)
{


plot <- xyplot(  data_razor_imu0[window,axis_number] + data_razor_imu1[window,axis_number] ~ window,
        pch=16, col.line = c('red', 'blue', 'black'),
        type = c("l","g"), lwd=5,
        main=list(label=paste(" ",sep=""), cex=2.5),
        xlab=list(label="Samples", cex=3, fontfamily="Times"),
        ylab=list(label="Raw Data", cex=3, fontfamily="Times"),
        scales = list(font=1, cex=2,
                      y=list(
                      at=seq(100,350,100),limits=c(150,400)
                      )
        ),


        #function to modify the grid pattern
        panel=function(...) {
          panel.xyplot(...)
          panel.grid(h=-50, v=-1, col.line="blue", lwd=1, lty=3 )
        }
        )

print(plot)

}





################################
################################
################################
######## PLOTS SHIMMER
################################
################################
################################


#
#         MD[,3] RAW Wide Range Accelerometer X (no units)
#         MD[,5] RAW Wide Range Accelerometer Y (no units)
#         MD[,7] RAW Wide Range Accelerometer Z (no units)
plot_acc_raw_shimmer<- function(data,windowframe)
{

    ymaxminlimit <- 40000

  ###PLOT ACCELEROMETER DATA
  plot_acc_raw_shimmer = xyplot(  data[windowframe,3]+data[windowframe,5]+data[windowframe,7] ~ windowframe,
                                  pch=16, col.line = c('red', 'blue', 'yellow3'), type = c("l","g"), lwd=6,
                                  main=list(label=paste( " ",sep=""), cex=2.5),
                                  xlab=list(label="Samples", cex=3, fontfamily="Times"),
                                  ylab=list(label="Raw Data", cex=3, fontfamily="Times"),
                                  scales = list(font=1, cex=2,
                                    y=list(
                                      at=seq(-ymaxminlimit,ymaxminlimit,ymaxminlimit/2),limits=c(-ymaxminlimit - (0.1*ymaxminlimit),ymaxminlimit+ (0.1*ymaxminlimit) )
                                      )
                                  )
                                  ,

                                  ## LABELS
                                  key=list(
                                    border= "grey",
                                    text = list(c(expression(A[x]), expression(A[y]), expression(A[z]))),
                                    lines = list(pch=c(1,2,3), col= c('red','blue','yellow3')), type="l", lwd=5,
                                    cex=2.25, # control the character expansion  of the symbols
                                    corner=c(1,0) # position
                                  ),
                                  #function to modify the grid pattern
                                  panel=function(...) {
                                    panel.xyplot(...)
                                    panel.grid(h=-50, v=-1, col.line="blue", lwd=1, lty=3 )
                                  }
  )


  print(plot_acc_raw_shimmer)
}
#example
#plot_acc_raw_shimmer(data,default_windowframe)




#         MD[,4] CAL Wide Range Accelerometer X (m/(sec^2))
#         MD[,6] CAL Wide Range Accelerometer Y (m/(sec^2))
#         MD[,8] CAL Wide Range Accelerometer Z (m/(sec^2))
plot_acc_cal_shimmer<- function(data,windowframe)
{
  ymaxminlimit=25
  ###PLOT ACCELEROMETER DATA
  plot_acc_cal_shimmer = xyplot(  data[windowframe,4]+data[windowframe,6]+data[windowframe,8] ~ windowframe,
                                  pch=16, col.line = c('red', 'blue', 'yellow3'), type = c("l","g"), lwd=6,
                                  main=list(label=paste(" ",sep=""), cex=2.5),
                                  xlab=list(label="Samples", cex=3, fontfamily="Times"),
                                  ylab=list(label="m/(sec^2)", cex=3, fontfamily="Times"),
                                  scales = list(font=1, cex=2,
                                    y=list(
                                      at=seq(-ymaxminlimit,ymaxminlimit,ymaxminlimit/2),limits=c(-ymaxminlimit - (0.1*ymaxminlimit),ymaxminlimit+ (0.1*ymaxminlimit) )
                                      )
                                  )
                                  ,

                                  ## LABELS
                                  key=list(
                                    border= "grey",
                                    text = list(c(expression(A[x]), expression(A[y]), expression(A[z]))),
                                    lines = list(pch=c(1,2,3), col= c('red','blue','yellow3')), type="l", lwd=5,
                                    cex=2.25, # control the character expansion  of the symbols
                                    corner=c(1,0) # position
                                  ),
                                  #function to modify the grid pattern
                                  panel=function(...) {
                                    panel.xyplot(...)
                                    panel.grid(h=-50, v=-1, col.line="blue", lwd=1, lty=3 )
                                  }
  )


  print(plot_acc_cal_shimmer)
}
#example
#plot_acc_cal_shimmer(data,default_windowframe)




#         MD[,9]  RAW Gyroscope X (no units)
#         MD[,11] RAW Gyroscope Y (no units)
#         MD[,13] RAW Gyroscope Z (no units)
plot_gyr_raw_shimmer<- function(data,windowframe)
{

  ymaxminlimit=8000
  ###PLOT  DATA
  plot_gyr_raw_shimmer = xyplot(  data[windowframe,9]+data[windowframe,11]+data[windowframe,13] ~ windowframe,
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
                                    lines = list(pch=c(1,2,3), col= c('red','blue','yellow3')), type="l", lwd=5,
                                    cex=2.25, # control the character expansion  of the symbols
                                    corner=c(1,0) # position
                                  ),
                                  #function to modify the grid pattern
                                  panel=function(...) {
                                    panel.xyplot(...)
                                    panel.grid(h=-50, v=-1, col.line="blue", lwd=1, lty=3 )
                                  }
  )

  print(plot_gyr_raw_shimmer)
}

#example
#plot_gyr_raw_shimmer(data,default_windowframe)



#         MD[,10] CAL Gyroscope X (deg/sec)
#         MD[,12] CAL Gyroscope Y (deg/sec)
#         MD[,14] CAL Gyroscope Z (deg/sec)
plot_gyr_cal_shimmer<- function(data,windowframe)
{
ymaxminlimit=500
  ###PLOT MAGNETOMETER DATA
  plot_gyr_cal_shimmer = xyplot(  data[windowframe,10]+data[windowframe,12]+data[windowframe,14] ~ windowframe,
                                  pch=16, col.line = c('red', 'blue', 'yellow3'), type = c("l","g"), lwd=6,
                                  main=list(label=paste(" ",sep=""), cex=2.5),
                                  xlab=list(label="Samples", cex=3, fontfamily="Times"),
                                  ylab=list(label="deg/sec", cex=3, fontfamily="Times"),
                                  scales = list(font=1, cex=2,
                                    y=list(
                                      at=seq(-ymaxminlimit,ymaxminlimit,ymaxminlimit/2),limits=c(-ymaxminlimit - (0.1*ymaxminlimit),ymaxminlimit+ (0.1*ymaxminlimit) )
                                      )
                                  ),

                                  ## LABELS
                                  key=list(
                                    border= "grey",
                                    text = list(c(expression(G[x]), expression(G[y]), expression(G[z]))),
                                    lines = list(pch=c(1,2,3), col= c('red','blue','yellow3')), type="l", lwd=5,
                                    cex=2.25, # control the character expansion  of the symbols
                                    corner=c(1,0) # position
                                  ),
                                  #function to modify the grid pattern
                                  panel=function(...) {
                                    panel.xyplot(...)
                                    panel.grid(h=-50, v=-1, col.line="blue", lwd=1, lty=3 )
                                  }
  )

  print(plot_gyr_cal_shimmer)
}
#example
#plot_gyr_cal_shimmer(data,default_windowframe)





#         MD[,15] RAW Magnetometer X (no units)
#         MD[,17] RAW Magnetometer Y (no units)
#         MD[,19] RAW Magnetometer Z (no units)
plot_mag_raw_shimmer<- function(data,windowframe)
{
  ymaxminlimit=250
  ###PLOT  DATA
  plot_mag_raw_shimmer = xyplot(  data[windowframe,15]+data[windowframe,17]+data[windowframe,19] ~ windowframe,
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
                                    text = list(c(expression(M[x]), expression(M[y]), expression(M[z]))),
                                    lines = list(pch=c(1,2,3), col= c('red','blue','yellow3')), type="l", lwd=5,
                                    cex=2.25, # control the character expansion  of the symbols
                                    corner=c(1,0) # position
                                  ),
                                  #function to modify the grid pattern
                                  panel=function(...) {
                                    panel.xyplot(...)
                                    panel.grid(h=-50, v=-1, col.line="blue", lwd=1, lty=3 )
                                  }
  )

  print(plot_mag_raw_shimmer)
}


#example
#plot_mag_raw_shimmer(data,default_windowframe)



#         MD[,16] CAL Magnetometer X (local)
#         MD[,18] CAL Magnetometer Y (local)
#         MD[,20] CAL Magnetometer Z (local)
plot_mag_cal_shimmer<- function(data,windowframe)
{
  ymaxminlimit=1.5
  ###PLOT  DATA
  plot_mag_cal_shimmer = xyplot(  data[windowframe,16]+data[windowframe,18]+data[windowframe,20] ~ windowframe,
                                  pch=16, col.line = c('red', 'blue', 'yellow3'), type = c("l","g"), lwd=6,
                                  main=list(label=paste( " ",sep=""), cex=2.5),
                                  xlab=list(label="Samples", cex=3, fontfamily="Times"),
                                  ylab=list(label="local", cex=3, fontfamily="Times"),
                                  scales = list(font=1, cex=2,
                                                y=list(
                                                at=seq(-ymaxminlimit,ymaxminlimit,ymaxminlimit/2),limits=c(-ymaxminlimit - (0.1*ymaxminlimit),ymaxminlimit+ (0.1*ymaxminlimit) )
                                                )
                                  ),
                                  ## LABELS
                                  key=list(
                                    border= "grey",
                                    text = list(c(expression(M[x]), expression(M[y]), expression(M[z]))),
                                    lines = list(pch=c(1,2,3), col= c('red','blue','yellow3')), type="l", lwd=5,
                                    cex=2.25, # control the character expansion  of the symbols
                                    corner=c(1,0) # position
                                  ),
                                  #function to modify the grid pattern
                                  panel=function(...) {
                                    panel.xyplot(...)
                                    panel.grid(h=-50, v=-1, col.line="blue", lwd=1, lty=3 )
                                  }
  )

  print(plot_mag_cal_shimmer)
}
#example
#plot_mag_cal_shimmer(data,default_windowframe)





#         MD[,21] RAW zeromean_unitvariance Wide Range Accelerometer X (no units)
#         MD[,22] RAW zeromean_unitvariance Wide Range Accelerometer Y (no units)
#         MD[,23] RAW zeromean_unitvariance Wide Range Accelerometer Z (no units)
plot_acc_raw_n_shimmer<- function(data,windowframe)
{
  ymaxminlimit=5
  ###PLOT  DATA
  plot = xyplot(  data[windowframe,21]+data[windowframe,22]+data[windowframe,23] ~ windowframe,
                                  pch=16, col.line = c('red', 'blue', 'yellow3'), type = c("l","g"), lwd=6,
                                  main=list(label=paste( " ",sep=""), cex=2.5),
                                  xlab=list(label="Samples", cex=3, fontfamily="Times"),
                                  ylab=list(label="z.m.u.v.", cex=3, fontfamily="Times"),
                                  scales = list(font=1, cex=2,
                                                y=list(
                                                at=seq(-ymaxminlimit,ymaxminlimit,ymaxminlimit/2),limits=c(-ymaxminlimit - (0.1*ymaxminlimit),ymaxminlimit+ (0.1*ymaxminlimit) )
                                                )
                                  ),
                                  ## LABELS
                                  key=list(
                                    border= "grey",
                                    text = list(c(expression(A[x]), expression(A[y]), expression(A[z]))),
                                    lines = list(pch=c(1,2,3), col= c('red','blue','yellow3')), type="l", lwd=5,
                                    cex=2.25, # control the character expansion  of the symbols
                                    corner=c(1,0) # position
                                  ),
                                  #function to modify the grid pattern
                                  panel=function(...) {
                                    panel.xyplot(...)
                                    panel.grid(h=-50, v=-1, col.line="blue", lwd=1, lty=3 )
                                  }
  )

  print(plot)
}




#         MD[,24] CAL zeromean_unitvariance Wide Range Accelerometer X (m/(sec^2))
#         MD[,25] CAL zeromean_unitvariance Wide Range Accelerometer Y (m/(sec^2))
#         MD[,26] CAL zeromean_unitvariance Wide Range Accelerometer Z (m/(sec^2))
plot_acc_cal_n_shimmer<- function(data,windowframe)
{
  ymaxminlimit=5
  ###PLOT  DATA
  plot = xyplot(  data[windowframe,24]+data[windowframe,25]+data[windowframe,26] ~ windowframe,
                                  pch=16, col.line = c('red', 'blue', 'yellow3'), type = c("l","g"), lwd=6,
                                  main=list(label=paste( " ",sep=""), cex=2.5),
                                  xlab=list(label="Samples", cex=3, fontfamily="Times"),
                                  ylab=list(label="z.m.u.v.", cex=3, fontfamily="Times"),
                                  scales = list(font=1, cex=2,
                                                y=list(
                                                at=seq(-ymaxminlimit,ymaxminlimit,ymaxminlimit/2),limits=c(-ymaxminlimit - (0.1*ymaxminlimit),ymaxminlimit+ (0.1*ymaxminlimit) )
                                                )
                                  ),
                                  ## LABELS
                                  key=list(
                                    border= "grey",
                                    text = list(c(expression(A[x]), expression(A[y]), expression(A[z]))),
                                    lines = list(pch=c(1,2,3), col= c('red','blue','yellow3')), type="l", lwd=5,
                                    cex=2.25, # control the character expansion  of the symbols
                                    corner=c(1,0) # position
                                  ),
                                  #function to modify the grid pattern
                                  panel=function(...) {
                                    panel.xyplot(...)
                                    panel.grid(h=-50, v=-1, col.line="blue", lwd=1, lty=3 )
                                  }
  )

  print(plot)
}




#         MD[,27] RAW zeromean_unitvariance Gyroscope X (no units)
#         MD[,28] RAW zeromean_unitvariance Gyroscope Y (no units)
#         MD[,29] RAW zeromean_unitvariance Gyroscope Z (no units)
plot_gyr_raw_n_shimmer<- function(data,windowframe)
{
  ymaxminlimit=5
  ###PLOT  DATA
  plot = xyplot(  data[windowframe,27]+data[windowframe,28]+data[windowframe,29] ~ windowframe,
                                  pch=16, col.line = c('red', 'blue', 'yellow3'), type = c("l","g"), lwd=6,
                                  main=list(label=paste( " ",sep=""), cex=2.5),
                                  xlab=list(label="Samples", cex=3, fontfamily="Times"),
                                  ylab=list(label="z.m.u.v.", cex=3, fontfamily="Times"),
                                  scales = list(font=1, cex=2,
                                                y=list(
                                                at=seq(-ymaxminlimit,ymaxminlimit,ymaxminlimit/2),limits=c(-ymaxminlimit - (0.1*ymaxminlimit),ymaxminlimit+ (0.1*ymaxminlimit) )
                                                )
                                  ),
                                  ## LABELS
                                  key=list(
                                    border= "grey",
                                    text = list(c(expression(G[x]), expression(G[y]), expression(G[z]))),
                                    lines = list(pch=c(1,2,3), col= c('red','blue','yellow3')), type="l", lwd=5,
                                    cex=2.25, # control the character expansion  of the symbols
                                    corner=c(1,0) # position
                                  ),
                                  #function to modify the grid pattern
                                  panel=function(...) {
                                    panel.xyplot(...)
                                    panel.grid(h=-50, v=-1, col.line="blue", lwd=1, lty=3 )
                                  }
  )

  print(plot)
}




#         MD[,30] CAL zeromean_unitvariance Gyroscope X (deg/sec)
#         MD[,31] CAL zeromean_unitvariance Gyroscope Y (deg/sec)
#         MD[,32] CAL zeromean_unitvariance Gyroscope Z (deg/sec)
plot_gyr_cal_n_shimmer<- function(data,windowframe)
{
  ymaxminlimit=5
  ###PLOT  DATA
  plot = xyplot(  data[windowframe,30]+data[windowframe,31]+data[windowframe,32] ~ windowframe,
                                  pch=16, col.line = c('red', 'blue', 'yellow3'), type = c("l","g"), lwd=6,
                                  main=list(label=paste( " ",sep=""), cex=2.5),
                                  xlab=list(label="Samples", cex=3, fontfamily="Times"),
                                  ylab=list(label="z.m.u.v.", cex=3, fontfamily="Times"),
                                  scales = list(font=1, cex=2,
                                                y=list(
                                                at=seq(-ymaxminlimit,ymaxminlimit,ymaxminlimit/2),limits=c(-ymaxminlimit - (0.1*ymaxminlimit),ymaxminlimit+ (0.1*ymaxminlimit) )
                                                )
                                  ),
                                  ## LABELS
                                  key=list(
                                    border= "grey",
                                    text = list(c(expression(G[x]), expression(G[y]), expression(G[z]))),
                                    lines = list(pch=c(1,2,3), col= c('red','blue','yellow3')), type="l", lwd=5,
                                    cex=2.25, # control the character expansion  of the symbols
                                    corner=c(1,0) # position
                                  ),
                                  #function to modify the grid pattern
                                  panel=function(...) {
                                    panel.xyplot(...)
                                    panel.grid(h=-50, v=-1, col.line="blue", lwd=1, lty=3 )
                                  }
  )

  print(plot)
}








#         MD[,33] RAW zeromean_unitvariance Magnetometer X (no units)
#         MD[,34] RAW zeromean_unitvariance Magnetometer Y (no units)
#         MD[,35] RAW zeromean_unitvariance Magnetometer Z (no units)
plot_mag_raw_n_shimmer<- function(data,windowframe)
{
  ymaxminlimit=3
  ###PLOT  DATA
  plot = xyplot(  data[windowframe,33]+data[windowframe,34]+data[windowframe,35] ~ windowframe,
                                  pch=16, col.line = c('red', 'blue', 'yellow3'), type = c("l","g"), lwd=6,
                                  main=list(label=paste( " ",sep=""), cex=2.5),
                                  xlab=list(label="Samples", cex=3, fontfamily="Times"),
                                  ylab=list(label="z.m.u.v.", cex=3, fontfamily="Times"),
                                  scales = list(font=1, cex=2,
                                                y=list(
                                                at=seq(-ymaxminlimit,ymaxminlimit,ymaxminlimit/2),limits=c(-ymaxminlimit - (0.1*ymaxminlimit),ymaxminlimit+ (0.1*ymaxminlimit) )
                                                )
                                  ),
                                  ## LABELS
                                  key=list(
                                    border= "grey",
                                    text = list(c(expression(M[x]), expression(M[y]), expression(M[z]))),
                                    lines = list(pch=c(1,2,3), col= c('red','blue','yellow3')), type="l", lwd=5,
                                    cex=2.25, # control the character expansion  of the symbols
                                    corner=c(1,0) # position
                                  ),
                                  #function to modify the grid pattern
                                  panel=function(...) {
                                    panel.xyplot(...)
                                    panel.grid(h=-50, v=-1, col.line="blue", lwd=1, lty=3 )
                                  }
  )

  print(plot)
}



#         MD[,36] CAL zeromean_unitvariance Magnetometer X (local)
#         MD[,37] CAL zeromean_unitvariance Magnetometer Y (local)
#         MD[,38] CAL zeromean_unitvariance Magnetometer Z (local)
plot_mag_cal_n_shimmer<- function(data,windowframe)
{
  ymaxminlimit=3
  ###PLOT  DATA
  plot = xyplot(  data[windowframe,36]+data[windowframe,37]+data[windowframe,38] ~ windowframe,
                                  pch=16, col.line = c('red', 'blue', 'yellow3'), type = c("l","g"), lwd=6,
                                  main=list(label=paste( " ",sep=""), cex=2.5),
                                  xlab=list(label="Samples", cex=3, fontfamily="Times"),
                                  ylab=list(label="z.m.u.v.", cex=3, fontfamily="Times"),
                                  scales = list(font=1, cex=2,
                                                y=list(
                                                at=seq(-ymaxminlimit,ymaxminlimit,ymaxminlimit/2),limits=c(-ymaxminlimit - (0.1*ymaxminlimit),ymaxminlimit+ (0.1*ymaxminlimit) )
                                                )
                                  ),
                                  ## LABELS
                                  key=list(
                                    border= "grey",
                                    text = list(c(expression(M[x]), expression(M[y]), expression(M[z]))),
                                    lines = list(pch=c(1,2,3), col= c('red','blue','yellow3')), type="l", lwd=5,
                                    cex=2.25, # control the character expansion  of the symbols
                                    corner=c(1,0) # position
                                  ),
                                  #function to modify the grid pattern
                                  panel=function(...) {
                                    panel.xyplot(...)
                                    panel.grid(h=-50, v=-1, col.line="blue", lwd=1, lty=3 )
                                  }
  )

  print(plot)
}









plot_shimmer_one_axis<- function(data,axis_number,windowframe)
{
  ###PLOT ACCELEROMETER DATA
  plot = xyplot(  data[windowframe,axis_number] ~ windowframe,
                                  pch=16, col.line = c('red', 'blue', 'yellow3'), type = c("l","g"), lwd=6,
                                  main=list(label=paste( " ",sep=""), cex=2.5),
                                  xlab=list(label="Samples", cex=3, fontfamily="Times"),
                                  ylab=list(label="Raw Data", cex=3, fontfamily="Times"),
                                  scales = list(font=1, cex=2),


                                  #function to modify the grid pattern
                                  panel=function(...) {
                                    panel.xyplot(...)
                                    panel.grid(h=-50, v=-1, col.line="blue", lwd=1, lty=3 )
                                  }
  )

  print(plot)
}
#example
#plot_shimmer_one_axis(data,axis_number,windowframe)





################################
################################
################################
######## PLOTS ROS (ROBOT OPERATING SYSTEM)
################################
################################
################################





plot_ros_acc<- function(data,window)
{
  plot <- xyplot( data[window,4]+data[window,5]+data[window,6] ~ window,
                      pch=16, col.line = c('red', 'blue', 'yellow3'), type = c("l","g"), lwd=6,
                      main=list(label=paste(" ",sep=""), cex=2.5),
                      xlab=list(label="Samples", cex=3, fontfamily="Times"),
                      ylab=list(label="Raw Data", cex=3, fontfamily="Times"),
                      scales = list(font=1, cex=2,
                                    y=list(
                                      at=seq(-1250,1250,100),limits=c(-1250,1250)
                                    )
                      ),

                      ## LABELS
                      key=list(
                        border= "grey",
                        text = list(c(expression(A[x]), expression(A[y]), expression(A[z]))),
                        lines = list(pch=c(1,2,3), col= c('red','blue','yellow3')), type="l", lwd=5,
                        cex=2.25, # control the character expansion  of the symbols
                        corner=c(1,0) # position
                      ),
                      #function to modify the grid pattern
                      panel=function(...) {
                        panel.xyplot(...)
                        panel.grid(h=-50, v=-1, col.line="blue", lwd=1, lty=3 )
                      }
                      )

print(plot)
}


plot_ros_gyr<- function(data,window)
{
  plot <- xyplot(  data[window,7]+data[window,8]+data[window,9] ~ window,
                      pch=16, col.line = c('red', 'blue', 'yellow3'), type = c("l","g"), lwd=6,
                      main=list(label=paste(" ",sep=""), cex=2.5),
                      xlab=list(label="Samples", cex=3, fontfamily="Times"),
                      ylab=list(label="Raw Data", cex=3, fontfamily="Times"),
                      scales = list(font=1, cex=2,
                                    y=list(
                                    at=seq(-20,20,5),limits=c(-20.9,20.9)
                                    )
                      ),

                      ## LABELS
                      key=list(
                        border= "grey",
                        text = list(c(expression(G[x]), expression(G[y]), expression(G[z]))),
                        lines = list(pch=c(1,2,3), col= c('red','blue','yellow3')), type="l", lwd=5,
                        cex=2.25, # control the character expansion  of the symbols
                        corner=c(1,0) # position
                      ),
                      #function to modify the grid pattern
                      panel=function(...) {
                        panel.xyplot(...)
                        panel.grid(h=-50, v=-1, col.line="blue", lwd=1, lty=3 )
                      }
  )

print(plot)
}


plot_ros_ypr<- function(data,window)
{
  plot <- xyplot(  data[window,1]+data[window,2]+data[window,3] ~ window,
                      pch=16, col.line = c('red', 'blue', 'yellow3'), type = c("l","g"), lwd=6,
                      main=list(label=paste(" ",sep=""), cex=2.5),
                      xlab=list(label="Samples", cex=3, fontfamily="Times"),
                      ylab=list(label="Raw Data", cex=3, fontfamily="Times"),
                      scales = list(font=1, cex=2,
                                    y=list(
                                    at=seq(-200,200,10),limits=c(-200.9,200.9)
                                    )
                      ),

                      ## LABELS
                      key=list(
                        border= "grey",
                        text = list(c(expression(Y), expression(P), expression(R))),
                        lines = list(pch=c(1,2,3), col= c('red','blue','yellow3')), type="l", lwd=5,
                        cex=2.25, # control the character expansion  of the symbols
                        corner=c(1,0) # position
                      ),
                      #function to modify the grid pattern
                      panel=function(...) {
                        panel.xyplot(...)
                        panel.grid(h=-50, v=-1, col.line="blue", lwd=1, lty=3 )
                      }
  )

print(plot)
}
