#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#
#
# FileName:     *.R
# Description:
# ExecutionTime: ~ 10.50 seconds
#
# NOTE:
#
#
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# Miguel P. Xochicale [http://mxochicale.github.io]
# Doctoral Researcher in Human-Robot Interaction
# University of Birmingham, U.K. (2014-2018)
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++



#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# Loading Functions and Libraries and Setting up digits
library(data.table) # for manipulating data
library(ggplot2)
library(signal)# for butterworth filter

library(scales)# centering
library(moments) #kurtosis and skewness
library(entropy)# entropy

options(digits=15)



#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# Defining paths for main_path, r_scripts_path, ..., etc.
# setwd("../")
r_scripts_path <- getwd()
main_data_path <- paste("/home/map479/mxochicale/github/DataSets/activity_recognition_accelerometer_dataset/data",sep="")
main_data_output_path <- paste("/home/map479/mxochicale/github/DataSets/activity_recognition_accelerometer_dataset/output",sep="")



# Setting DataSets paths
setwd(main_data_path)


################################################################################
################################################################################
## Setup and Preparation of Data


# Start the clock!
start.time <- Sys.time()


ts <- data.table()  #ts, data.table of time series
for (i in 1:15) {
     tmp <- fread(  paste0("", i, ".csv")  , header = FALSE, sep=',')
     tmp[, `:=`(id, factor(i)) ]
     ts <- rbindlist(list(ts, tmp), use.names = F)
}
# rename columns
names(ts) <- c("nseq", "ax", "ay", "az", "action", "id")



################################################################################
################################################################################
# # Before anything else, we should look a the raw data. Ggplot requires all facets
# # in a plot to have the same X axis, therefore we need to rearrange our data a bit;
# # for a typical 10 second frame time series we get:
#
# nsamples <- 500
# start.sample <- 250
# ts.plot <- data.table()
#
# # Activities 1 to 7 For particpant 11
#
#     # 1. Working at Computer
#     # 2. Standing Up, Walking and Going up/down stairs
#     # 3. Standing
#     # 4. Walking
#     # 5. Going Up/Down Stairs
#     # 6. Walking and Talking with Someone
#     # 7. Talking while Standing
#
#
# for (i in 1:7) {
#     tmp <- ts[id == "11" & action == as.character(i), ][start.sample:(start.sample +
#         nsamples - 1), ][, `:=`(nseq, 1:nsamples)]
#     ts.plot <- rbindlist(list(ts.plot, tmp), use.names = T)
# }
#
# ggplot(data = na.omit(ts.plot)) +
#   geom_line(aes(x = nseq, y = ax), color = "black", size = 1) +
#   geom_line(aes(x = nseq, y = ay), color = "blue1", size = 1) +
#   geom_line(aes(x = nseq, y = az), color = "red1", size = 1) +
#   facet_grid(action ~ ., scales = "free_y") +
#   labs(title = "Raw Data for X Y Z components",  x = "Samples", y = "") +
#   theme(axis.text.y = element_blank())



################################################################################
################################################################################
# While there are some obvious differences in the activity signals,
# there’s no big apparent trait in the time series that would allow us to
# differentiate them by eye easily. On to feature extraction then,
# first we will add two other time series, the magnitude of the acceleration
# and decomposition into principal components (PCA). Also We simplify the problem
# a bit by removing composite actions
# (Walking + Talking and Walking + Going up/down stairs)


# remove composite action and null action
ts <- ts[action != 0 & action != 2 & action != 6]
# make action and id into factors
ts[, `:=`(action, factor(action))]
ts[, `:=`(id, factor(id))]


# give meaningful level names
levels(ts$action) <- list(work = "1", stand = "3", walk = "4", climb = "5",  talk = "7")


## define more time series
ts[, `:=`(amag, sqrt(ax^2 + ay^2 + az^2))]  #accel magnitude
# principal components
pc <- prcomp(ts[, .(ax, ay, az)], center = T, scale. = T)
ts[, `:=`(pc1, pc$x[, 1])]
ts[, `:=`(pc2, pc$x[, 2])]
ts[, `:=`(pc3, pc$x[, 3])]



# Lowpass and highpass filtering
cutoffHZ <- 6
sampleHz <- 52
nyqHZ = sampleHz/2 #nyquist
f <- butter(9, cutoffHZ/nyqHZ)
#create lowfreq components
ts[,c('lax', 'lay', 'laz', 'lamag', 'lpc1', 'lpc2', 'lpc3') :=
       lapply(.(ax, ay, az, amag, pc1, pc2, pc3), function(x) (filtfilt(f, x)))]
