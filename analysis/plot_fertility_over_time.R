# Load Data ----
source("./analysis/load_data.R")
d <- d1c0
# d <- d1c1



# Plot Fertility Density Over Time -----------------------------------------
d[generation == 0, fertility]
dens(d[generation == 0, fertility])
dens(d[generation == g_max, fertility])

ggplot(data=d, aes(x=fertility, group = generation, fill=generation)) +
  geom_density(adjust=0.5) +
  theme_ipsum() +
  facet_wrap(~generation) +
  theme(
    # legend.position="none",
    panel.spacing = unit(0.5, "lines"),
    axis.ticks.x=element_blank()
  ) + 
  xlab("Fertility") +
  ylab("Density")

ggplot(data=d[wealth>9], aes(x=fertility, group = generation, fill=generation)) +
  geom_density(adjust=0.5) +
  theme_ipsum() +
  facet_wrap(~generation) +
  theme(
    # legend.position="none",
    panel.spacing = unit(0.5, "lines"),
    axis.ticks.x=element_blank()
  ) + 
  xlab("Fertility") +
  ylab("Density")