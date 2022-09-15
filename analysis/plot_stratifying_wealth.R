# Load Data ----
source("./analysis/load_data.R")
d <- d1c0
# d <- d1c1

num_generation <- max(d$generation) + 1



# Growing Class Number ----------------------------------------------------
num_class <- rep(0, num_generation)
for (g in 0:max(d$generation)) {
  # num_class[g+1] <- length(unique(d[generation == g, wealth]))
  print(sort(unique(d[generation == g, wealth])))
  num_class[g+1] <- max(unique(d[generation == g, wealth]))
  plot(num_class, pch = 20)
  Sys.sleep(0.1)
}



# Plot Wealth Distribution Over Time --------------------------------------

plot(NULL, xlab = "Wealth", ylab = "Density", xlim = c(0, max(d$wealth)), ylim = c(0, 1))
for (g in 0:max(d$generation)) {
  lines(density(d[generation == g, wealth]))
}

g <- 15
dens(d[generation == g, wealth])


# Plot Stratifying Wealth -------------------------------------------------
strata_interval <- 5
source("./analysis/stratify_wealth.R")
ggplot(data=d_strata, aes(x=generation, group=wealth, fill=wealth)) +
  geom_density(adjust=1.5, position="fill") +
  theme_ipsum() + 
  ylab("Density of Wealth Strata") +
  xlab("Generation")
