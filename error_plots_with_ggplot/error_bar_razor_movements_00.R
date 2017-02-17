
#
#https://www.r-bloggers.com/textual-healing-part-ii/
#https://gist.github.com/cdesante/4070336
#https://gist.github.com/cdesante/4070537

library(ggplot2)


 text.plots.0 <- data.frame(
 SENSOR_AXIS = c (rep(c( 'Ax', 'Ay', 'Az' ), each = 18)) ,  # 54/3=24
 MOVEMENTS = rep(rep(c( 'Static', 'Horizontal', 'Vertical' ), each=6), 3), # (6*3= 18  )* 3 = 54
 LENGTH = c(   ### 9*6 =54
   rnorm(6, 1, 0.1), #Static Ax
   rnorm(6, 1, 0.1),#Horizontal Ax
   rnorm(6, 1, 0.1),#Vertical Az
   rnorm(6, 1, 0.1), #Static Ay
   rnorm(6, 1, 0.1),#Horizontal Ay
   rnorm(6, 1, 0.1), #Vertical Ay
   rnorm(6, 1, 0.1), #Static Az
   rnorm(6, 1, 0.1),#Horizontal Az
   rnorm(6, 10, 0.1)#Vertical Az
   ), #Vertical Az
 stringsAsFactors = FALSE
  )

Plot.0 <- ggplot( text.plots.0, aes( x = SENSOR_AXIS, y = LENGTH , fill = SENSOR_AXIS ) ) +
geom_boxplot(outlier.colour = c("grey40") , outlier.size=4) +
facet_wrap(~MOVEMENTS)+ geom_jitter(shape=21, position=position_jitter(0.2)) +
stat_summary(fun.y=mean, geom="point", shape=23, size=5)


text.plots.1 <- data.frame(
   SENSOR_AXIS = c (rep(c( 'Ax', 'Ay', 'Az', 'mag(A)' ), each = 18)),  #72*4 = 18
   MOVEMENTS = rep(rep(c( 'Static', 'Horizontal', 'Vertical' ), each=6), 4),
    MEAN = c(  #12*6=72
        rnorm(6, 1, 0.1), #Static Ax
        rnorm(6, 1, 0.1), #Horizontal Ax
        rnorm(6, 1, 0.1),#Vertical Ax
        rnorm(6, 1, 0.1), #Static Ay
        rnorm(6, 1, 0.1),#Horizontal Ay
        rnorm(6, 1, 0.1), #Vertical Ay
        rnorm(6, 1, 0.1), #Static Az
        rnorm(6, 1, 0.1), #Horizontal Az
        rnorm(6, 1, 0.1), #Vertical Az
        rnorm(6, 1, 0.1), #Static ¦A¦
        rnorm(6, 1, 0.1), #Horizontal ¦A¦
        rnorm(6, 2, 0.1)  #Vertical ¦A¦
        ),
      stringsAsFactors = FALSE
 )



Plot.1 <- ggplot( text.plots.1, aes( x = SENSOR_AXIS, y = MEAN , fill = SENSOR_AXIS ) ) +
  geom_boxplot(outlier.colour = c("grey40") , outlier.size=5) +
  facet_wrap(~MOVEMENTS)+ geom_jitter(shape=21, position=position_jitter(0.2)) +
  stat_summary(fun.y=mean, geom="point", shape=23, size=5)





text.plots.2 <- data.frame(
   SENSOR_AXIS = c (rep(c( 'Ax', 'Ay', 'Az', '¦A¦', 'Gx', 'Gy', 'Gz', '¦G¦' ), each = 18)),  #72*4 = 18
   MOVEMENTS = rep(rep(c( 'Static', 'Horizontal', 'Vertical' ), each=6), 8),
   MEAN = c(  #12*6=72
       rnorm(6, 1, 0.1), #Static Ax
       rnorm(6, 1, 0.1), #Horizontal Ax
       rnorm(6, 1, 0.1),#Vertical Ax
       rnorm(6, 1, 0.1), #Static Ay
       rnorm(6, 1, 0.1),#Horizontal Ay
       rnorm(6, 1, 0.1), #Vertical Ay
       rnorm(6, 1, 0.1), #Static Az
       rnorm(6, 1, 0.1), #Horizontal Az
       rnorm(6, 1, 0.1), #Vertical Az
       rnorm(6, 1, 0.1), #Static ¦A¦
       rnorm(6, 1, 0.1), #Horizontal ¦A¦
       rnorm(6, 1, 0.1),  #Vertical ¦A¦
       rnorm(6, 1, 0.1), #Static Gx
       rnorm(6, 1, 0.1), #Horizontal Gx
       rnorm(6, 1, 0.1),#Vertical Gx
       rnorm(6, 1, 0.1), #Static Gy
       rnorm(6, 1, 0.1),#Horizontal Gy
       rnorm(6, 1, 0.1), #Vertical Gy
       rnorm(6, 1, 0.1), #Static Gz
       rnorm(6, 1, 0.1), #Horizontal Gz
       rnorm(6, 1, 0.1), #Vertical Gz
       rnorm(6, 1, 0.1), #Static ¦G¦
       rnorm(6, 1, 0.1), #Horizontal ¦G¦
       rnorm(6, 10, 0.1) #Vertical ¦G¦
       ),
     stringsAsFactors = FALSE
)



