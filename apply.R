Chicago <- read.csv("Chicago-F.csv", row.names=1)
NewYork <- read.csv("NewYork-F.csv", row.names=1)
SanFrancisco <- read.csv("SanFrancisco-F.csv", row.names=1)
Houston <- read.csv("Houston-F.csv", row.names=1)

is.data.frame(Chicago)
Chicago <- as.matrix(Chicago)
NewYork <- as.matrix(NewYork)
Houston <- as.matrix(Houston)
SanFrancisco <- as.matrix(SanFrancisco)

Weather <- list(Chicago=Chicago, NewYork=NewYork, Houston=Houston, SanFrancisco=SanFrancisco)
Weather

?apply
apply(Chicago, 1, mean)
apply(Chicago, 1, max)

?lapply
lapply()
t(Chicago)

lapply(Weather, t) # list(t(Weather$Chicago), t(Weather$NewYork), t(Weather$Houston), t(Weather$SanFracisco))

rbind(Chicago, NewRow=1:12)

lapply(Weather, rbind, NewRow=1:12)

?rowMeans
rowMeans(Chicago)

lapply(Weather, rowMeans)

Weather
Weather[[1]][1,1]
Weather$Chicago[1,1]

lapply(Weather, "[", 1,1)
lapply(Weather, "[", 1,)

lapply(Weather, "[", ,3)


lapply(Weather, function(x) x[1,])
lapply(Weather, function(x) x[5,])
lapply(Weather, function(x) x[,12])

lapply(Weather, function(z) z[1,]-z[2,])
lapply(Weather, function(z) round((z[1,]-z[2,])/z[2,],2))

# sapply()
?sapply

#AvgHigh_F for July:
lapply(Weather, "[", 1, 7)
sapply(Weather, "[", 1, 7)

#AvgHigh_F for July:
lapply(Weather, "[", 1, 10:12)
sapply(Weather, "[", 1, 10:12)

lapply(Weather, rowMeans)
sapply(Weather, rowMeans)
round(sapply(Weather, rowMeans),2)

lapply(Weather, function(z) round((z[1,]-z[2,])/z[2,],2))
sapply(Weather, function(z) round((z[1,]-z[2,])/z[2,],2))

apply(Chicago, 1, max)

lapply(Weather, apply, 1, max)
sapply(Weather, apply, 1, max)

lapply(Weather, function(x) apply(x, 1, max))
sapply(Weather, function(x) apply(x, 1, max))

# which.max, which.min
which.max(Chicago[1,])
names(which.max(Chicago[1,]))

apply(Chicago, 1, function(x) names(which.max(x)))
lapply(Weather, function(y) apply(y, 1, function(x) names(which.max(x))))


