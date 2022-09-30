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

# tiff(file = "./figures/wealth_over_time.tiff", width = 2000, height = 1600, res = 300)
ggplot(data=d, aes(x=wealth, group = generation)) +
  geom_density(adjust=0.5, color="#69b3a2") +
  theme_ipsum() +
  facet_wrap(~generation) +
  theme(
    legend.position="none",
    panel.spacing = unit(0.5, "lines"),
    axis.ticks.x=element_blank()
  ) + 
  # scale_x_continuous(breaks = scales::pretty_breaks(n = 4)) + 
  labs(title="Wealth Distribution Over Time", x ="Wealth", y = "Density") + 
  theme(plot.title = element_text(size = 14, hjust = 0.5))
# dev.off()



# Plot Wealth Distribution: Start and End ---------------------------------
# tiff(file = "./figures/wealth_start_end.tiff", width = 2000, height = 1600, res = 300)
plot(NULL, xlab = "Wealth", ylab = "Density", xlim = c(0, max(d$wealth)), ylim = c(0, 0.4), main = "Wealth Distribution over Time")
lines(density(d[generation == 1, wealth]), col=alpha("#0c372d", alpha = 0.8), lwd=2)
lines(density(d[generation == max(d$generation), wealth]), col=alpha("#69b3a2", alpha = 1), lwd=2)
grid()
legend(65, 0.4, legend = c("Generation 1", "Generation 19"), col = c("#0c372d", "#69b3a2"), lty=c(1, 1), lwd=c(2, 2), box.lty = 1)
# dev.off()

# v <- c(1, max(d$generation))
# for (g in v) {
#   lines(density(d[generation == g, wealth]), col=alpha("#69b3a2", alpha = 0.8), lwd=2)
#   Sys.sleep(0.1)
# }


d_gen_selected <- d[generation <= 2 | generation >= (max(d$generation)-2), ]
d_gen_selected <- d[generation == 0 | generation == 0 | generation == max(d$generation), ]

ggplot(data=d_gen_selected, aes(x=wealth, group=generation, fill=generation)) +
  geom_density(alpha=0.6, adjust=1.5, color="black", size=0.1) +
  scale_fill_viridis(option = "D", alpha = 0.7, discrete = F, name = "Generation", breaks = c(0, 10, 19)) +
  theme_ipsum() +
  theme(legend.position="none", panel.spacing = unit(0.5, "lines"), axis.ticks.x=element_blank()) +
  labs(title="Wealth Distribution: First vs Last Generation", x ="Wealth", y = "Density") + 
  theme(plot.title = element_text(size = 14, hjust = 0.5))




# Plot Stratifying Wealth -------------------------------------------------
strata_interval <- 10
source("./analysis/stratify_wealth.R")

# tiff(file = "./figures/stratifying_wealth.tiff", width = 2000, height = 1600, res = 300)
ggplot(data=d_strata, aes(x=generation, group=class, fill=class)) +
  geom_density(alpha=0.7, adjust=1.5, position="fill", color="black", size=0.1) +
  scale_fill_viridis(option = "D", alpha = 0.7, discrete = F, name = "Social Class", breaks = c(0, 2, 4, 6, 8, 10, 12, 14, 16, 18, 20)) +
  theme_ipsum() +
  # theme_bw() + 
  ylab("Proportion of Social Class") +
  xlab("Generation") + 
  ggtitle("Number of Social Class Increases Over Time") + 
  theme(plot.title = element_text(size = 14, hjust = 0.5))
# dev.off()
