#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#
#
# FileName:           plotly11.R
# FileDescription:
#
#
# Reference:
#          # wresch.github.io/2014/05/22/aligning-ggplo2-graphs.html
#          # stackoverflow.com/questions/31630045/understanding-boxplot-with-jitter
#
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# Miguel P. Xochicale [http://mxochicale.github.io]
# Doctoral Researcher in Human-Robot Interaction
# University of Birmingham, U.K. (2014-2018)
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#
#
#

library(ggplot2)
library(gtable)
library(grid)
library(data.table)


# Synthetic DataTable
mv <- sqrt( c(25, runif(7,2.5,3.5), runif(4,0,1)))
mn <- length(mv)
ms <- letters[1:mn]

dt <- NULL
for (i in 1:20){
  dt <- rbind(dt, data.table( sample=ms, val=(mv+ rnorm(mn,0,0.1*mv) ) ) )
}
summary(dt)


#BoxPlot V0
# p.box <- ggplot(dt)+
#   geom_boxplot( aes(sample, val, fill=sample) )+
#   geom_jitter(aes(sample, val, fill=sample),
#               position=position_jitter(width=0.1, height=0),
#               color="blue",
#               alpha=0.2,
#               size=2
#                 )+
#   scale_fill_brewer(palette="Set3")+
#   labs(x= "Sample", y="Measure")+
#   theme_bw(15)+
#   theme(panel.grid.minor= element_blank(),
#         panel.border=element_rect(color="black"),
#         legend.position="none")


#BoxPlot V1
p.box <-  ggplot(dt, aes(x=sample, y=val) )+
          geom_point(aes(fill=sample),
                    alpha=0.8,
                    size=4,
                    shape=21,
                    position=position_jitter(width=0.15, height=0)  )+
         geom_boxplot(lwd=1,outlier.colour=NA, fill=NA)+
        labs(x= "Sample", y="Measure")+
         theme_bw(15)+
         theme(panel.grid.minor= element_blank(),
               panel.border=element_rect(color="black"),
               legend.position="none")




tiff("jittering.tiff", height=1000, width=2000, units="px", res=200)
print(p.box)
dev.off()
