source("R/deg2rad.R")
source("R/triangle.r")

calcCorners <- function(x.known, y.known, 
                        orientation, declination,
                        size.x, size.y) {
  alpha <- orientation - declination
  alpha270 <- alpha + 270
  alpha90 <- alpha + 90
  
  D2A <- triangle(alpha270, size.x)
  A2B <- triangle(alpha, size.y)
  B2C <- triangle(alpha90, size.x)
  
  
  Ax <- x.known + D2A[,1]
  Ay <- y.known + D2A[,2]
  Bx <- Ax + A2B[,1]
  By <- Ay + A2B[,2]
  Cx <- Bx + B2C[,1]
  Cy <- By + B2C[,2]
  Dx <- x.known
  Dy <- y.known
  Corners <- data.frame(A = list(x = Ax, y = Ay), B = list(x = Bx, 
  y = By), C = list(x = Cx, y = Cy), D = list(x = x.known, y = y.known))
  return(Corners)
  
}

calcCorners(481054, 5645540, 9, -1.48, 48, 30)