# Load Data ----
source("./analysis/load_data.R")
d <- d1c0
# d <- d1c1




# Plot Strategy vs Wealth -------------------------------------------------
plot(jitter(d$strategy) ~ jitter(d$wealth), ylab = "Strategy", xlab = "Wealth Strata", pch=20, cex=0.8, col=alpha("#69b3a2", 0.4),)
grid()

ggplot(data=d, aes(x=wealth, y=strategy, group = wealth, fill=wealth)) +
  # geom_violin() +
  # theme(legend.position="none") +
  geom_point(position = position_jitter(seed = 1, width = 0.2)) + 
  # geom_jitter(shape=16, position=position_jitter(0.2)) +
  theme_bw() +
  xlab("Wealth Strata") +
  ylab("Strategy")




# Plot Strategy vs Wealth Over Time ---------------------------------------
ggplot(data=d, aes(x=wealth, y=strategy)) +
  geom_point(color="#69b3a2", alpha=0.4, size=1, position = position_jitter(seed = 1, width = 0.2)) + 
  theme_ipsum() +
  facet_wrap(~generation) +
  theme(
    # legend.position="none",
    panel.spacing = unit(0.5, "lines"),
    axis.ticks.x=element_blank()
  ) + 
  xlab("Wealth Strata") +
  ylab("Strategy")