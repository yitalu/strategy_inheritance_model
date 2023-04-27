# Load Data ----
source("./analysis/load_data.R")
d <- d1c0
# d <- d1c0[generation == max(d1c0$generation), ]



# Plot Strategy Density Over Time -----------------------------------------
d[generation == 0, strategy]
dens(d[generation == max(d$generation), strategy])


# tiff(file = "./figures/strategy_over_time_hazard_society_1.tiff", width = 2000, height = 1600, res = 300)
ggplot(data=d, aes(x=strategy, group = generation)) +
  geom_density(adjust=0.5, color="#69b3a2") +
  theme_ipsum() +
  facet_wrap(~generation) +
  theme(
    # legend.position="none",
    panel.spacing = unit(0.5, "lines"),
    axis.ticks.x=element_blank()
  ) + 
  scale_x_continuous(breaks = scales::pretty_breaks(n = 2)) + 
  scale_y_continuous(breaks = scales::pretty_breaks(n = 2)) + 
  xlab("Strategy") +
  ylab("Density") + 
  labs(title="Strategy Distribution Over Time (Hazard = 0.1)", x ="Strategy", y = "Density") +
  theme(plot.title = element_text(size = 14, hjust = 0.5))
# dev.off()

ggplot(data=d[wealth>9], aes(x=strategy, group = generation, fill=generation)) +
  geom_density(adjust=0.5) +
  theme_ipsum() +
  facet_wrap(~generation) +
  theme(
    # legend.position="none",
    panel.spacing = unit(0.5, "lines"),
    axis.ticks.x=element_blank()
  ) + 
  xlab("Strategy") +
  ylab("Density")