#Reorder Factor:
text.plots.2$MOVEMENTS <- factor(text.plots.2$MOVEMENTS)
text.plots.2$MOVEMENTS <- factor(text.plots.2$MOVEMENTS, levels= levels(text.plots.2$MOVEMENTS)[c(2,1,3)])


text.plots.2$SENSOR_AXIS <- factor(text.plots.2$SENSOR_AXIS)
text.plots.2$SENSOR_AXIS <- factor(text.plots.2$SENSOR_AXIS, levels= levels(text.plots.2$SENSOR_AXIS)[c(2,3,4,1,6,7,8,5)])


Plot.2 <- ggplot( text.plots.2, aes( x = SENSOR_AXIS, y = MEAN , fill = SENSOR_AXIS ) ) +
  geom_boxplot(outlier.colour = c("grey40") , outlier.size=5) +
# scale_fill_manual(values=c("cadetblue", "orange", "orangered3", "blue","cadetblue", "orange", "orangered3", "blue2")) +
  facet_wrap(~MOVEMENTS)+ geom_jitter(shape=21, position=position_jitter(0.2)) +
  stat_summary(fun.y=mean, geom="point", shape=23, size=5) +
  theme(strip.text.x = element_text(size=16, face="bold") , strip.background = element_rect(fill="yellow1"))



  ###18 rows of data
  ### 18*6 =108
  ### 108/6=18
  ### 108/3=36
  ### 36/6=6






   text.plots.3 <- data.frame(
   SENSOR_AXIS = c (rep(c( 'Ax', 'Ay', 'Az' ), each = 36)) , #XX/3=
   MOVEMENTS = rep(rep(c( 'Static', 'Horizontal', 'Vertical', 'Diagonal','Circular','8-Shape'), each=6), 3), #*6*3=
   MEAN = c(   ### 18*6=108
     rnorm(6, 1, 0.1),#Ax
     rnorm(6, 1, 0.1),
     rnorm(6, 1, 0.1),
     rnorm(6, 1, 0.1),
     rnorm(6, 1, 0.1),
     rnorm(6, 1, 0.1),
     rnorm(6, 1, 0.1),#Ay
     rnorm(6, 1, 0.1),
     rnorm(6, 1, 0.1),
     rnorm(6, 1, 0.1),
     rnorm(6, 1, 0.1),
     rnorm(6, 1, 0.1),
     rnorm(6, 2, 0.5),#Az
     rnorm(6, 1, 0.1),
     rnorm(6, 1, 0.1),
     rnorm(6, 1, 0.1),
     rnorm(6, 1, 0.1),
     rnorm(6, 1, 0.1)
     ), #Vertical Az
   stringsAsFactors = FALSE
    )

#Reorder Factor:
text.plots.3$MOVEMENTS <- factor(text.plots.3$MOVEMENTS)
text.plots.3$MOVEMENTS <- factor(text.plots.3$MOVEMENTS, levels= levels(text.plots.3$MOVEMENTS)[c(5,4,6,3,2,1)])

  Plot.3 <- ggplot( text.plots.3, aes( x = SENSOR_AXIS, y = MEAN , fill = SENSOR_AXIS ) ) +
  geom_boxplot(outlier.colour = c("grey40") , outlier.size=4) +
  facet_grid(.~MOVEMENTS, scales="free")+ geom_jitter(shape = 16, position = position_jitter(0.2), alpha = .5) +
  stat_summary(fun.y = mean, geom = "point", shape = 23, size = 4, fill = "blue")
