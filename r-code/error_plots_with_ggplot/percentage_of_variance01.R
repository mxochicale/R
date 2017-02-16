

library(ggplot2)

#reference
#http://www.sthda.com/english/wiki/factoextra-r-package-quick-multivariate-data-analysis-pca-ca-mca-and-visualization-r-software-and-data-mining
#https://github.com/kassambara/factoextra/blob/300c11e285cd75835b6e6340f578dddee470753a/R/eigenvalue.R
#http://promberger.info/linux/2011/08/08/ggplot2-error-invalid-argument-to-unary-operator/

pcamatrix5 = c(49.87622171,33.36103430,12.98604726,3.21063567,0.13242853,0.12332224,0.08479032,0.08249784,0.07568904,0.06733309)

maxdim <- length(pcamatrix5)
df.eig <- data.frame(dim = factor(1:maxdim), eig=pcamatrix5  )


text_labels <- paste0(  round(df.eig[,2],1), "%")

xlab <- "Dimensions"
ylab <- "Percentage of variances"



# Inside bars
ggplot(data=df.eig, aes(dim, eig, group=1)) +
  geom_bar(stat="identity", fill="steelblue")+
  geom_text(aes(label= text_labels), vjust=-0.5, color="black", size=7)+
  geom_line()+
  geom_point(colour = "black", size = 5)+ 
  labs(x = xlab, y = ylab, size=10) + 
   theme(axis.text=element_text(color="black",size=15),
     axis.title = element_text(family = "Trebuchet MS", color="#666666", face="bold", size=25),
         panel.background = element_rect(fill = "white",
                                         colour = "white",
                                         size = 0.5, linetype = "solid"),
         panel.grid.major = element_line(size = 0.5, linetype = 'solid',
                                         colour = "gray"),
         panel.grid.minor = element_line(size = 0.25, linetype = 'solid',
                                         colour = "gray")
         )+
  coord_cartesian(xlim=c(0.1,maxdim+1),ylim=c(0,70))



  