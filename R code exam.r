## R project for Monitoring Ecosystem Changes and Functioning Exam ##


## let's install necessary packages

install.packages("raster")      # to import files in R, and for modeling spatial data
install.packages("ncdf4")       # to open Copernicus data with nc extention
install.packages("ggplot2")     # to plot data with ggplot function
install.packages("patchwork")   # to plot together various plots
install.packages("viridis")     # viridis palette for plots, it allows colorblind people to appreciate every color shade
install.packages("ggpubr")      #To export ggplots
install.packages("RStoolbox")   # for remote sensing processing and analysis


## let's recall the packages

library(raster)
library(ncdf4)
library(ggplot2)
library(patchwork)
library(viridis)
library(RStoolbox)
library(ggpubr)


## let's set the working directory
setwd("C:/Users/salde/Desktop/Monitoring Project")

## the aim of this project it is showing the difference in extent and greenness of vegetation,
 # in the island of Borneo, divided among Malaysia, Brunei and Indonesia between 2014, 2018 and 2022
## Borneo is famous for its iconic endemic species, above all Borneo Orangutan and Borneo pigmy elephant, but it is threatened by high deforestation rates,
 # due to palm oil intensive cultivation
   # it would be interesting looking how vegetation changed in the past 8 years


## Copernicus data with a resolution of 300m x300m per pixel
 ##data on https://land.copernicus.vgt.vito.be/PDF/portal/Application.html#Home

## in order to examine the spatial extent of vegetation, FCOVER data are needed
 # FCOVER: Fraction of green Vegetation Cover

#Having many files presenting the FCOVER pattern, it's easier to import them as a list
fcoverlist <- list.files(pattern ="FCOVER300")
fcoverlist # 3 images of global FCOVER for the years 2014, 2018,2022

## having a list, we can apply the raster function directly on it, instead of each of the files
fcover_rast <- lapply(fcoverlist, raster)
fcover_rast

##let's create a stack, concatenating the images as a single one
fcover_stack <- stack(fcover_rast)
fcover_stack

plot(fcover_stack)
## $ symbol to select one of the images, through it's name

 #Being the name "Fraction.of.green.Vegetation.Cover.333m.1/2/3 too long, renaming them could be useful
names(fcover_stack) <- c("fcover.300.1","fcover.300.2", "fcover.300.3")

FCOVER2014 <- fcover_stack$fcover.300.1
FCOVER2018 <- fcover_stack$fcover.300.2
FCOVER2022 <- fcover_stack$fcover.300.3


## time to crop the plot surrounding Borneo island, inserting its coordinates
ext <- c(108.7196, 119.3383,-4.2573, 7.1279)

Borneo2014 <- crop(FCOVER2014, ext)
plot(Borneo2014, main = "Borneo FCOVER 2014")

Borneo2018 <- crop(FCOVER2018, ext)
plot(Borneo2018, main = "Borneo FCOVER 2018")

Borneo2022 <- crop(FCOVER2022, ext)
plot(Borneo2022, main = "Borneo FCOVER 2022")

##let's export them in PNG, through png and dev.off
png("Borneo_FCOVER_years.png", width = 1800, height = 1500, res = 300)
par(mfrow = c(1,3))
plot(Borneo2014, main = "Borneo FCOVER 2014")
plot(Borneo2018, main = "Borneo FCOVER 2018")
plot(Borneo2022, main = "Borneo FCOVER 2018")
dev.off()


##let's plot them through ggplot
 # using viridis color scale, colors can be seen by colorblind people

Green2014 <-ggplot()+
  geom_raster(Borneo2014, mapping= aes(x=x,y=y, fill= fcover.300.1))+
  scale_fill_viridis() + ggtitle(" Borneo FCOVER in 2014")

Green2018 <-ggplot()+
  geom_raster(Borneo2018, mapping= aes(x=x,y=y, fill= fcover.300.2))+
  scale_fill_viridis() + ggtitle("Borneo FCOVER in 2018")

Green2022 <-ggplot()+
  geom_raster(Borneo2022, mapping= aes(x=x,y=y, fill= fcover.300.3))+
  scale_fill_viridis() + ggtitle(" Borneo FCOVER in 2022")

#let's export the plots obtained with ggplot

ggexport(Green2014, filename = "Borneo2014_ggplot.png", width = 1800, height = 1500, res = 300)
ggexport(Green2018, filename = "Borneo2018_ggplot.png", width = 1800, height = 1500, res = 300)
ggexport(Green2022, filename = "Borneo2022_ggplot.png", width = 1800, height = 1500, res = 300)

