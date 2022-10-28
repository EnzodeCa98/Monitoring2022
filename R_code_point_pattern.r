Point pattern analysis 

library(spatstat)
##spatial statistics, also defined as geographical statistics

# Now, let's see the density of the covid data!
# let's make a planar point pattern in spatstat

attach(covid)
# x, y, ranges
covid_planar <- ppp(lon, lat, c(-180,180), c(-90,90))

density_map <- density(covid_planar)

plot(density_map)
points(covid_planar, pch = 19)

## changin colours

cl <- colorRampPalette(c('yellow','orange','red'))(100) # 
plot(density_map, col = cl)
points(covid_planar)

install.packages("rgdal")
library(rgdal) ##GDAL is a translator library for raster and vector geospatial data format

setwd("C:/lab/")

## let's add the coastlines

coastlines <- readOGR("ne_10m_coastline.shp") 
covid <- read.table("covid_agg.csv", header = T)
covid
head(covid)

attach(covid)
covid_planar <- ppp(x=lon, y =lat, c (-180,180), c(-90,90))

##without attaching

covid_planar  <- ppp(x = cov$lon, y = cov$lat, c (-180,180), c(,90,90))
plot(covid_planar)
plot(coastlines, add = T)

density_map <- density(covid_planar)
plot(density_map)
plot(density_map, col = cl)
points(covid_planar, pch = 18, col = "green")
plot(coastlines, add = T, col = "yellow")

cl <- colorRampPalette(c("bisque", "azure", "brown")) (100)                                ##extending a color palette to a color ramp
plot(density_map, col =cl)
points(covid_planar, pch =18)
plot(coastlines, add = T)

head(covid)

##using interpolation (interpolating point data in field, in order to assume a missing value, starting from known values)
attach(covid)
marks(covid_planar) <- cases ##marks means points with a label
## interpolation function is obtained through "Smooth" function, with capital lecter!!
cases_map <- Smooth(covid_planar)
plot(cases_map, col =cl)
points(covid_planar)
plot(coastlines, add = T)
