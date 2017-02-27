#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#
#
# FileName:           shift_data00.R
# FileDescription:
#                     Advanced tutorial on the use of data.table
#
# Reference:
#           hpps://brooksandrew.github.io/simpleblog/articles/advamced-data-table
#
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# Miguel P. Xochicale [http://mxochicale.github.io]
# Doctoral Researcher in Human-Robot Interaction
# University of Birmingham, U.K. (2014-2018)
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#
#
#

library('data.table') # for manipulating data



############################
# Using shift for  to lead/lag vectors and lists
dt <- data.table(mtcars)[,.(mpg,cyl,gear)]
dt[,mpg_lag10:=shift(mpg ,10)  ]
dt[,gear_lag15:=shift(gear ,15)  ]
dt[,mpg_forward5:=shift(mpg,5, type='lead')]
# head(dt)
