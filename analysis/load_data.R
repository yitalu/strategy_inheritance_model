# Load Package ----
library("data.table")
library("rethinking")



# Load Data ----
d0c0 <- fread("./data/data_d0c0.csv")
d1c0 <- fread("./data/data_d1c0.csv")
d0c1 <- fread("./data/data_d0c1.csv")
d1c1 <- fread("./data/data_d1c1.csv")

colnames(d0c0)[1] <- "inheritance"
colnames(d1c0)[1] <- "inheritance"
colnames(d0c1)[1] <- "inheritance"
colnames(d1c1)[1] <- "inheritance"

d <- d0c0
d <- d1c0
d <- d0c1
d <- d1c1

g_max <- max(d$generation)
w_max_initial <- max(d[generation == 0,]$wealth)
w_max_final <- max(d$wealth)

sum(d$wealth > 9)
d[generation == g_max, .N]

unique(d[generation == g_max & wealth > w_max_initial, wealth])
unique(d[generation == g_max & wealth > w_max_initial, .N])
# 10 12 16 13 15 11 14 17 18 21 23 27

dens(d[generation == g_max, strategy])
dens(d[generation == g_max & wealth == w_max_initial, strategy])
dens(d[generation == 7, strategy])
dens(d[generation == 2, fertility])
dens(d[generation == g_max, fertility])
dens(d[generation == g_max & wealth == w_max_initial, fertility])
dens(d[generation == g_max & wealth == w_max_final, fertility])
dens(d[generation == g_max, wealth])

w <- d[generation == g_max, wealth]
s <- d[generation == g_max, strategy]
f <- d[generation == g_max, fertility]
plot(f ~ w)
plot(s ~ w)


dens(d[generation == 0, wealth])
dens(d[generation == g_max, .(wealth, strategy)]$wealth)

hist(d[generation == g_max, strategy])
hist(d[generation == g_max, .(wealth, strategy)]$wealth)


w <- 15
d[generation == g_max & wealth == w, .(wealth, strategy, fertility)]$strategy
d[generation == g_max & wealth == w, .(wealth, strategy, fertility)]$fertility

hist(d[generation == g_max & wealth == w, .(wealth, strategy, fertility)]$strategy)
hist(d[generation == g_max & wealth == w, .(wealth, strategy, fertility)]$fertility)
