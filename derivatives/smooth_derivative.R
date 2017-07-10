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




library(prospectr) #for signal processing and NIRsoil
library(signal) # for sgolay polynomial and filter
library(data.table)
library(ggplot2)




################################################################################
# (1) Defining paths for main_path, r_scripts_path, ..., etc.
r_scripts_path <- getwd()

setwd("../")
main_repository_path <- getwd()
setwd("../")
main_path <- getwd()
outcomes_path <- paste(main_path,"/DataSets/temp_plots",sep="")

################################################################################
# (3) Creating and Changing to Preprosseced Data Path
#
plot_path <- paste(outcomes_path,"/derivatives/smooth_derivative",sep="")
if (file.exists(plot_path)){
  setwd(file.path(plot_path))
} else {
  dir.create(plot_path, recursive=TRUE)
  setwd(file.path(plot_path))
}






#################
# Start the clock!
start.time <- Sys.time()



################################################################################
################################################################################
## Setup and Preparation of Data


data(NIRsoil)
# NIRsoil is a data.frame with 825 obs and 5 variables: Nt (Total Nitrogen),
# Ciso (Carbon), CEC (Cation Exchange Capacity), train (vector of 0,1
# indicating training (1) and validation (0) samples), spc (spectral matrix)

wl  <- as.numeric(colnames(NIRsoil$spc))

raw <- as.data.table(  t(NIRsoil$spc) )
names(raw) <- gsub("^", "\\rawsignal", names(raw))

noise <- as.data.table(
  matrix( rnorm(nrow(raw)*ncol(raw) ,0,0.005), nrow(raw))
  )
names(noise) <- gsub("V", "noise", names(noise))

sn <- raw+noise
names(sn) <- gsub("rawsignal", "rawsignoise", names(sn))




################################################################################
### (4.2) Smoothing data with Savitzky-Golay Filter
###
SavitzkyGolayCoeffs <- sgolay(p=5,n=155 ,m=0)

### FUNCTON TO SMOOTH THE DATA
SGolay <- function(xinput,sgCoeffs){
  output <- filter(sgCoeffs, xinput)
  return(output)
}


sn[, paste("SG", names(sn),  sep= ""):= lapply( .SD , function(x) ( SGolay(x,SavitzkyGolayCoeffs)  )  ) ]





################################################################################
### Derivatives
DerOne <- as.data.table(  diff( as.matrix(sn), differences=1,lag=1 )  )
colnames(DerOne) <- gsub("rawsignoise", "DerOnerawsignoise", colnames(DerOne))
colnames(DerOne) <- gsub("SGDerOnerawsignoise", "DerOneSGrawsignoise", colnames(DerOne))


DerTwo <- as.data.table(  diff( as.matrix(sn), differences=2,lag=1 )  )
colnames(DerTwo) <- gsub("rawsignoise", "DerTworawsignoise", colnames(DerTwo))
colnames(DerTwo) <- gsub("SGDerTworawsignoise", "DerTwoSGrawsignoise", colnames(DerTwo))




###  Data Table

DT <- data.table(
  wl,
  raw,
  noise,
  sn,
  DerOne,
  DerTwo
  )



################################################################################
### Plotting


tagname <- "plot-smooth-derivative"



p0 <- ggplot(DT )+
    geom_line( aes(wl, rawsignoise1,colour="rawsignoise") , size=0.4, linetype = "solid", alpha=1.0)+
    geom_line( aes(wl, SGrawsignoise1,colour="sgrawsignoise") , size=1.4, linetype="solid", alpha=1.0)+
    scale_colour_manual("",
                    breaks = c("rawsignoise", "sgrawsignoise"),values = c("blue", "red"))+
    theme(legend.position = c(0.8, 0.9),
          legend.background = element_rect(size = 0.2,
                                           color = "black",
                                           fill = "grey90",
                                           linetype = "solid"))


tiff(filename= paste(tagname,"_p0.tiff",sep=''),
   width=2000, height=1500, units="px", res=150, bg="transparent")
p0
dev.off()




p1 <- ggplot(DT )+
    geom_line( aes(wl, DerOnerawsignoise1,colour="sgdo") , size=1.4, linetype = "solid", alpha=1.0)+
    geom_line( aes(wl, DerOneSGrawsignoise1,colour="sgdt") , size=0.4, linetype="F1", alpha=1.0)+
    scale_colour_manual("",
                    breaks = c("sgdo", "sgdt"),values = c("blue", "red"))+
    theme(legend.position = c(0.8, 0.9),
          legend.background = element_rect(size = 0.2,
                                           color = "black",
                                           fill = "grey90",
                                           linetype = "solid"))


tiff(filename= paste(tagname,"_p1.tiff",sep=''),
   width=2000, height=1500, units="px", res=150, bg="transparent")
p1
dev.off()



p2 <- ggplot(DT )+
    geom_line( aes(wl, DerTworawsignoise1,colour="sgdo") , size=1.4, linetype = "solid", alpha=1.0)+
    geom_line( aes(wl, DerTwoSGrawsignoise1,colour="sgdt") , size=0.4, linetype="F1", alpha=1.0)+
    scale_colour_manual("",
                    breaks = c("sgdo", "sgdt"),values = c("blue", "red"))+
    theme(legend.position = c(0.8, 0.9),
          legend.background = element_rect(size = 0.2,
                                           color = "black",
                                           fill = "grey90",
                                           linetype = "solid"))


tiff(filename= paste(tagname,"_p2.tiff",sep=''),
   width=2000, height=1500, units="px", res=150, bg="transparent")
p2
dev.off()






pX <- ggplot(DT )+
    geom_line( aes(wl, DerOneSGrawsignoise1,colour="sgdo") , size=1.4, linetype = "solid", alpha=1.0)+
    geom_line( aes(wl, DerTwoSGrawsignoise1,colour="sgdt") , size=0.4, linetype="F1", alpha=1.0)+
    scale_colour_manual("",
                    breaks = c("sgdo", "sgdt"),values = c("blue", "red"))+
    theme(legend.position = c(0.8, 0.9),
          legend.background = element_rect(size = 0.2,
                                           color = "black",
                                           fill = "grey90",
                                           linetype = "solid"))


tiff(filename= paste(tagname,"_pX.tiff",sep=''),
   width=2000, height=1500, units="px", res=150, bg="transparent")
pX
dev.off()






#################
# Stop the clock!
end.time <- Sys.time()
end.time - start.time

################################################################################
setwd(r_scripts_path) ## go back to the r-script source path