# let's show all the plots together

# horizontally
Green2014 + Green2018 + Green2022
# vertically
Green2014/Green2018/Green2022
# horizontally could be better, let's export it
FCOVER_horizon <- Green2014 + Green2018 + Green2022
ggexport(FCOVER_horizon, filename = "FCOVER_horizon_comparison.png", width = 3000, height= 1000, res = 300)

## It would be interesting noticing the difference in FCOVER in one plot, let's try
 # The difference between 2022 and 2018 should be more evident, data in those year were more consistent

FCOVER_diff <- (Borneo2022 - Borneo2018)
plot(FCOVER_diff)

##changing the color would be useful to understand better the shift
 # red meaning deforestation, grey meaning no substantial changes, green meaning more forest cover
cldif = colorRampPalette(c("red", "snow3", "springgreen4")) (100)
plot(FCOVER_diff, col =cldif, main = "FCOVER difference 2022-2018")

#let's export the FCOVER difference
png("FCOVER_diff.png", width = 2500, height = 2500, res = 300)
plot(FCOVER_diff, col =cldif, main = "FCOVER difference 2022-2018")
dev.off()

## situation on the coast seem to be critical, the size of the island makes difficult to appreciate it
 # let's crop the most interesting areas
SW <- c(109.95, 113.06, -3.6, -2.18)
SW_FC_Borneo_diff <- crop(FCOVER_diff, SW)

SE <- c(113.15, 116.65, -4.21, -2.18)
SE_FC_Borneo_diff <- crop(FCOVER_diff, SE)

E <- c(116.10, 119, -1.71, 2.83)
E_FC_Borneo_diff <- crop(FCOVER_diff, E)

NW <- c(110.86, 114.30, 1.42, 4.56)
NW_FC_Borneo_diff <- crop(FCOVER_diff, NW)

#let's plot the areas
plot(SW_FC_Borneo_diff, col = cldif, main = "SouthWest Borneo FCOVER difference" )
plot(SE_FC_Borneo_diff, col = cldif, main = "SouthEast Borneo FCOVER difference" )
plot(E_FC_Borneo_diff, col = cldif, main = "East Borneo FCOVER difference")
plot(NW_FC_Borneo_diff, col = cldif, main = "NorthWest Borneo FCOVER difference")

par(mfrow= c(2,2))
plot(SW_FC_Borneo_diff, col = cldif, main = "SouthWest Borneo FCOVER diff" )
plot(SE_FC_Borneo_diff, col = cldif, main = "SouthEast Borneo FCOVER diff" )
plot(E_FC_Borneo_diff, col = cldif, main = "East Borneo FCOVER diff")
plot(NW_FC_Borneo_diff, col = cldif, main = "NorthWest Borneo FCOVER diff")

#let's export them
png("Borneo_diff.png", width = 2500, height = 2500, res = 300)
par(mfrow= c(2,2))
plot(SW_FC_Borneo_diff, col = cldif, main = "SouthWest Borneo FCOVER diff" )
plot(SE_FC_Borneo_diff, col = cldif, main = "SouthEast Borneo FCOVER diff" )
plot(E_FC_Borneo_diff, col = cldif, main = "East Borneo FCOVER diff")
plot(NW_FC_Borneo_diff, col = cldif, main = "NorthWest Borneo FCOVER diff")
dev.off()

## let's plot frequency distribution of FCOVER in Borneo with histograms
 #to analyze how the vegetation cover changes during the years

par(mfrow = c(1,3))
hist(Borneo2014, main = "Borneo FCOVER 2014")
hist(Borneo2018, main = "Borneo FCOVER 2018")
hist(Borneo2022, main = "Borneo FCOVER 2022")

#export
png("hist_FCOVER.png", width = 3200, height = 1800, res = 300)
par(mfrow=c(1,3))
hist(Borneo2014, main = "Borneo FCOVER 2014")
hist(Borneo2018, main = "Borneo FCOVER 2018")
hist(Borneo2022, main = "Borneo FCOVER 2022")
dev.off()

dev.off()
#The normalized difference vegetation index (NDVI) is a graphical indicator of the greenness of biomes
#so NDVI can be used to estimate the condition of vegetation

## Copernicus data with a resolution of 300m x300m per pixel, 
 #data on https://land.copernicus.vgt.vito.be/PDF/portal/Application.html#Home
 # NDVI data of 2014,2018,2022

