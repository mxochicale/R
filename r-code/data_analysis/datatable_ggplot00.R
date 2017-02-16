#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#
#
# FileName:           datatable_ggplot00.R
# FileDescription:
#                 Create data.table object and the data is ploted with ggplot
#
# Reference:
# http://stackoverflow.com/questions/41536406/
# how-to-apply-separate-coord-cartesian-to-zoom-in-into-individual-panels-of-a
#
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# Miguel P. Xochicale [http://mxochicale.github.io]
# Doctoral Researcher in Human-Robot Interaction
# University of Birmingham, U.K. (2014-2018)
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


library(data.table)
library(ggplot2)

mt <- ggplot(mtcars, aes(mpg, wt, colour=factor(cyl) )  ) +
      geom_point() +
      facet_grid(vs ~ am, scales = "free")
      # +
      # coord_cartesian(ylim=c(3,5))

mt
