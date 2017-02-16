

library(ggplot2)

#reference
#http://www.sthda.com/english/wiki/factoextra-r-package-quick-multivariate-data-analysis-pca-ca-mca-and-visualization-r-software-and-data-mining
#https://github.com/kassambara/factoextra/blob/300c11e285cd75835b6e6340f578dddee470753a/R/eigenvalue.R


df <- data.frame(
  dose=c("D0.5", "D1", "D2"),
  len=c(29.435124355,10.6576,0.22341324)
  )

head(df)

text_labels <- paste0(  round(df[,2],1), "%")

title <- "Scree plot"
xlab <- "Dimensions"
ylab <- "Percentage of variances"

# Inside bars
ggplot(data=df, aes(x=dose, y=len, group=1)) +
  geom_bar(stat="identity", fill="steelblue")+
  geom_text(aes(label= text_labels), vjust=-0.5, color="black", size=10)+
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
  ylim(c(0,50))



  