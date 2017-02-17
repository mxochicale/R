
#
#https://www.r-bloggers.com/textual-healing-part-ii/
#https://gist.github.com/cdesante/4070336
#https://gist.github.com/cdesante/4070537

library(ggplot2)


# FOR ACC AND GYR

number_of_participants <- 12
dataframe1 <- data.frame(
SENSOR_AXIS = c(    rep(   c( 'Ax', 'Ay', 'Az', 'Gx', 'Gy', 'Gz'), each =      (number_of_participants)      )  ),  # 6*each =
CLASSES =  rep(   rep(c( 'acc', 'gyr' ),                           each = 3*   (number_of_participants)  ), 1),
VALUES = c( rnorm(number_of_participants, 1.25, 0.1), #AX
            rnorm(number_of_participants, 1, 0.01), #AY
            rnorm(number_of_participants, 1, 0.01), #AZ
            rnorm(number_of_participants, 1, 0.01), #GX
            rnorm(number_of_participants, 1, 0.01), #GY
            rnorm(number_of_participants, 1, 0.01) #GZ
          ),
stringsAsFactors = FALSE
)
dataframe1

Plot <- ggplot( dataframe1, aes( x = SENSOR_AXIS, y = VALUES , fill = CLASSES ) ) +
geom_boxplot(outlier.colour = c("grey40") , outlier.size=5) +
geom_jitter(shape=21, position=position_jitter(0.1)) +
stat_summary(fun.y=mean, geom="point", shape=23, size=5) +
ggtitle("Robot") +
xlab("My x label") +
ylab("Variable") +
theme(
    plot.title = element_text(size = 40, face = "plain"),
    axis.text.x = element_text(colour="grey20",size=35,angle=00,hjust=.5,vjust=.5,face="plain"),
    axis.text.y = element_text(colour="grey20",size=12,angle=0,hjust=1,vjust=0,face="plain"),
    axis.title.x=element_blank(),
    axis.title.y = element_text(colour="grey20",size=35,angle=90,hjust=.5,vjust=.5,face="plain"),
    legend.position = "none"
    ) +
coord_cartesian(xlim = c(1, 6),ylim = c(0.5, 1.5))

Plot
# ggsave(file="creating_dataframe00.png")
