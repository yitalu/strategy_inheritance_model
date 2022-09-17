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

pdf(file = "./figures/wealth_distribution_over_time.pdf")
plot(NULL, xlab = "Wealth", ylab = "Density", xlim = c(0, max(d$wealth)), ylim = c(0, 0.4), main = "Wealth Distribution over Time")
for (g in 0:max(d$generation)) {
  lines(density(d[generation == g, wealth]))
  Sys.sleep(0.1)
}
dev.off()

g <- 15
dens(d[generation == g, wealth])


# Plot Stratifying Wealth -------------------------------------------------
strata_interval <- 10
source("./analysis/stratify_wealth.R")

png(file = "./figures/stratifying_wealth.png")
ggplot(data=d_strata, aes(x=generation, group=wealth, fill=wealth)) +
  geom_density(adjust=1.5, position="fill") +
  theme_ipsum() + 
  ylab("Density of Wealth Strata") +
  xlab("Generation")
dev.off()
