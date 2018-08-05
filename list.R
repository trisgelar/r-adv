util <- read.csv("Machine-Utilization.csv")
View(util)

head(util,20)
summary(util)

util$Utilization = 1 - util$Percent.Idle
head(util,20)

tail(util)
?POSIXlt
?POSIXct

as.POSIXct(util$Timestamp, format="%d/%m/%Y %H:%M")

util$PosixTime <- as.POSIXct(util$Timestamp, format="%d/%m/%Y %H:%M")
head(util)

# rearange columns in a df
util$Timestamp <- NULL

util <- util[,c(4,1,2,3)]
head(util,4)

RL1 <- util[util$Machine=="RL1",]
summary(RL1)

RL1$Machine <- factor(RL1$Machine)
summary(RL1)

# Name of Machine
# Vector: min, mean, max
# Logical: has utilization ever fallen below 90% ? TRUE / FALSE

util_stats_rl1 <- c(
    min(RL1$Utilization, na.rm=T), 
    mean(RL1$Utilization, na.rm=T), 
    max(RL1$Utilization, na.rm=T)
)
util_stats_rl1
length(which(RL1$Utilization < 0.90)) > 0
util_under_90_flag <- length(which(RL1$Utilization < 0.90)) > 0

list_rl1 <- list("RL1", util_stats_rl1, util_under_90_flag)
list_rl1
names(list_rl1) <- c("Machine", "Stats", "LowThreshold")
names(list_rl1)
list_rl1

list_rl1 <- list(Machine="RL1", Stats=util_stats_rl1, LowThreshold=util_under_90_flag)
list_rl1

# Extract List
# [] - return list
# [[]] - return actual object
# $ - Same as [[]] - return actual object

list_rl1[1]
list_rl1[[1]]
list_rl1$Machine

list_rl1[2]
list_rl1[[2]]
list_rl1$Stats
typeof(list_rl1[2])
typeof(list_rl1[[2]])
typeof(list_rl1$Stats)

list_rl1[4] <- "New Information"
list_rl1[4]

list_rl1$UnknownHours <- RL1[is.na(RL1$Utilization),"PosixTime"]
list_rl1

list_rl1[4] <- NULL

list_rl1$Data <- RL1

summary(list_rl1)
str(list_rl1)


# subsetting a list
list_rl1[[4]][1]
list_rl1$UnknownHours[1]

list_rl1[c(1,4)]
list_rl1[c("Machine", "Stats")]
sublist_rl1 <- list_rl1[c("Machine", "Stats")]
sublist_rl1[[2]][2]
sublist_rl1$Stats[2]

# Timeseries
library(ggplot2)
p <- ggplot(data=util)
p + geom_line(
    aes(
        x=PosixTime, 
        y=Utilization, 
        color=Machine)
    ) +
    facet_grid(Machine~.) +
    geom_hline(yintercept = 0.90, color="Gray", size=1.2, linetype=3)

?linetype

Groceries <- c("Onions", "Tomatoes", "Potatoes")
Clothes <- c("Socks", "T-Shirt")
Shopping <- list(Budget=30, Groceries=Groceries, Clothes=Clothes)
Shopping[c(1,2)]