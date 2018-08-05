getwd()
setwd("E:\\Projects\\Workshop\\r-adv")
getwd()

fin <- read.csv("Future-500.csv")
fin <- read.csv("Future-500.csv", na.string=c(""))
head(fin)
tail(fin)
str(fin)
summary(fin)

fin$ID <- factor(fin$ID)
summary(fin)
str(fin)

#Factor Variable Trap (FVT)
a <- c("12", "13", "14", "12", "12")
a

typeof(a)
b <- as.numeric(a)
b
typeof(b)

z <- factor(c("12", "13", "14", "12", "12"))
z

# false
c <- as.numeric(z)
c
typeof(c)

# true
y <- as.numeric(as.character(z))
y
typeof(y)

# sub and gsub
?sub

fin$Expenses <- gsub(" Dollars", "", fin$Expenses)
fin$Expenses <- gsub(",", "", fin$Expenses)

fin$Revenue <- gsub("\\$", "", fin$Revenue)
fin$Revenue <- gsub(",", "", fin$Revenue)

fin$Growth <- gsub("%", "", fin$Growth)

fin$Expenses <- as.numeric(fin$Expenses)
fin$Revenue <- as.numeric(fin$Revenue)
fin$Growth <- as.numeric(fin$Growth)


head(fin)
str(fin)

summary(fin)

?NA

head(fin,24)

# check NA in rows
complete.cases(fin)

fin[!complete.cases(fin),]
str(fin)

head(fin)
fin[fin$Revenue == 9746272,]
which(fin$Revenue == 9746272)
fin[which(fin$Revenue == 9746272),]

is.na(fin$Expenses)
fin[is.na(fin$Expenses),]

# Remove Line
fin_backup <- fin 
fin[!complete.cases(fin$Industry),]
fin[is.na(fin$Industry),] <- NULL

fin[!complete.cases(fin$Industry),] 

fin <- fin[!is.na(fin$Industry),]
head(fin, 20)

# Reset Data Frame Index
rownames(fin) <- NULL
rownames(fin) <- 1:nrow(fin)

# Factual Analysis
fin[!complete.cases(fin),]
fin[is.na(fin$State),]

fin[is.na(fin$State) & fin$City=="New York",]
fin[is.na(fin$State) & fin$City=="New York","State"] <- "NY"

fin[c(11,377),]

fin[is.na(fin$State) & fin$City=="San Francisco","State"] <- "CA"

# mean

# median
fin[fin$Industry=="Retail",]

median(fin[,"Employees"],na.rm=TRUE)
mean(fin[,"Employees"],na.rm=TRUE)


med_empl_retail <- median(fin[fin$Industry == "Retail","Employees"],na.rm=TRUE)
fin[is.na(fin$Employees) & fin$Industry=="Retail","Employees"] <- med_empl_retail

med_empl_finserv <- median(fin[fin$Industry == "Financial Services","Employees"],na.rm=TRUE)
fin[is.na(fin$Employees) & fin$Industry=="Financial Services","Employees"] <- med_empl_finserv

# Growth

med_growth_const <- median(fin[fin$Industry == "Construction","Growth"],na.rm=TRUE)
fin[is.na(fin$Growth) & fin$Industry=="Construction","Growth"] <- med_growth_const

# Revenue
med_rev_const <- median(fin[fin$Industry == "Construction","Revenue"],na.rm=TRUE)
fin[is.na(fin$Revenue) & fin$Industry=="Construction","Revenue"] <- med_rev_const

# Expenses
med_exp_const <- median(fin[fin$Industry == "Construction","Expenses"],na.rm=TRUE)
fin[is.na(fin$Expenses) & fin$Industry=="Construction" & is.na(fin$Profit),"Expenses"] <- med_exp_const

# Profit
med_profit_const <- median(fin[fin$Industry == "Construction","Profit"],na.rm=TRUE)
fin[is.na(fin$Profit) & fin$Industry=="Construction","Profit"] <- med_profit_const

# Derive Value

# Revenue - Expenses = Profit
# Expense = Revenue - Profit
fin[is.na(fin$Profit), "Profit"] <- fin[is.na(fin$Profit), "Revenue"] - fin[is.na(fin$Profit), "Expenses"]

fin[is.na(fin$Profit), "Expenses"] = fin[is.na(fin$Profit), "Revenue"] - fin[is.na(fin$Profit), "Profit"]

library(ggplot2)

p <- ggplot(data = fin)
p + geom_point(
    aes(x=Revenue, y=Expenses, color=Industry, size=Profit)
    ) +
    geom_smooth(aes(x=Revenue, y=Expenses, color=Industry))


d <- ggplot(
        data = fin,
        aes(
            x=Revenue,
            y=Expenses,
            color=Industry
        )
    )
d + geom_point() + 
    geom_smooth(fill=NA, size=1.2)


# Boxplot
f <- ggplot(data=fin, aes(x=Industry, y=Growth, color=Industry))
f + 
    geom_jitter() +
    geom_boxplot(size = 1, alpha=0.5, outlier.color=NA)
