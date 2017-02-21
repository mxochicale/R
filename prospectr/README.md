prospectr
===========


#### prospectr00.R
It follow the tutorial at antonioestevens.github.io/prospectr


#### prospectr01.R
```
ggplot()
dt[,movav:=movav(noisy, w=11) ]
dt[,sg1:= savitzkyGolay(noisy, p=3,w=11,m=0) ]
dt[,sg2:= filter(sgp, noisy) ]
```
