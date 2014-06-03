## list all files in data
fls <- list.files("data", pattern = "locations.csv", full.names = TRUE)

## load data; lapply benutzen um iterativ (wiederholte Anwendung einer 
## immer gleichen Funktion) lesen zu können
loc.list <- lapply(fls, function(...) {
  read.csv(..., stringsAsFactors = FALSE, fill = TRUE)
})

## to see the structure of the data list
str(loc.list)

## Now we have a list containing all field data sheets. Next we need to put
## them together so that we get one complete data frame. For this we use 
## do.call()
loc <- do.call("rbind", loc.list)
str(loc)

## In the field we also recorded the species of each tree. We also want to 
## use this information for our statistical analysis so we need to also 
## read this into R…
spec <- read.csv("data/species_inventory.csv",
                 stringsAsFactors = FALSE, fill = TRUE)

## …and then merge it to the location data so we finally have everything in 
## one data set.
loc.spec <- merge(loc, spec)
str(loc.spec)

## Saving as .RData file -> R's Datenstruktur wird beibehalten (Matrix,
## List etc.)
save(loc.spec, file = "data/tree_locations_species_all.RData")
