# R code for remote sensing data analysis in ecosystem monitoring

library(raster)
library(RStoolbox)

setwd("C:\Users\salde\Desktop\UNIBO\Didattica II\Monitoring\lab") ##change orientation of the "/" symbol


p224r63_2011 <- brick("p224r63_2011_masked.grd")
