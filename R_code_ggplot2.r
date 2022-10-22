##lesson 20/10

install.packages("ggplot2")

## R code for ggplot2 based graphs

library(ggplot2)

# ecological dataframe

virus <- c(10, 30, 40, 50, 60, 80)
death <- c(100, 240, 310, 470, 580, 690)

plot(virus,death, pch = 19, cex =2)
data.frame(virus, death)
d <- data.frame(virus, death)
d
summary(d)

## data used are "d", so the dataframe, aes = "aesthetics"

ggplot(d, aes(x = virus, y = death)) + geom_point()
ggplot(d, aes(x = virus, y = death)) + geom_point(size=3, col = "coral")

ggplot(d, aes(x = virus, y = death)) + geom_point(size=3, col = "coral", pch = 17) + geom_line(col= "blue")

ggplot(d, aes(x = virus, y = death)) + geom_point(size=3, col = "coral", pch = 17) + geom_polygon(col= "blue")

install.packages("spatstat")
library("spatstat")


## set working directory
#let's use our own data
## the path of the necessary folder is in the "property" section of the folder, in windows there is a slash with inverted orientation
setwd("C:/Users/salde/Desktop/UNIBO/Didattica II/Monitoring/lab")
covid <- read.table("covid_agg.csv")
covid
head(covid)
## part header of the function make the first row not considered as data , header start as default as "FALSE" so first row considered as data.
covid <- read.table("covid_agg.csv", header = T)
covid

summary(covid)

ggplot(covid, aes(x=lon, y =lat)) + geom_point(col="red")

ggplot(covid, aes(x=lon, y =lat, size = cases)) + geom_point(col="red")
## size is going to follow the size of the data/cases


