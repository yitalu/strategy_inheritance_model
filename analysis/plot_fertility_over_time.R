# Load Data ----
source("./analysis/load_data.R")
d <- d1c0
# d <- d1c1



# Plot Fertility Density Over Time -----------------------------------------
d[generation == 0, fertility]
dens(d[generation == 0, fertility])
dens(d[generation == g_max, fertility])

# tiff(file = "./figures/fertility_over_time.tiff", width = 2000, height = 1600, res = 300)
ggplot(data=d, aes(x=fertility, group = generation)) +
  geom_density(adjust=0.5, color="#69b3a2") +
  theme_ipsum() +
  facet_wrap(~generation) +
  theme(
    # legend.position="none",
    panel.spacing = unit(0.5, "lines"),
    axis.ticks.x=element_blank()
  ) + 
  scale_x_continuous(breaks = scales::pretty_breaks(n = 4)) + 
  scale_y_continuous(breaks = scales::pretty_breaks(n = 2)) + 
  xlab("Fertility") +
  ylab("Density")
# dev.off()

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