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

# create unique point pattern process
loc.spec.xyz.unq.ppp.kiefer <- ppp(x = Kiefer$tree.loc.x,
                            y = Kiefer$tree.loc.y,
                            window = wndw)

# ploting
plot(loc.spec.xyz.unq.ppp.kiefer)

# density ploting
plot(density(loc.spec.xyz.unq.ppp.kiefer))

# Ripley's K-function
rip.k <- Kest(loc.spec.xyz.unq.ppp.kiefer)
rip.k

# ploting rip.k
plot(rip.k)

# Lest ploting rip.k
rip.l <- Lest(loc.spec.xyz.unq.ppp.kiefer)
plot(rip.l)

### proper statistical analysis of point pattern (Monte Carlo simulation)
### statistical inference thorugh calculation of significance bands
set.seed(234)
env <- envelope(loc.spec.xyz.unq.ppp.kiefer, fun = Lest, nsim = 99)

# ploting env
plot(env)
