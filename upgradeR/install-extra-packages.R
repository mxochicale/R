
mirror_repo <- 'https://www.stats.bris.ac.uk/R/'


### for heatmaps
install.packages("gplots", drepos=mirror_repo, dependencies = TRUE)


### latex2exp
install.packages("latex2exp", repos=mirror_repo, dependencies = TRUE)


### tseriesChaos
install.packages("tseriesChaos", repos=mirror_repo, dependencies = TRUE)
# if (!require("tseriesChaos")) install.packages("tseriesChaos", repos=mirror_repo)


#### Interpolation of Irregular and Regularly Spaced Data
install.packages("akima", repos=mirror_repo, dependencies = TRUE)



### rgl
### It takes a while of time for the installation, perhaps 5 min.

.packages <- ("rgl")
lapply(.packages, install.packages, dependencies = TRUE, repos=mirror_repo)



### pals: Color Palettes, Colormaps, and Tools to Evaluate Them
install.packages("pals", repos=mirror_repo, dependencies = TRUE)


### latice
install.packages("lattice", repos=mirror_repo, dependencies = TRUE)
# if (!require("lattice")) install.packages("lattice", repos=mirror_repo)  ##xyplot


### latticeExtra
install.packages("latticeExtra", repos=mirror_repo, dependencies = TRUE)
# if (!require("latticeExtra")) install.packages("latticeExtra", repos=mirror_repo)   ##overlay xyplots a + as.layer(b)


#### [prospectr](https://github.com/antoinestevens/prospectr)
devtools::install_github("prospectr", "antoinestevens")




### 'quantmod' wrapper to load data from different sources
install.packages("quantmod", repos=mirror_repo, dependencies = TRUE)

### 'plyr' tools for splitting, appliying and combining data
install.packages("plyr", repos=mirror_repo, dependencies = TRUE)



### 'fNonlinear' tools
install.packages("fNonlinear", repos=mirror_repo, dependencies = TRUE)


### 'nonlinearTseries' tools for nonlinear time series analysis
install.packages("nonlinearTseries", repos=mirror_repo, dependencies = TRUE)





install.packages("matrixStats", repos=mirror_repo, dependencies = TRUE)
install.packages("reshape", repos=mirror_repo, dependencies = TRUE)
install.packages("lubridate", repos=mirror_repo, dependencies = TRUE) # for working with date/times
install.packages("dplyr", repos=mirror_repo, dependencies = TRUE) # for manipulating data
install.packages("tidyr", repos=mirror_repo, dependencies = TRUE) # for tydying data
install.packages("plotly", repos=mirror_repo, dependencies = TRUE) # for beuatiful ploting
#Hadley Wickham
install.packages("zoo", repos=mirror_repo, dependencies = TRUE) # for databases
install.packages("plyr", repos=mirror_repo, dependencies = TRUE) # for databases



install.packages("gplots", repos=mirror_repo, dependencies = TRUE) #for heatmaps
install.packages("RColorBrewer", repos=mirror_repo, dependencies = TRUE)
install.packages("scatterplot3d", repos=mirror_repo, dependencies = TRUE)
install.packages("latticeExtra", repos=mirror_repo, dependencies = TRUE)

install.packages('fractal', repos=mirror_repo, dependencies = TRUE)

install.packages("ROCR", repos=mirror_repo, dependencies = TRUE) #visualizing classifier performance
install.packages("pROC", repos=mirror_repo, dependencies = TRUE) #Display and Analyze ROC Curves


