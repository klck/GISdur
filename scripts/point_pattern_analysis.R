## all necessary packages
library(spatstat)
library(sp)

# load data
load("data/corner_points.RData")
load("data/loc_spec_xyz.RData")

# creating a valid window for the analysis
wndw <- owin(poly = list(x = corner.points@coords[c(4:1), 1],
                         y = corner.points@coords[c(4:1), 2]))

# ploting wndw
plot(wndw)

# delete duplicated entries
loc.spec.xyz.unq <- loc.spec.xyz[!duplicated(loc.spec.xyz$treeID), ]

# create unique point pattern process
loc.spec.xyz.unq.ppp <- ppp(x = loc.spec.xyz.unq$tree.loc.x,
                            y = loc.spec.xyz.unq$tree.loc.y,
                            window = wndw)

# ploting
plot(loc.spec.xyz.unq.ppp)

# density ploting
plot(density(loc.spec.xyz.unq.ppp))

# Ripley's K-function
rip.k <- Kest(loc.spec.xyz.unq.ppp)
rip.k

# ploting rip.k
plot(rip.k)

# Lest ploting rip.k
rip.l <- Lest(loc.spec.xyz.unq.ppp)
plot(rip.l)

### proper statistical analysis of point pattern (Monte Carlo simulation)
### statistical inference thorugh calculation of significance bands
set.seed(234)
env <- envelope(loc.spec.xyz.unq.ppp, fun = Lest, nsim = 99)

# ploting env
plot(env)