#create hf components
ts[, hax := ax - lax]
ts[, hay := ay - lay]
ts[, haz := az - laz]
ts[, hamag := amag -lamag]
ts[, hpc1 := pc1 - lpc1]
ts[, hpc2 := pc2 - lpc2]
ts[, hpc3 := pc3 - lpc3]



setwd(main_data_output_path)
fwrite(ts, file='ts2')


# Stop the clock!
end.time <- Sys.time()
end.time - start.time


# ################################################################################
# ################################################################################
# # Plots the output of the previos preprocessing techniques such as
# # magnituding that components, dimensionality reduction, and filtering low and high frequencies
# #
# # Activities 1 to 7 For particpant 11
# nsamples <- 1000
# start.sample <- 250
# participantNN <- "11"
# ts.plot <- data.table()
#
#     # 1. Working at Computer
#     # 3. Standing
#     # 4. Walking
#     # 5. Going Up/Down Stairs
#     # 7. Talking while Standing
#
# actlab <- c("work", "stand", "walk", "climb", "talk")
#
# for (i in 1:5) {
#     tmp <- ts[id == participantNN  & action == actlab[i], ][start.sample:(start.sample + nsamples - 1), ][, `:=`(nseq, 1:nsamples)]
#     ts.plot <- rbindlist(list(ts.plot, tmp), use.names = T)
# }
#
#
# # ## PC
# # ggplot(data = na.omit(ts.plot)) +
# #   geom_line(aes(x = nseq, y = pc1), color = "black", size = 1) +
# #   geom_line(aes(x = nseq, y = pc2), color = "blue1", size = 1) +
# #   geom_line(aes(x = nseq, y = pc3), color = "red1", size = 1) +
# #   facet_grid(action ~ ., scales = "free_y") +
# #   labs(title = "components",  x = "Samples", y = "") +
# #   theme(axis.text.y = element_blank())
#
# # ## Low Frequencies
# # ggplot(data = na.omit(ts.plot)) +
# #   geom_line(aes(x = nseq, y = lax), color = "red", size = 1) +
# #   geom_line(aes(x = nseq, y = lay), color = "blue1", size = 1) +
# #   geom_line(aes(x = nseq, y = laz), color = "green1", size = 1) +
# #   facet_grid(action ~ ., scales = "free_y") +
# #   labs(title = "components",  x = "Samples", y = "") +
# #   theme(axis.text.y = element_blank())
#
#
# # ## Low Frequencies PC
# # ggplot(data = na.omit(ts.plot)) +
# #   geom_line(aes(x = nseq, y = lpc1), color = "black", size = 1) +
# #   geom_line(aes(x = nseq, y = lpc2), color = "blue1", size = 1) +
# #   geom_line(aes(x = nseq, y = lpc3), color = "red1", size = 1) +
# #   facet_grid(action ~ ., scales = "free_y") +
# #   labs(title = "components",  x = "Samples", y = "") +
# #   theme(axis.text.y = element_blank())
#
#
# # ## High Frequencies
# # ggplot(data = na.omit(ts.plot)) +
# #   geom_line(aes(x = nseq, y = hax), color = "red", size = 1) +
# #   geom_line(aes(x = nseq, y = hay), color = "blue1", size = 1) +
# #   geom_line(aes(x = nseq, y = haz), color = "green1", size = 1) +
# #   facet_grid(action ~ ., scales = "free_y") +
# #   labs(title = "components",  x = "Samples", y = "") +
# #   theme(axis.text.y = element_blank())
#
#
# # ## High Frequencies PC ["hpc1"   "hpc2"   "hpc3"]
# # ggplot(data = na.omit(ts.plot)) +
# #   geom_line(aes(x = nseq, y = hpc1), color = "black", size = 1) +
# #   geom_line(aes(x = nseq, y = hpc2), color = "blue1", size = 1) +
# #   geom_line(aes(x = nseq, y = hpc3), color = "red1", size = 1) +
# #   facet_grid(action ~ ., scales = "free_y") +
# #   labs(title = "components",  x = "Samples", y = "") +
# #   theme(axis.text.y = element_blank())
#
# # ## Magnitude
# # ggplot(data = na.omit(ts.plot)) +
# #   geom_line(aes(x = nseq, y = amag), color = "black", size = 1) +
# #   geom_line(aes(x = nseq, y = lamag), color = "blue1", size = 1) +
# #   geom_line(aes(x = nseq, y = hamag), color = "red1", size = 1) +
# #   facet_grid(action ~ ., scales = "free_y") +
# #   labs(title = "components",  x = "Samples", y = "") +
# #   theme(axis.text.y = element_blank())







#############################################
setwd(r_scripts_path) ## go back to the r-script source path