#Having many files presenting the NDVI pattern, it's easier to import them as a list (same way as FCOVER)
NDVI_list <- list.files(pattern ="NDVI300")
NDVI_list # 3 images of global NDVI for the years 2014, 2018,2022

## having a list, we can apply the raster function directly on it, instead of each of the files
NDVI_rast <- lapply(NDVI_list, raster)
NDVI_rast

##let's create a stack, concatenating the images as a single one
NDVI_stack <- stack(NDVI_rast)
NDVI_stack

plot(NDVI_stack)

## $ symbol to select one of the images, through it's name

#Being the name "Normalized.Difference.Vegetation.Index.333M.1/2/3 too long, renaming them could be useful
names(NDVI_stack) <- c("NDVI.300.1","NDVI.300.2", "NDVI.300.3")

NDVI2014 <- NDVI_stack$NDVI.300.1
NDVI2018 <- NDVI_stack$NDVI.300.2
NDVI2022 <- NDVI_stack$NDVI.300.3

## click(NDVI2014) 
 # there are background values when plotting NDVI so let's use click function and click on them to understand the value
 # then transform them into NA, in order to remove them
NDVI2014_def <- calc(NDVI2014, fun=function(x){x[x>0.935] <- NA;return(x)})
NDVI2018_def <- calc(NDVI2018, fun=function(x){x[x>0.935] <- NA;return(x)})
NDVI2022_def <- calc(NDVI2022, fun=function(x){x[x>0.935] <- NA;return(x)})
## calc function Calculate values for a new Raster* object from another Raster* object, using a formula.
 # now we can plot NDVI without background value

##using the same coordinates for Borneo, let's crop the interested area
NDVI_Borneo2014 <- crop(NDVI2014_def, ext)
plot(NDVI_Borneo2014)

NDVI_Borneo2018 <- crop(NDVI2018_def, ext)
plot(NDVI_Borneo2018)

NDVI_Borneo2022 <- crop(NDVI2022_def, ext)
plot(NDVI_Borneo2022)

##Normalized Difference Vegetation Index (NDVI) quantifies vegetation by measuring the difference 
 #between near-infrared (which healthy vegetation strongly reflects) and red light (which healthy vegetation absorbs).
 #NDVI always ranges from -1 to +1
 #NDVI values close to zero represent bare soil, 
 #NDVI close to 1 represents living healthy vegetation. 

##let's create a colorRampPalette 
 #with close to zero values represented by yellow
 #and close to one values represented by green (similar to healthy vegetation)

NDVI_palette <- colorRampPalette(c("gold","olivedrab3", "darkgreen")) (100)

##let's plot and export for each year

#2014
plot(NDVI_Borneo2014, col = NDVI_palette, main="NDVI_Borneo_2014")

png("NDVI_Borneo2014.png", width = 2500, height = 2500, res = 300)
plot(NDVI_Borneo2014, col=NDVI_palette, main="NDVI_Borneo_2014")
dev.off()

#2018
plot(NDVI_Borneo2018, col= NDVI_palette, main="NDVI_Borneo_2018")

png("NDVI_Borneo2018.png", width = 2500, height = 2500, res = 300)
plot(NDVI_Borneo2018, col=NDVI_palette, main="NDVI_Borneo_2018")
dev.off()

#2022
plot(NDVI_Borneo2022, col=NDVI_palette, main="NDVI_Borneo_2022")

png("NDVI_Borneo2022.png", width = 2500, height = 2500, res = 300)
plot(NDVI_Borneo2022, col=NDVI_palette, main="NDVI_Borneo_2022")
dev.off()

##since we looked the FCOVER difference between 2022 and 2018,
 # let's explore the NDVI_difference in the same years
 # using palette cldif to highlight differences in vegetation health

NDVI_diff <- (NDVI_Borneo2022 - NDVI_Borneo2018)
plot(NDVI_diff, col = cldif, main = "NDVI difference 2022-2018")

#let's export the NDVI difference
png("NDVI_diff.png", width = 2500, height = 2500, res = 300)
plot(NDVI_diff, col = cldif, main = "NDVI difference 2022-2018")
dev.off()

