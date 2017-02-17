#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#
#
# FileName:           derivatives00.R
# FileDescription:
#
# Reference:
#          #
#
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# Miguel P. Xochicale [http://mxochicale.github.io]
# Doctoral Researcher in Human-Robot Interaction
# University of Birmingham, U.K. (2014-2018)
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++



library(signal)
library(prospectr) #for signal processing and NIRsoil
library(data.table)
library(ggplot2)


data(NIRsoil)
str(NIRsoil)

# Extract spectral data as datatable
wl  <- as.numeric(colnames(NIRsoil$spc))

raw <- as.data.table(  t(NIRsoil$spc) )
names(raw) <- gsub("^", "\\rawsignal", names(raw))

noise <- as.data.table(
  matrix(rnorm(nrow(raw)*ncol(raw) ,0,0.005), nrow(raw))
  )
names(noise) <- gsub("V", "noise", names(noise))

sn <- raw+noise
names(sn) <- gsub("rawsignal", "rawsignoise", names(sn))


DerOne <- as.data.table(  diff( as.matrix(raw), differences=1,lag=1 )  )
colnames(DerOne) <- gsub("rawsignal", "DerOne", colnames(DerOne))

DerTwo <- as.data.table(  diff( as.matrix(raw), differences=2,lag=1 )  )
colnames(DerTwo) <- gsub("rawsignal", "DerTwo", colnames(DerTwo))

# gapDer: Gap-segment derivative which performs first a smoothing under a given
# segement size, followed by gap derivative
# m=order of the derivative; w=window size(={2*gap size}+1);
# s=segment size first derivative with a gap of 10 bands
gsDerOne <- gapDer(X=t(raw),m=1,w=11,s=10)
gsDerOne <- as.data.table( t(gsDerOne))
colnames(gsDerOne) <- gsub("rawsignal", "gsDerOne", colnames(gsDerOne))

DT <- data.table(
  wl,
  raw,
  noise,
  sn,
  DerOne,
  DerTwo,
  gsDerOne
  )



# ##########Plotting##############
# p <- ggplot(DT)+
#     geom_line( aes(wl,rawsignal1) , size=1.2 )+
#     geom_line( aes(wl,rawsignoise1), linetype="F1", size=0.4, alpha=0.5, color="red")

# p <- ggplot(DT)+
#     geom_line( aes(wl,DerOne1) , size=1 )+
#     geom_line( aes(wl,DerTwo1) , size=1, color="red" )

p <- ggplot(DT)+
  geom_line( aes(wl,DerOne1) , size=1 )+
  geom_line( aes(wl,gsDerOne1) , size=1, color="red")

p


### manipulatepcolumns-by-their-name-pattern-in-r-data-table
indx <- grep('gsDerOne', names(DT))
for(k in indx){set(DT,DT[[k]])}
#then shift for to lead/lag vectors and lists















###*legends are not working
# scale_shape_discrete(
#   name="X",
#   breaks=c("1st-derivative", "Gap-segment derivative"),
#   labels=c("1st-derivative", "Gap-segment derivative")
#   )

## coord_cartesian(y=c(-1,0.1))
# # names(DT) <- gsub("sn.s", "sn", names(DT))
# plot( as.numeric(rownames(d1)), d1[1,], type="l")

#
# sgp <- sgolay(p=1,n=13 ,m=0)
# dt[,movav:=movav(noisy, w=11) ]
# dt[,sg1:= savitzkyGolay(noisy, p=3,w=11,m=0) ]
# dt[,sg2:= filter(sgp, noisy) ]
# # Moving average or running mean
# X <- movav(noisy, w=11) # window size of 11 bands
# # Savitzky-Golay Filtering
# # p=polynomial order; w=window size(must be odd); m=m-th derivative (0=smoothing)
# sg <- savitzkyGolay(NIRsoil$spc,p=3,w=11,m=0)
