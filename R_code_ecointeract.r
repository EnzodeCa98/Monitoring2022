# This is a code for investigating relationships among ecological variables

# We are using the sp package. To install it use:
# install.packages("sp")
library(sp) # you can also make use of require ()

# we are using meuse:
# search for: "meuse dataset R sp package"
# https://search.r-project.org/CRAN/refmans/geostats/html/meuse.html

data(meuse) # Loads specified data sets, or list the available data sets.

View(meuse) # The View () function in R invokes a spreadsheet-style data viewer on a matrix-like R object. To show data in a table.

head(meuse) # It gives you a snapshot of that large dataset

names(meuse) # to assign a name to each of the elements of our vector

summary(meuse) # To get a better idea of the distribution of your variables in the dataset

plot(cadmium,zinc) # you will receive an error, because the object is "meuse"
# we need to explain to R that cadmium and zinc are part of the object "meuse", they're linked
# we use "$" to link things to each other, in this case we link meuse$cadmium and meuse$zinc
plot(meuse$cadmium, meuse$zinc)

cad <- meuse$cadmium   # we make a new object "cad" to make things more simple
zin <- meuse$zinc
plot(cad,zin)

attach(meuse) # attach is used to access the variables present in the data framework without calling the data frame, without using the $ symbol
plot(cadmium,zinc)

# detach (meuse)

# now we're gonna see the relationship between all the variables 
# we use "pairs"
pairs(meuse) # to create a pairwise correlation plot
attach(meuse) # attach is used to access the variables present in the data framework without calling the data frame, without using the $ symbol
plot(cadmium,zinc, col= "red", cex= 2)
# cex means character exageration

14* (14-1)
pairs(meuse, col="blue")

pairs(meuse[,3:6])
#how to do quadratic parathenses: ALtGr + è

meuse[,3:6]

pol <- meuse[,3:6]
pol <- meuse[,3:6]
pol
pol[1:6,]
head(pol)
#head is the first 6 lines of the dataset

pairs(pol, col="blue", cex = 1.5)

# let's use the names of the columns:

pairs(~ cadmium + copper + lead + zinc, data = meuse)
# ~ woks as a "="

panel.correlations <- function(x,y, digits =1, prefix ="", cex.cor)
  
#panel smoothins useful to put line in the graph
panel.smoothing <- function (x,y, col = 
                             
                             
panel.histograms <- function(x,y)
  
 # use lower/upper/diagonal in order to change panel orientation
  
pairs(pol, lower.panel = panel.correlations,
      upper.panel = panel.smoothing,
      diag.panel = panel.histograms)

 
coordinates(meuse) = ~x + y
                             
coordinates(meuse) = ~x + y
plot(meuse,
     col = "blue",
     pch = 17,
     cex = 1.3
)
meuse
# now coordinates are inserted as a variable as well
                             
# spplot is used to plot elements like zinc, lead etc. spread in space
spplot (meuse, "zinc", main 0 "Concentration of zinc")

# bubble rather than changing colours, you create bubbles to distinguish values
 
 bubble(...)
