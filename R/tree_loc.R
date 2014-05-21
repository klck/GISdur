fls<-list.files("data",pattern="locations.csv",full.names=TRUE)
fls

<<<<<<< HEAD
loc.list <- lapply(fls, function(...) {
  read.csv(..., stringsAsFactors = FALSE, fill = TRUE)
})
str(loc.list)
loc.list
loc <- do.call("rbind", loc.list)
str(loc)
spec <- read.csv("data/species_inventory.csv",stringsAsFactors = FALSE, fill = TRUE)
spec
str(spec)
loc.spec<-merge(loc,spec)
str(loc.spec)
save(loc.spec, file = "data/tree_locations_species_all.RData")
=======
loc.list<-lapply(fls,function(...){read.csv(...,stringsAsFactors=FALSE,fill=TRUE)})
loc.list
str(loc.list)

loc<-do.call("rbind",loc.list)
str(loc)

spec<-read.csv("data/species_inventory.csv", stringsAsFactors=FALSE,fill=TRUE)
spec
str(spec)

loc.spec<-merge(loc,spec)
str(loc.spec)

save(loc.spec, file="data/tree_locations_species_all.RData")

>>>>>>> d02c5e52b13bb9ed4288e11e6eebd610efa7a994
