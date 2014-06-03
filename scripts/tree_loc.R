## Load our created data
save(loc.spec, file = "data/tree_locations_species_all.RData")

## Next, we need to make our functions available to us. This is done using 
## source().
source("R/deg2rad.R")
source("R/triangle.R")

## In 3-dimensional space, the bearing is equivalent to inclination while 
## distance is still distance. Thus, flipping our triangle into the vertical 
## plane, it is the adjacent leg that represents the horizontal distance 
## between our origin point and the target point (the tree).
## -> leads to horizontal adjusted distances
obs.dis <- triangle(loc.spec$inclination, loc.spec$distance)
loc.spec$distance_adj <- obs.dis$y

## declination adjusted bearing
decl <- 1.48
loc.spec$bearing_adj <- ifelse(loc.spec$bearing < decl,
                               loc.spec$bearing - decl + 360,
                               loc.spec$bearing - decl)

## loading Corner Points
load("data/corner_points.RData")
### new object in you 'Environment' tab in RStudio called 'corner.points'. 
### This is a so-called “SpatialPointsDataFrame” which is a modified 
### version of R's standard data frame.In addition to the usual row/column 
### structure, it stores location information (in so-called 'slots') in form of
### coordinates and their coordinate refrence system (CRS). The slots of a 
### Spatial* object can be accessed using '@'.
str(corner.points)

## generic plot method for SpatialPointsDataFrames
plot(corner.points)

## in order to get the tree locations we merge the two informations 
## (SpatialPoints and Corner coordinates)
coords.ele <- data.frame(origin = corner.points@data$corner,
                         origin.x = corner.points@coords[, 1],
                         origin.y = corner.points@coords[, 2],
                         origin.z = corner.points@data$ele)

loc.spec.xyz <- merge(loc.spec, coords.ele, all.x = TRUE)
## The all.x = TRUE ensures that we retain all entries from the first data
## frame when we do the merging.

## merging results:
summary(loc.spec.xyz)

## adding 4 new columns ( 'offset.x', 'offset.y', 'tree.loc.x' and 
## 'tree.loc.y') because columns 9-11 have NAs. They dont have NAs 
## because origin wasnt alawys a corner point (-> no x,y,z coordinates)
tree.offset <- triangle(loc.spec.xyz$bearing_adj, 
                         loc.spec.xyz$distance_adj)

loc.spec.xyz$offset.x <- tree.offset$x
loc.spec.xyz$offset.y <- tree.offset$y

loc.spec.xyz$tree.loc.x <- loc.spec.xyz$origin.x + loc.spec.xyz$offset.x
loc.spec.xyz$tree.loc.y <- loc.spec.xyz$origin.y + loc.spec.xyz$offset.y

## summary
summary(loc.spec.xyz)
### stil some NAs. The reason for this is obviously that we do not know the
### origin points for all of the trees. But we have just claculated the 
### absolute UTM coordinates for all trees that were measured from a corner 
### point, so we can use these locations as origins where appropriate.

###copy values from columns 'tree.loc.x' and 'tree.loc.y'  to 'origin.x' 
### and 'origin.y' using the 'treeID' as an identifier. Then calculate 
### 'tree.loc.x' and 'tree.loc.y' again until all 'origin.x' and 'origin.y' 
### are filled and then run the tree location calculation one last time. 
### Repeat calculations until no NAs will be found anymore.
### -> implement this using a while() loop:

## do as long as origin.x still has NA values
while(any(is.na(loc.spec.xyz$origin.x))) {
  
  ## which rows have missing origin coordinates
  ind.mis <- which(is.na(loc.spec.xyz$origin.x))
  
  ## loop through all missing origin coordinates and provide 
  ## appropriate values based on treeID
  for (i in ind.mis) {
    
    ori.tree <- loc.spec.xyz$origin[i]
    
    ori.x <- loc.spec.xyz$tree.loc.x[loc.spec.xyz$treeID == ori.tree]
    loc.spec.xyz$origin.x[loc.spec.xyz$origin == ori.tree] <- mean(ori.x)
    
    ori.y <- loc.spec.xyz$tree.loc.y[loc.spec.xyz$treeID == ori.tree]
    loc.spec.xyz$origin.y[loc.spec.xyz$origin == ori.tree] <- mean(ori.y)
    
  }
  
  ## calculate offset again and add to origin
  tree.offset <- triangle(loc.spec.xyz$bearing_adj, 
                           loc.spec.xyz$distance_adj)
  
  loc.spec.xyz$offset.x <- tree.offset$x
  loc.spec.xyz$offset.y <- tree.offset$y
  
  loc.spec.xyz$tree.loc.x <- loc.spec.xyz$origin.x + loc.spec.xyz$offset.x
  loc.spec.xyz$tree.loc.y <- loc.spec.xyz$origin.y + loc.spec.xyz$offset.y
  
}

## summary
summary(loc.spec.xyz)
### got a data frame with all information needed for statistical analysis

## saving as .RData
save(loc.spec.xyz, file = "data/loc_spec_xyz.RData")
