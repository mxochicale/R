
##
## running first time
##

Create a genaral to call cao97sub.so
set dyn.load(path/cao97sub.so )

#1
extract data from either lorenz, sine or imu time-series
	extractdata_imu.R
	extractdata_lorenzts.R
	extractdata_sine.R

#2
build dll to wrap f function in R
R CMD SHLIB cao97sub.f

#3
cao97rf.R
   compute E1 and E2 values
   and print the values in plots

#4 cc -o minfo minfo5.c -lm
./minfo datafile -b 100 -t 100 > r.mi

#5
mi_comparison.R
