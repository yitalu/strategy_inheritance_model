# Load Data ----
source("./analysis/load_data.R")
d <- d1c0
# d <- d1c1



# Plot Strategy Density Over Time -----------------------------------------
d[generation == 0, strategy]
dens(d[generation == 0, strategy])
dens(d[generation == g_max, strategy])

ggplot(data=d, aes(x=strategy, group = generation, fill=generation)) +
  geom_density(adjust=0.5) +
  theme_ipsum() +
  facet_wrap(~generation) +
  theme(
    # legend.position="none",
    panel.spacing = unit(1, "lines"),
    axis.ticks.x=element_blank()
  ) + 
  xlab("Strategy") +
  ylab("Density")

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
