# Load Data ----
source("./analysis/load_data.R")
d <- d1c0
# d <- d1c1



# Plot Fertility vs Wealth -------------------------------------------------
# tiff(file = "./figures/fertility_vs_wealth.tiff", width = 2000, height = 1600, res = 300)
plot(jitter(d$fertility) ~ jitter(d$wealth), ylab = "Fertility", xlab = "Wealth", main = "Wealthier Individuals Give Less Births", pch=20, cex=0.8, col=alpha("#69b3a2", 0.4), cex.main=1, cex.lab=0.9)
grid()
# dev.off()



# Plot Fertility vs Wealth Over Time ---------------------------------------
# tiff(file = "./figures/fertility_vs_wealth_over_time_mutation_5.tiff", width = 2000, height = 1600, res = 300)
# tiff(file = "./figures/fertility_vs_wealth_over_time_3steps.tiff", width = 2000, height = 800, res = 300)
ggplot(data=d, aes(x=wealth, y=fertility)) +
  # geom_point(color="#69b3a2", alpha=0.4, size=1, position = position_jitter(seed = 1, width = 0.2)) + 
  geom_point(color="#69b3a2", alpha=0.99, size=1, position = position_jitter(seed = 1, width = 0.2)) + 
  theme_ipsum() +
  facet_wrap(~generation) +
  theme(
    # legend.position="none",
    panel.spacing = unit(0.5, "lines"),
    axis.ticks.x=element_blank()
  ) + 
  labs(title="Fertility vs Wealth Over Time", x ="Wealth", y = "Fertility") +
  # labs(x ="Wealth", y = "Fertility") + 
  theme(plot.title = element_text(size = 14, hjust = 0.5)) + 
  scale_x_continuous(breaks = seq(0, 100, 5)) + 
  scale_y_continuous(breaks = seq(0, 16, 2))
# dev.off()
