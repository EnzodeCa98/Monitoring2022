# R code for remote sensing data analysis in ecosystem monitoring

library(raster)
library(RStoolbox)

setwd("C:\Users\salde\Desktop\UNIBO\Didattica II\Monitoring\lab") ##change orientation of the "/" symbol


p224r63_2011 <- brick("p224r63_2011_masked.grd")
plot(p224r63_2011)
cl <- colorRampPalette(c("black","grey","light grey")) (100) 
plot(p224r63_2011,col = cl)

## solution 1 to select only one band  of light with the color we want to see
plot(p224r63_2011$B1sre, col = cl) ## in order to select only the one band of color we want to see)

## solution 2, if we know one element present in the data
plot(p224r63_2011[[1]], col =cl)

## exercise1: change colorRamppalette with colours from dark blue to light blue

clv <- colorRampPalette(c("deepskyblue4", "deepskyblue2", "darkslategray2")) (100)
plot(p224r63_2011,col = clv)
plot(p224r63_2011[[1]], col =clv)

par(mfrow = c(1,2)) ## multiframe 
plot(p224r63_2011[[1]], col =clv) ##blue band
plot(p224r63_2011[[2]], col =clv) ## green band

## exercise2: put a multiframe with 4 bands, 2X2 images

par(mfrow = c(2,2)) ## multiframe 
plot(p224r63_2011[[1]], col =clv) ##blue band
plot(p224r63_2011[[2]], col =clv) ## green band
plot(p224r63_2011[[3]], col =clv) ## red band
plot(p224r63_2011[[4]], col =clv) ## 
