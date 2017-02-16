df <- data.frame(dose=c("D0.5", "D1", "D2"),
                 len=c(4.2, 10, 29.5))

head(df)


library(ggplot2)
# Basic barplot
p <- ggplot(data=df, aes(x=dose, y=len)) + geom_bar(stat="identity")
p

# Horizontal bar plot
p + coord_flip()


# Minimal theme + blue fill color
p<-ggplot(data=df, aes(x=dose, y=len)) +
  geom_bar(stat="identity", fill="steelblue")+
  theme_minimal()
p


title <- "Scree plot"
xlab <- "Dimensions"
ylab <- "Percentage of explained variances"

# Inside bars
ggplot(data=df, aes(x=dose, y=len)) +
  geom_bar(stat="identity", fill="steelblue")+
  geom_text(aes(label=len), vjust=1.6, color="black", size=10)+
  geom_line()+
  geom_point(colour = "red", size = 5)+ 
  labs(title = title, x = xlab, y = ylab)

#  theme_minimal()



# # Basic line plot with points
# ggplot(data=df, aes(x=dose, y=len, group=1)) +
#   geom_line()+
#   geom_point()
  