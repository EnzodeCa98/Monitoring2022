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

#####Errors#############
## Error in ppp(x = lon, y = lat, c(-180, 180), c(-90, 90)) : 
  could not find function "ppp"
## library(spatstat)
Error: pacchetto ‘spatstat.data’ richiesto da ‘spatstat’ non è stato trovato
In addition: Warning message:
il pacchetto ‘spatstat’ è stato creato con R versione 4.2.1 