#let's compare FCOVER difference and NDVI difference
 par(mfrow =(c(1,2)))
 plot(FCOVER_diff, col =cldif, main = "FCOVER difference 2022-2018")
 plot(NDVI_diff, col = cldif, main = "NDVI difference 2022-2018")

 #export
 png("FCOVER_NDVI_comparison.png", width = 3000, height = 2000, res = 300)
 par(mfrow =(c(1,2)))
 plot(FCOVER_diff, col =cldif, main = "FCOVER difference 2022-2018")
 plot(NDVI_diff, col = cldif, main = "NDVI difference 2022-2018")
 dev.off()
 
 #let's see the difference in NDVI in the same areas examined with FCOVER
 
 SW_NDVI_Borneo_diff <- crop(NDVI_diff, SW)
 SE_NDVI_Borneo_diff <- crop(NDVI_diff, SE)
 E_NDVI_Borneo_diff <- crop(NDVI_diff, E)
 NW_NDVI_Borneo_diff <- crop(NDVI_diff, NW)
 
 #let's plot the areas
 plot(SW_NDVI_Borneo_diff, col = cldif, main = "SouthWest Borneo NDVI diff" )
 plot(SE_NDVI_Borneo_diff, col = cldif, main = "SouthEast Borneo NDVI diff" )
 plot(E_NDVI_Borneo_diff, col = cldif, main = "East Borneo NDVI diff")
 plot(NW_NDVI_Borneo_diff, col = cldif, main = "NorthWest Borneo NDVI diff")
 
par(mfrow = c(2,2))
plot(SW_NDVI_Borneo_diff, col = cldif, main = "SouthWest Borneo NDVI diff" )
plot(SE_NDVI_Borneo_diff, col = cldif, main = "SouthEast Borneo NDVI diff" )
plot(E_NDVI_Borneo_diff, col = cldif, main = "East Borneo NDVI diff")
plot(NW_NDVI_Borneo_diff, col = cldif, main = "NorthWest Borneo NDVI diff")

#export
png("NDVI_comparison.png", width = 3000, height = 2000, res = 300)
par(mfrow = c(2,2))
plot(SW_NDVI_Borneo_diff, col = cldif, main = "SouthWest Borneo NDVI diff" )
plot(SE_NDVI_Borneo_diff, col = cldif, main = "SouthEast Borneo NDVI diff" )
plot(E_NDVI_Borneo_diff, col = cldif, main = "East Borneo NDVI diff")
plot(NW_NDVI_Borneo_diff, col = cldif, main = "NorthWest Borneo NDVI diff")
dev.off()

#let's compare FCOVER and NDVI differences for each area
par(mfrow = c(2,2))
plot(SW_FC_Borneo_diff, col = cldif, main = "SouthWest Borneo FCOVER difference" )
plot(SW_NDVI_Borneo_diff, col = cldif, main = "SouthWest Borneo NDVI difference" )
plot(SE_FC_Borneo_diff, col = cldif, main = "SouthEast Borneo FCOVER difference" )
plot(SE_NDVI_Borneo_diff, col = cldif, main = "SouthEast Borneo NDVI difference" )

par(mfrow = c(2,2))
plot(E_FC_Borneo_diff, col = cldif, main = "East Borneo FCOVER difference")
plot(E_NDVI_Borneo_diff, col = cldif, main = "East Borneo NDVI difference")
plot(NW_FC_Borneo_diff, col = cldif, main = "NorthWest Borneo FCOVER difference")
plot(NW_NDVI_Borneo_diff, col = cldif, main = "NorthWest Borneo NDVI difference")

#export them
png("SW_SE_Index_comparison.png", width = 3000, height = 2000, res = 300)
par(mfrow = c(2,2))
plot(SW_FC_Borneo_diff, col = cldif, main = "SouthWest Borneo FCOVER difference" )
plot(SW_NDVI_Borneo_diff, col = cldif, main = "SouthWest Borneo NDVI difference" )
plot(SE_FC_Borneo_diff, col = cldif, main = "SouthEast Borneo FCOVER difference" )
plot(SE_NDVI_Borneo_diff, col = cldif, main = "SouthEast Borneo NDVI difference" )
dev.off()

png("E_NW_Index_comparison.png", width = 3000, height = 2000, res = 300)
par(mfrow = c(2,2))
plot(E_FC_Borneo_diff, col = cldif, main = "East Borneo FCOVER difference")
plot(E_NDVI_Borneo_diff, col = cldif, main = "East Borneo NDVI difference")
plot(NW_FC_Borneo_diff, col = cldif, main = "NorthWest Borneo FCOVER difference")
plot(NW_NDVI_Borneo_diff, col = cldif, main = "NorthWest Borneo NDVI difference")
dev.off()

#######################################################################################
