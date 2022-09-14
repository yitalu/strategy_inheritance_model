# Load Package ----
library("data.table")
library("rethinking")
library("ggplot2")
library("ggridges")


# Load Data ----
d0c0 <- fread("./data/data_d0c0.csv")
colnames(d0c0)[1] <- "inheritance"
d <- d0c0

d1c0 <- fread("./data/data_d1c0.csv")
colnames(d1c0)[1] <- "inheritance"
d <- d1c0

d1c0_h00 <- fread("./data/data_d1c0_h00.csv")
d1c0_h03 <- fread("./data/data_d1c0_h03.csv")
d1c0_h06 <- fread("./data/data_d1c0_h06.csv")
d1c0_h09 <- fread("./data/data_d1c0_h09.csv")


d0c1 <- fread("./data/data_d0c1.csv")
colnames(d0c1)[1] <- "inheritance"
d <- d0c1

d1c1 <- fread("./data/data_d1c1.csv")
colnames(d1c1)[1] <- "inheritance"
d <- d1c1





# Population Size in the Last Generation ----------------------------------
g_max <- max(d$generation)
w_max_initial <- max(d[generation == 0, ]$wealth)
d[generation == g_max & wealth > w_max_initial, .N]
n_pop <- d[generation == g_max, .N]
print(n_pop)


# Richest Class in the Last Generation ------------------------------------
w_max_initial <- max(d[generation == 0, ]$wealth)
w_max_final <- max(d[generation == g_max, ]$wealth)
print(w_max_final)
sort(unique(d[generation == g_max & wealth > w_max_initial, ]$wealth))


# Growth of Wealth Stratification -----------------------------------------
num_class <- rep(0, max(d$generation) + 1)
for (g in 0:max(d$generation)) {
  print(g)
  # num_class[g+1] <- length(unique(d[generation == g, wealth]))
  num_class[g+1] <- max(unique(d[generation == g, wealth]))
  plot(num_class, pch = 20)
  Sys.sleep(0.1)
}


# good for d0c0 and d1c0 when population grows large enough

colnames(diamonds)

ggplot(diamonds, aes(x = price, y = cut, fill = cut)) +
  geom_density_ridges() +
  theme_ridges() + 
  theme(legend.position = "none")

library("hrbrthemes")
ggplot(data=diamonds, aes(x=price, group=cut, fill=cut)) +
  geom_density(adjust=1.5, alpha=.4) +
  theme_ipsum()

d_mod <- d[wealth > w_max_initial]

ggplot(d_mod, aes(wealth, generation, group = generation)) + 
  # geom_density_ridges(fill = "lightblue", alpha=0.6, stat="binline", bins=30) +
  geom_density_ridges(fill = "lightblue", alpha=0.6) +
  theme_ridges() + 
  theme(legend.position = "none") + 
  labs(title = 'Emergence of the Super Rich')

ggplot(d_mod, aes(wealth, group=generation, fill=generation)) +
  geom_density(adjust=1.5, alpha=0.4) +
  theme_ipsum()

dens(d[generation == g_max & wealth > w_max_initial, wealth])



# proportion in classes
g_max <- max(d$generation)
d[generation == g_max & wealth >= 0 & wealth <= 2, .N] / d[generation == g_max, .N]
d[generation == g_max & wealth >= 3 & wealth <= 6, .N] / d[generation == g_max, .N]
d[generation == g_max & wealth >= 7 & wealth <= 9, .N] / d[generation == g_max, .N]

g_max <- max(d$generation)
g_max <- 13
d[generation == g_max & wealth >= w_max_initial, .N] / d[generation == g_max, .N]


# Strategies of the Richest -----------------------------------------------
d <- d1c1
g_max <- max(d$generation)
w <- d[generation == g_max & wealth > w_max_initial, wealth]
s <- d[generation == g_max & wealth > w_max_initial, strategy]
plot(s ~ w)


# Fertility of the Richest ------------------------------------------------
d <- d1c1
g_max <- max(d$generation)
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
d <- d1c0
g_max <- max(d$generation)
w <- d[generation == g_max, wealth]
s <- d[generation == g_max, strategy]
f <- d[generation == g_max, fertility]
plot(s ~ jitter(w))
grid()
plot(jitter(f) ~ jitter(w))
grid()

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



# Long-Term Fitness -------------------------------------------------------
g_max <- max(d$generation)
dens(d[generation == g_max, `ancestor class`])
table(d[generation == g_max, `ancestor class`])

dens(d[generation == g_max & `ancestor class` == 9, strategy])


dens(d[generation == g_max, `parent class`])
table(d[generation == g_max, `parent class`])
dens(d[generation == g_max & `parent class` == 8, strategy])
dens(d[generation == g_max & `parent class` == 8, fertility])



