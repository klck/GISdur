triangle <- function(alpha, c) {
  a <- sin(deg2rad(alpha)) * c
  b <- cos(deg2rad(alpha)) * c
  
  values <- data.frame(x = round(a, 2), y = round(b, 2))
  
  return(values)
}