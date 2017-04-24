3D plots
-------

## Install packages:
```
.packages <- ("rgl")
lapply(.packages, install.packages, dependencies = TRUE, repos='https://www.stats.bris.ac.uk/R/')
```

```
.packages <- c('car', 'scatterplot3d', 'plot3D')
lapply(.packages, install.packages, dependencies = TRUE, repos='https://www.stats.bris.ac.uk/R/')
```




## .Rhistory
```
source(paste(getwd(),"/scatterplot3d.R", sep=""), echo=FALSE)
source(paste(getwd(),"/plot3D.R", sep=""), echo=FALSE)
source(paste(getwd(),"/Aa_scatter3d.R", sep=""), echo=FALSE)
source(paste(getwd(),"/Ab_scatter3d.R", sep=""), echo=FALSE)
source(paste(getwd(),"/Ac_scatter3d.R", sep=""), echo=FALSE)
```





# Sources

* Presentation with images   
http://pj.freefaculty.org/guides/Rcourse/plot-3d/plots-3d.pdf

* web-page presentation
https://stanford.edu/class/cme195/lectures/Lecture5.html#/section-5

* http://www.sthda.com/english/wiki/amazing-interactive-3d-scatter-plots-r-software-and-data-visualization  

* http://www.sthda.com/english/wiki/impressive-package-for-3d-and-4d-graph-r-software-and-data-visualization  

* https://casoilresource.lawr.ucdavis.edu/software/r-advanced-statistical-package/interactive-3d-plots-rgl-package    

* [ ] http://www.statmethods.net/graphs/scatterplot.html  
