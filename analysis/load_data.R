# Load Package ----
library("data.table")
library("rethinking")



# Load Data ----
d <- fread("./data/data.csv")
colnames(d)[1] <- "inheritance"


g_max <- max(d$generation)

sum(d$wealth > 9)
d[generation == g_max, .N]

unique(d[generation == 9 & wealth > 9, wealth])
# 10 12 16 13 15 11 14 17 18 21 23 27

dens(d[generation == g_max, strategy])
hist(d[generation == g_max, strategy], break = "100")
hist(d[generation == g_max, .(wealth, strategy)]$wealth)

w <- 18
d[generation == g_max & wealth == w, .(wealth, strategy, fertility)]$strategy
d[generation == g_max & wealth == w, .(wealth, strategy, fertility)]$fertility

hist(d[generation == g_max & wealth == w, .(wealth, strategy, fertility)]$strategy)
hist(d[generation == g_max & wealth == w, .(wealth, strategy, fertility)]$fertility)
