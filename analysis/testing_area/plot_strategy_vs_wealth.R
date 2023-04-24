# Load Data ----
source("./analysis/load_data.R")
d <- d1c0
# d <- d1c0[generation <= 20]



# Plot Strategy vs Wealth -------------------------------------------------
# tiff(file = "./figures/strategy_vs_wealth.tiff", width = 2000, height = 1600, res = 300)
plot(jitter(d$strategy) ~ jitter(d$wealth), ylab = "Strategy", xlab = "Wealth", main = "Wealthier Individuals Allocate Less to Reproduction", pch=20, cex=0.8, col=alpha("#69b3a2", 0.4), cex.main=1, cex.lab=0.9)
grid()
# dev.off()



# Plot Strategy vs Wealth Over Time ---------------------------------------
# tiff(file = "./figures/strategy_vs_wealth_over_time_hazard_9.tiff", width = 2000, height = 1600, res = 300)
ggplot(data=d, aes(x=wealth, y=strategy)) +
  # geom_point(color="#69b3a2", alpha=0.4, size=1, position = position_jitter(seed = 1, width = 0.2)) + 
  geom_point(color="#69b3a2", alpha=0.99, size=1, position = position_jitter(seed = 1, width = 0.2)) + 
  theme_ipsum() +
  facet_wrap(~generation) +
  theme(
    # legend.position="none",
    panel.spacing = unit(0.5, "lines"),
    axis.ticks.x=element_blank()
  ) + 
  labs(title="Strategy vs Wealth Over Time (Hazard = 0.9)", x ="Wealth", y = "Strategy") +
  # labs(x ="Wealth", y = "Strategy") + 
  theme(plot.title = element_text(size = 14, hjust = 0.5)) + 
  # scale_y_continuous(breaks = c(0.1, 0.5, 1)) + 
  scale_y_continuous(breaks = seq(0, 1, 0.2))
# dev.off()
