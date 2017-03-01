
# http://rug.mnhn.fr/seewave/



library(seewave)
library(tuneR)

#
# mic<-readWave("micsample.wav")
# Wave Object
# 	Number of Samples:      1536000
# 	Duration (seconds):     32
# 	Samplingrate (Hertz):   48000
# 	Channels (Mono/Stereo): Mono
# 	PCM (integer format):   TRUE
# 	Bit (8/16/24/32/64):    16


mic<-readWave("micsample.wav", from=80000,to=1000000)
# oscillo(mic, f=48000)
mic2 <- smoothw(mic, wl=10, out="Wave")
oscillo(mic2, f=48000)
# spectro(mic, f=48000, ovlp=50, zp=16, collevels=seq(-40,0,0.5))
# spectro(mic,f=48000, wl=512, ovlp=75, osc=TRUE)
