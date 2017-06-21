animated_lorenz_system
---



```
$R
> source(paste(getwd(),"/animated_lorenz_system.R", sep=""), echo=TRUE)
q()
n
```


```
cd image_frames
convert -delay 5 -loop 0 frame*.png ../animated.gif
rm -rf image_frames
eog animated.gif
```







