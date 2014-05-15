dreieck <- function(alpha, c) {
  a <- sin(alpha * pi/180) * c
  b <- cos(alpha * pi/180) * c
  
  werte <- list(x<-round(a,2),y<-round(b,2))
  return(werte)
  
}

# Bisherige Überlegung: 1. Umrechungsfaktor (declintation) wird gebraucht; 
# 2. Die bisherige Funktion (dreieck) gibt die Seiten a und b aus. Diese 
# müssen zu den UTM Koord. addiert werden;
# 3. Das gegebene bearing von einer Strecke ist 9°; Das Problem ist, dass, 
# je nach dem in welche Richtung der nächste Punkt liegt, immer 90°, 180° oder 
# 270° dazu addiert werden muss
# siehe: Bsp. Wenn das das bearing der Ausgangecke (1.) ist 180 < X < 270, muss
# für die folgenden Ecken dies gelten: 2. x + 270, 3. X, 4. X + 90. Für uns
# konkret: 1. X > 270, 2. X, 3. X + 90, 4. X + 180