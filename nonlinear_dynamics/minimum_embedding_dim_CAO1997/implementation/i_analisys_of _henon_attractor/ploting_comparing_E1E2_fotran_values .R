library(lattice) ##xyplot

data <- NULL;

setwd(getwd()); # set and get the current working directory
E1_N1000 <-read.csv('E1_f_N1000.dat', sep='', header=FALSE);
E2_N1000 <-read.csv('E2_f_N1000.dat', sep='', header=FALSE);
E1_N10000 <-read.csv('E1_f_N10000.dat', sep='', header=FALSE);
E2_N10000 <-read.csv('E2_f_N10000.dat', sep='', header=FALSE);
#If sep = "" (the default for read.table) the separator is ‘white space’, 
#that is one or more spaces, tabs, newlines or carriage returns.

data$samples <- E1_N1000[,1];
data$E1_N1000 <- E1_N1000[,2];
data$E2_N1000 <- E2_N1000[,2];
data$E1_N10000 <- E1_N10000[,2];
data$E2_N10000 <- E2_N10000[,2];


 png(filename="plote1e2values.png", height=700, width=1200,bg="white")
 
xyplot(data$E1_N1000 + data$E2_N1000 +data$E1_N10000 +data$E2_N10000  ~ data$samples, 
       type = "b", lwd=3,
       pch=1:4, # control the plot characters
       cex=3, # control the characther expansion for characters
       col= c('red', 'blue'), #col: Control the colors of symbols
       
       main=list(label="", cex=2.5), #Control the character expansion ratio (cex)
       xlab=list(label="Dimension",  font=2, cex=2),
       ylab=list(label="E1 & E2",  font=2, cex=2),
       scales=list(font=2, cex=1.5),# size of the number labels from the x-y axes
     
     ## LABELS
     key=list(
       text = list(c("E1-1T", "E1-10T", "E2-1T","E2-10T")), 
       lines = list(pch=c(1,3,2,4), col= c('red','red','blue','blue')), type="b",
       cex=2, # control the character expansion  of the symbols
       corner=c(0.95,0.05) # position
     )
     
     )

 dev.off() # Turn off device driver (to flush output to PNG)


