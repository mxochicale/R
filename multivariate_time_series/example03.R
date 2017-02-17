# http://stackoverflow.com/questions/19059826/multiple-graphs-over-multiple-pages-using-ggplot
library(ggplot2)

ii <- 7
nn <- 49

mydf <- data.frame(date = rep(seq(as.Date('2013-03-01'),
                       by = 'day', length.out = ii), nn),
                   value = rep(runif(nn, 100, 200)))

mydf$facet.variable <- rep(1:nn, each = ii)

p <- ggplot(mydf, aes(x = date, y = value)) +
    geom_line() +
    facet_wrap(~ facet.variable, ncol = ii)

print(p)
