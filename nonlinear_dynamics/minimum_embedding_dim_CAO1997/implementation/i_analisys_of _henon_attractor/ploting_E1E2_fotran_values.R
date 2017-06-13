library(lattice) ##xyplot

data <- NULL;

setwd(getwd()); # set and get the current working directory
E1<-read.csv('E1_f_N1000.dat', sep='', header=FALSE);
E2<-read.csv('E2_f_N1000.dat', sep='', header=FALSE);
#If sep = "" (the default for read.table) the separator is ‘white space’, 
#that is one or more spaces, tabs, newlines or carriage returns.

data$samples <- E1[,1];
data$E1 <- E1[,2];
data$E2 <- E2[,2];



png(filename="plote1e2values.png", height=700, width=1200,bg="white") 
xyplot( data$E1 + data$E2  ~ data$samples,
        pch=1:2, # control the plot characters
        cex=3, # control the characther expansion for characters
        col= c('red', 'blue'), #col: Control the colors of symbols
        
        col.line = c('red', 'blue'), type = "b", 
        lty=1, lwd=3, # control line type and the line width
        main=list(label="", cex=2.5), #Control the character expansion ratio (cex)
        xlab=list(label="Dimension",  font=2, cex=2),
        ylab=list(label="E1 & E2",  font=2, cex=2),
        scales=list(font=2, cex=1.5),# size of the number labels from the x-y axes
        
        ## LABELS
         key=list(
           text = list(c("E1", "E2")), 
           lines = list(pch=1:2, col= c('red', 'blue')), type="b",
           cex=2, # control the character expansion  of the symbols
           corner=c(0.95,0.05) # position
         ),
          
        grid=TRUE
) 
dev.off() # Turn off device driver (to flush output to PNG)





