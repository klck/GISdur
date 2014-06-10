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
rip.k.kiefer <- Kest(loc.spec.xyz.unq.ppp.kiefer)
rip.k.kiefer

# ploting rip.k
plot(rip.k.kiefer)

# Lest ploting rip.k
rip.l.kiefer <- Lest(loc.spec.xyz.unq.ppp.kiefer)
plot(rip.l.kiefer)

### proper statistical analysis of point pattern (Monte Carlo simulation)
### statistical inference thorugh calculation of significance bands
set.seed(234)
env.kiefer <- envelope(loc.spec.xyz.unq.ppp.kiefer, fun = Lest, nsim = 99)

# ploting env
plot(env.kiefer)

# calculate the 'true' deviation from randomness of the isotropically 
# edge corrected L - function
l.iso.kiefer <- rip.l.kiefer$iso
l.theo.kiefer <- rip.l.kiefer$theo

# visually inspect the behaviour of the clustering
l.dev.kiefer <- l.iso.kiefer - l.theo.kiefer
plot(l.dev.kiefer ~ rip.l.kiefer$r, type = "l", 
     ylab = "Deviation from theoretical distribution",
     xlab = "Distance")
