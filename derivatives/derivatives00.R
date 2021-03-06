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
plot_path <- paste(outcomes_path,"/derivatives/derivatives00",sep="")
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
### Derivatives
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


gsDerTwo <- gapDer(X=t(raw),m=2,w=11,s=10)
gsDerTwo <- as.data.table( t(gsDerTwo))
colnames(gsDerTwo) <- gsub("rawsignal", "gsDerTwo", colnames(gsDerTwo))





###  Data Table

DT <- data.table(
  wl,
  raw,
  noise,
  sn,
  DerOne,
  DerTwo,
  gsDerOne,
  gsDerTwo
  )



################################################################################
### Plotting

tagname <- "plot"

p0 <- ggplot(DT )+
    geom_line( aes(wl, rawsignal1,colour="raw") , size=1.4, linetype = "solid", alpha=1.0)+
    geom_line( aes(wl, rawsignoise1,colour="raw+noise") , size=0.4, linetype="F1", alpha=1.0)+
    scale_colour_manual("",
                    breaks = c("raw", "raw+noise"),values = c("blue", "red"))+
    theme(legend.position = c(0.8, 0.9),
          legend.background = element_rect(size = 0.2,
                                           color = "black",
                                           fill = "grey90",
                                           linetype = "solid"))


tiff(filename= paste(tagname,"_p0.tiff",sep=''),
   width=2000, height=1500, units="px", res=150, bg="transparent")
p0
dev.off()


p1 <- ggplot(DT)+
    geom_line( aes(wl, DerOne1,colour="der_diff1") , size=1.4, linetype = "solid", alpha=1.0)+
    geom_line( aes(wl, DerTwo1,colour="der_diff2") , size=0.4, linetype="F1", alpha=1.0)+
    scale_colour_manual("",
                    breaks = c("der_diff1", "der_diff2"),values = c("blue", "red"))+
    theme(legend.position = c(0.8, 0.9),
          legend.background = element_rect(size = 0.2,
                                           color = "black",
                                           fill = "grey90",
                                           linetype = "solid"))



tiff(filename= paste(tagname,"_p1.tiff",sep=''),
   width=2000, height=1500, units="px", res=150, bg="transparent")
p1
dev.off()








p2 <- ggplot(DT)+
    geom_line( aes(wl, gsDerOne1,colour="gapDer1") , size=1.4, linetype = "solid", alpha=1.0)+
    geom_line( aes(wl, gsDerTwo1,colour="gapDer2") , size=0.4, linetype="F1", alpha=1.0)+
    scale_colour_manual("",
                    breaks = c("gapDer1", "gapDer2"),values = c("blue", "red"))+
    theme(legend.position = c(0.8, 0.9),
          legend.background = element_rect(size = 0.2,
                                           color = "black",
                                           fill = "grey90",
                                           linetype = "solid"))



tiff(filename= paste(tagname,"_p2.tiff",sep=''),
   width=2000, height=1500, units="px", res=150, bg="transparent")
p2
dev.off()









p3 <- ggplot(DT)+
    geom_line( aes(wl, DerOne1,colour="der_diff1") , size=1.4, linetype = "solid", alpha=1.0)+
    geom_line( aes(wl, gsDerOne1,colour="gapDer") , size=0.4, linetype="F1", alpha=1.0)+
    scale_colour_manual("",
                    breaks = c("der_diff1", "gapDer"),values = c("blue", "red"))+
    theme(legend.position = c(0.8, 0.9),
          legend.background = element_rect(size = 0.2,
                                           color = "black",
                                           fill = "grey90",
                                           linetype = "solid"))



tiff(filename= paste(tagname,"_p3.tiff",sep=''),
   width=2000, height=1500, units="px", res=150, bg="transparent")
p3
dev.off()





#
# ### manipulatepcolumns-by-their-name-pattern-in-r-data-table
# indx <- grep('gsDerOne', names(DT))
# for(k in indx){set(DT,DT[[k]])}
# #then shift for to lead/lag vectors and lists
#
#



#################
# Stop the clock!
end.time <- Sys.time()
end.time - start.time

################################################################################
setwd(r_scripts_path) ## go back to the r-script source path
