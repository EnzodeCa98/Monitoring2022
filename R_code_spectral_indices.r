# Calculating vegetation indices from remote sensing

library(raster)
library(Rstoolbox)

setwd(C:/Users/salde/Desktop/UNIBO/Didattica II/Monitoring/lab)
setwd(C:/Users/salde/Desktop/UNIBO/Didattica II/Monitoring/lab)

# Exercise: import the first file -> defor1.png -> give it the name l1992
l1992 <- brick("defor1.png")

plotRGB(l1992, r=1, g=2, b=3, stretch="lin")

# layer 1 = NIR
# layer 2 = red
# layer 3 = green

# Exercise: import the second file -> defor2_.jpg -> give it the name l2006
l2006 <- brick("defor2.png")
l2006

plotRGB(l2006, r=1, g=2, b=3, stretch="lin")

# Exercise: plot in a multiframe the two images with one on top of the other
par(mfrow=c(2,1))
plotRGB(l1992, r=1, g=2, b=3, stretch="lin")
plotRGB(l2006, r=1, g=2, b=3, stretch="lin")

# DVI Difference Vegetation Index
dvi1992 = l1992[[1]] - l1992[[2]]
plot(dvi1992)
cl <- colorRampPalette(c('darkblue','yellow','red','black'))(100) # specifying a color scheme
plot(dvi1992, col=cl)

# DVI Difference Vegetation Index
dvi2006 <- l2006[[1]] - l2006[[2]]
dvi2006

plot(dvi2006, col=cl)
par(mfrow(c(2,1))
dvi1992
dvi2006

## how to put a treshold after which the trees have been cut 
# software is going to make a classification (forest/ bare soil)
 # with approximation
 
 library(ggplot2)
 library(RStoolbox) #classification
 # install.packages("patchwork")
library(patchwork) # for grid.arrange plotting

d1c <- unsuperClass(l1992,nClasses = 2)
plot(d1c$map)

freq(d1c$map) #frequency of classes
#class 1: human impact
#class 2: forest

#forest
f1992 <- 308213 / (308213 + 33079)
# human impact
h1992 <- 33079/ (308213 + 33079)
f1992 # 90% was covered by forest
h1992 # 10% was covered by human cultures

d2c <- unsuperClass(l2006, nClasses =2)
plot(d2c$map)

# 2006
# class2 : forest
#class 1: human impact

#frequency of classes
freq(d2c$map)

freq(d2c$map)
# value  count
# [1,]     1 164636
# [2,]     2 178090

#forest proportion in 2006
f2006 <- 178090 / (178090+164636)
h2006 <- 164636/ (178090+164636)
f2006 # 52% of forest
h2006 # 48% of human impact
