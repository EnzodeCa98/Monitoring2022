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

attach(meuse) # attach is used to access the variables present in the data framework without calling the data frame
plot(cadmium,zinc)
# detach (meuse)

# now we're gonna see the relationship between all the variables 
# we use "pairs"
pairs(meuse) # to create a pairwise correlation plot
