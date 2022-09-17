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

# pdf(file = "./figures/wealth_distribution_over_time.pdf")
plot(NULL, xlab = "Wealth", ylab = "Density", xlim = c(0, max(d$wealth)), ylim = c(0, 0.4), main = "Wealth Distribution over Time")
for (g in 0:max(d$generation)) {
  lines(density(d[generation == g, wealth]))
  Sys.sleep(0.1)
}
# dev.off()

tiff(file = "./figures/wealth_over_time.tiff", width = 2000, height = 1600, res = 300)
ggplot(data=d, aes(x=wealth, group = generation)) +
  geom_density(adjust=0.5, color="#69b3a2") +
  theme_ipsum() +
  facet_wrap(~generation) +
  theme(
    legend.position="none",
    panel.spacing = unit(0.5, "lines"),
    axis.ticks.x=element_blank()
  ) + 
  xlab("Wealth") +
  ylab("Density")
dev.off()


# Plot Stratifying Wealth -------------------------------------------------
strata_interval <- 10
source("./analysis/stratify_wealth.R")

tiff(file = "./figures/stratifying_wealth.tiff", width = 2000, height = 1600, res = 300)
ggplot(data=d_strata, aes(x=generation, group=wealth, fill=wealth)) +
  geom_density(adjust=1.5, position="fill") +
  theme_ipsum() +
  # theme_bw() + 
  ylab("Density of Wealth Strata") +
  xlab("Generation")
dev.off()
