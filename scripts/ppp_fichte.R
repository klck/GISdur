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
loc.spec.xyz.unq.ppp.fichte <- ppp(x = Fichte$tree.loc.x,
                            y = Fichte$tree.loc.y,
                            window = wndw)

# ploting
plot(loc.spec.xyz.unq.ppp.fichte)

# density ploting
plot(density(loc.spec.xyz.unq.ppp.fichte))

# Ripley's K-function
rip.k.fichte <- Kest(loc.spec.xyz.unq.ppp.fichte)
rip.k.fichte

# ploting rip.k
plot(rip.k.fichte)

# Lest ploting rip.k
rip.l.fichte <- Lest(loc.spec.xyz.unq.ppp.fichte)
plot(rip.l.fichte)

### proper statistical analysis of point pattern (Monte Carlo simulation)
### statistical inference thorugh calculation of significance bands
set.seed(234)
env.fichte <- envelope(loc.spec.xyz.unq.ppp.fichte, fun = Lest, nsim = 99)

# ploting env
plot(env.fichte)

# calculate the 'true' deviation from randomness of the isotropically 
# edge corrected L - function
l.iso.fichte <- rip.l.fichte$iso
l.theo.fichte <- rip.l.fichte$theo

# visually inspect the behaviour of the clustering
l.dev.fichte <- l.iso.fichte - l.theo.fichte
plot(l.dev.fichte ~ rip.l.fichte$r, type = "l", 
     ylab = "Deviation from theoretical distribution",
     xlab = "Distance")