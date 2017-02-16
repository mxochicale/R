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

s <- as.data.table(  t(NIRsoil$spc) )
names(s) <- gsub("^", "\\s", names(s))

noise <- as.data.table(
  matrix(rnorm(nrow(s)*ncol(s) ,0,0.005), nrow(s))
  )
names(noise) <- gsub("V", "n", names(noise))

sn <- s+noise
names(sn) <- gsub("s", "sn", names(sn))


derone <- as.data.table(  diff( as.matrix(s), differences=1 )  )
colnames(derone) <- gsub("s", "derone", colnames(derone))

dertwo <- as.data.table(  diff( as.matrix(s), differences=2 )  )
colnames(dertwo) <- gsub("s", "dertwo", colnames(dertwo))



DT <- data.table(
  wl,
  s,
  noise,
  sn,
  derone,
  dertwo
  )



# p <- ggplot(DT)+
#     geom_line( aes(wl,s1) , size=1 )+
#     geom_line( aes(wl,sn1), linetype="F1", size=0.2, alpha=0.5, color="red")
# print(p)

p <- ggplot(DT)+
    geom_line( aes(wl,derone1) , size=1 )+
    geom_line( aes(wl,dertwo1) , size=1, color="red" )
print(p)


#      coord_cartesian(y=c(-1,0.1))
# # names(DT) <- gsub("sn.s", "sn", names(DT))
# plot( as.numeric(rownames(d1)), d1[1,], type="l")

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
