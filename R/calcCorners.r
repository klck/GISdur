calcCorners <- function(x.known, y.known, 
                        orientation, declination,
                        size.x, size.y) {
  alpha <- orientation + declination
  alpha270 <- alpha + 270
  alpha90 <- alpha + 90
  
  aA <- sin(alpha270 * pi/180) * size.x
  bA <- cos(alpha270 * pi/180) * size.x
  
  aB <- sin(alpha * pi/180) * size.y
  bB <- cos(alpha * pi/180) * size.y
  
  aC <- sin(alpha90 * pi/180) * size.x
  bC <- cos(alpha90 * pi/180) * size.x
  
  
  A <- data.frame(x.known + aA, y.known + bA)
  B <- data.frame(A[,1] + bB,A[,2] + aB)
  C <- data.frame(B[,1] + bC,B[,2]+ aC)
  D <- data.frame(x.known, y.known)
  
  Corners <- list(A, B, C, D)
  return(Corners)
  
}

calcCorners(481054, 5645540, 9, 1.48, 48, 30)


# Bisherige Überlegung: 1. Umrechungsfaktor (declintation) wird gebraucht; 
# habe hier zum Probieren "1" genommen
# das mit alpha ist noch sehr unschön, da nur auf unseren Fall anwendbar.