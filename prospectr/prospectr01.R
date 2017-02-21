#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#
#
# FileName:           prospectr.R
# FileDescription:
#
#
# Reference:
#          # antonioestevens.github.io/prospectr
#
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# Miguel P. Xochicale [http://mxochicale.github.io]
# Doctoral Researcher in Human-Robot Interaction
# University of Birmingham, U.K. (2014-2018)
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


# dt <- as.data.frame.list(NIRsoil)
# setDT(dt)


library(ggplot2)
library(prospectr)
library(data.table)
library(signal)

data(NIRsoil)
str(NIRsoil)


sgp <- sgolay(p=1,n=13 ,m=0)

dt <- NULL
tmp <- NIRsoil$spc
# + rnorm( length(NIRsoil$spc),0,0.001 )

dt <- data.table(
           wavelenght = as.numeric( colnames( NIRsoil$spc )),
           spc1 = as.numeric(tmp[1,])
        )
dt[,noisy:=(spc1 + rnorm( length(spc1) ,0,0.005 ) )]


dt[,movav:=movav(noisy, w=11) ]
dt[,sg1:= savitzkyGolay(noisy, p=3,w=11,m=0) ]
dt[,sg2:= filter(sgp, noisy) ]



#note that the first and last bands are lost in the process

#
#
#
#
#
#

# Ploting the result
p <- ggplot(dt)+
     geom_line(aes(wavelenght,spc1) , size=1)+
     geom_line(aes(wavelenght,noisy), linetype="F1", size=0.2, alpha=0.5)+
     geom_line(aes(wavelenght,movav), col="red2", size=1)+
     geom_line(aes(wavelenght,sg1), col="red2", size=1)
    #  geom_line(aes(wavelenght,sg2), col="red2", size=1)
#     ylab("y")+
#     theme_bw()

 print(p)
