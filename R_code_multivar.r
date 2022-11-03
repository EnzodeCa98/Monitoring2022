# R_code_multivar.r

# install.packages("vegan")
library(vegan)

## multivariate analysis are able to show data from more dimensions into just one
# community ecology example with R

setwd("C:/Users/salde/Desktop/UNIBO/Didattica II/Monitoring/lab/")

## to upload our project use the following function:
load("biomes_multivar.RData")
ls()
head(biomes)
ls()
biomes_types

multivar <- decorana(biomes)
plot(multivar)

attach(biomes_types)
##ordiellipse function display groups or factor levels in ordination diagrams

ordiellipse(multivar, type, col = c("black", "red", "green", "blue"), kind = "ehull", lwd = 3)
