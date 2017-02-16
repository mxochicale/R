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
spc <- as.data.table(  t(NIRsoil$spc) )
names(spc) <- gsub("^", "\\s", names(spc))
r  <- as.numeric(colnames(NIRsoil$spc))

noise <- as.data.table(
  matrix(rnorm(nrow(spc)*ncol(spc) ,0,0.005), nrow(spc))
  )
names(noise) <- gsub("V", "n", names(noise))


DT <- data.table(
  r,
  spc,
  noise,
  sn=spc+noise
  )
names(DT) <- gsub("sn.s", "sn", names(DT))


p <- ggplot(DT)+
    geom_line( aes(r,s1) , size=1 )+
    geom_line( aes(r,sn1), linetype="F1", size=0.2, alpha=0.5, color="red")
#      coord_cartesian(y=c(-1,0.1))
print(p)



  # d1= t(  diff( t(sn) , differences=1 )  )
  # gsd1 <- gapDer(X=spc,m=1,w=9,s=1)
# sgp <- sgolay(p=1,n=13 ,m=0)
# dt[,movav:=movav(noisy, w=11) ]
# dt[,sg1:= savitzkyGolay(noisy, p=3,w=11,m=0) ]
# dt[,sg2:= filter(sgp, noisy) ]


# # Moving average or running mean
# X <- movav(noisy, w=11) # window size of 11 bands
# # Savitzky-Golay Filtering
# # p=polynomial order; w=window size(must be odd); m=m-th derivative (0=smoothing)
# sg <- savitzkyGolay(NIRsoil$spc,p=3,w=11,m=0)
