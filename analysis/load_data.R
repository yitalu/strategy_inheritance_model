# Load Package ----
library("data.table")
library("rethinking")



# Load Data ----
d0c0 <- fread("./data/data_d0c0_test.csv")
d1c0 <- fread("./data/data_d1c0_test.csv")
d0c1 <- fread("./data/data_d0c1_test.csv")
d1c1 <- fread("./data/data_d1c1_test.csv")

colnames(d0c0)[1] <- "inheritance"
colnames(d1c0)[1] <- "inheritance"
colnames(d0c1)[1] <- "inheritance"
colnames(d1c1)[1] <- "inheritance"

d <- d0c0
d <- d1c0
d <- d0c1
d <- d1c1



# Population Size in the Last Generation ----------------------------------
g_max <- max(d$generation)
n_pop <- d[generation == g_max, .N]
print(n_pop)


# Richest Class in the Last Generation ------------------------------------
w_max_initial <- max(d[generation == 0,]$wealth)
w_max_final <- max(d[generation == g_max,]$wealth)
print(w_max_final)


# Growth of Wealth Stratification -----------------------------------------
num_class <- rep(0, max(d$generation) + 1)
for (g in 0:max(d$generation)) {
  print(g)
  num_class[g+1] <- length(unique(d[generation == g, wealth]))
  # num_class[g+1] <- max(unique(d[generation == g, wealth]))
  plot(num_class)
  Sys.sleep(0.1)
}


# good for d0c0 and d1c0 when population grows large enough



# Strategies of the Richest -----------------------------------------------
w <- d[generation == g_max & wealth > w_max_initial, wealth]
s <- d[generation == g_max & wealth > w_max_initial, strategy]
plot(s ~ w)


# Fertility of the Richest ------------------------------------------------
w <- d[generation == g_max & wealth > w_max_initial, wealth]
f <- d[generation == g_max & wealth > w_max_initial, fertility]
plot(f ~ w)


# Strategy Distribution over Time -----------------------------------------
for (g in 0:max(d$generation)) {
  dens(d[generation == g, strategy])
  Sys.sleep(0.1)
}


# Fertility Distribution over Time -----------------------------------------
for (g in 0:max(d$generation)) {
  dens(d[generation == g, fertility])
  Sys.sleep(0.1)
}



# Fertility of Normal Classes ------------------------------------------------
w <- d[generation == g_max & wealth >= 0 & wealth < w_max_initial, wealth]
s <- d[generation == g_max & wealth >= 0 & wealth < w_max_initial, strategy]
f <- d[generation == g_max & wealth >= 0 & wealth < w_max_initial, fertility]
plot(s ~ w)
plot(jitter(f) ~ jitter(w))

sum(d$wealth > 9)
d[generation == g_max, .N]

unique(d[generation == g_max & wealth > w_max_initial, wealth])
unique(d[generation == g_max & wealth > w_max_initial, .N])
# 10 12 16 13 15 11 14 17 18 21 23 27

dens(d[generation == g_max-3, strategy])
dens(d[generation == g_max, fertility])

g <- 9
d[generation == g & wealth == max(d[generation == g,]$wealth), mean(fertility)]


dens(d[generation == g_max, wealth])

dens(d[generation == g_max & wealth == w_max_initial, strategy])
dens(d[generation == 7, strategy])
dens(d[generation == 2, fertility])

dens(d[generation == g_max & wealth == w_max_initial, fertility])
dens(d[generation == g_max & wealth == w_max_final, fertility])





dens(d[generation == 0, wealth])
dens(d[generation == g_max, .(wealth, strategy)]$wealth)

hist(d[generation == g_max, strategy])
hist(d[generation == g_max, .(wealth, strategy)]$wealth)


w <- 15
d[generation == g_max & wealth == w, .(wealth, strategy, fertility)]$strategy
d[generation == g_max & wealth == w, .(wealth, strategy, fertility)]$fertility

hist(d[generation == g_max & wealth == w, .(wealth, strategy, fertility)]$strategy)
hist(d[generation == g_max & wealth == w, .(wealth, strategy, fertility)]$fertility)
