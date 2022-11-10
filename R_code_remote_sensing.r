# R code for remote sensing data analysis in ecosystem monitoring

library(raster)
library(RStoolbox)

setwd("C:\Users\salde\Desktop\UNIBO\Didattica II\Monitoring\lab") ##change orientation of the "/" symbol


p224r63_2011 <- brick("p224r63_2011_masked.grd")
plot(p224r63_2011)
cl <- colorRampPalette(c("black","grey","light grey")) (100) 
plot(p224r63_2011,col = cl)
