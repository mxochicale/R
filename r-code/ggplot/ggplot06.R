#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#
#
# FileName:           plotly06.R
# FileDescription:
#
#
# Reference:
#           docs.ggplot2.org/current/aes_group_order.html
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

# For most applications you can simply specify the grouping with
# various aesthetics (colour, shape, fill, linetype) or with facets.

##the colour aesthetic
ggplot(mtcars, aes(wt,mpg))+
geom_point( aes(colour=factor(cyl)),size=4 )

## shape to distinguish the data
ggplot(mtcars, aes(wt,mpg))+
geom_point( aes(shape=factor(cyl)),size=4 )

# Using fill
ggplot(mtcars, aes( factor(cyl) ))+
geom_bar( aes( fill=factor(cyl) )  )+
geom_bar( aes( fill=factor(vs) )  )
