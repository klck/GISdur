          ## install packages needed for plotting
          install.packages("latticeExtra")
          install.packages("gridExtra")

## load packages needed for plotting
library(latticeExtra)
library(gridExtra)

## create tree plotting object
trees.p <- xyplot(tree.loc.y ~ tree.loc.x, data = loc.spec.xyz, 
                  asp = "iso", pch = 19,
                  col = brewer.pal(length(unique(loc.spec.xyz$spec)), 
                                   "Set1")[as.factor(loc.spec.xyz$spec)])

## used coords.ele for corner points
corners.df <- coords.ele
## replicate first corner point to close polygon
corners.df[5, ] <- corners.df[1, ]

## create corner point plotting object
corners.p <- xyplot(origin.y ~ origin.x, data = corners.df, type = "l", 
                    asp = "iso", col = "grey90", 
                    panel = function(...) {
                      grid.rect(gp = gpar(fill = "grey10"))
                      panel.xyplot(...)})

## create layered plotting object
p <- corners.p + as.layer(trees.p)

## final plot
print(update(p, main = paste("Tree locations\n", 
                             "(colour coded according to species)"),
             xlab = "X", ylab = "Y", scales = list(y = list(rot = 90))))