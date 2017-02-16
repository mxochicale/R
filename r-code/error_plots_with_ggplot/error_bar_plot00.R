

#multiple arranged error bar plot
#http://rgraphgallery.blogspot.co.uk/2013/04/rg7-multiple-arranged-error-bar-plot.html


 library(ggplot2)


# multiple arranged error bar plot (trallis type)
#data
env <- c(rep("E1", 9), rep("E2", 9))
trt <- c(rep (c("A101", "B234", "c777"), each = 3))
group <- c(rep (1:3, 6))
yld <- c(3,4,6, 3,8,4, 1,2,6, 3,4,5, 6,7,7, 1,4,8)
se <- c(0.3, 0.6, 0.3, 0.6, 0.1, 0.9, 0.21, 0.4,w
   0.5, 0.2, 0.1, 0.3, 0.4, 0.2, 0.3, 0.4, 0.4, 0.3)
dataf <- data.frame (env, trt, group, yld, se)
limits <- aes(ymax = yld + se, ymin=yld - se)


plt1 <- ggplot(dataf, aes(fill=factor(group), y=yld, x=trt))
plt1 + geom_bar(position= position_dodge(width=0.9)) +
geom_errorbar(limits, position= position_dodge(width=0.9), width=0.8) + theme_bw( ) +
facet_grid(.~env)
