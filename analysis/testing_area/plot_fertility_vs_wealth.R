# Load Data ----
source("./analysis/load_data.R")
d1c0_linked <- fread("./data/testing_area/data_d1c0_linked.csv")
d1c0_unlinked <- fread("./data/testing_area/data_d1c0_unlinked.csv")
d1c0_unlinked_0.5 <- fread("./data/testing_area/data_d1c0_unlinked_mutate0.5.csv")
d1c1_cultural_cost <- fread("./data/testing_area/data_d1c1_cultural_cost.csv")
d0c1_cultural_cost <- fread("./data/testing_area/data_d0c1_cultural_cost.csv")
d1c0_h_05 <- fread("./data/testing_area/data_d1c0_h05.csv")
d1c0_h_02 <- fread("./data/testing_area/data_d1c0_h02.csv")
d1c0_h_08 <- fread("./data/testing_area/data_d1c0_h08.csv")

d <- d1c0_linked
d <- d1c0_unlinked
d <- d1c0_unlinked_0.5
d <- d1c1_cultural_cost
d <- d0c1_cultural_cost
d <- d1c0_h_05
d <- d1c0_h_02
d <- d1c0_h_08
colnames(d)[1] <- "inheritance"
# d <- d1c1



# Plot Fertility vs Wealth -------------------------------------------------
# tiff(file = "./figures/fertility_vs_wealth.tiff", width = 2000, height = 1600, res = 300)
plot(jitter(d$fertility) ~ jitter(d$wealth), ylab = "Fertility", xlab = "Wealth", main = "Wealthier Individuals Give Less Births", pch=20, cex=0.8, col=alpha("#69b3a2", 0.4), cex.main=1, cex.lab=0.9)
grid()
# dev.off()



# Plot Fertility vs Wealth Over Time ---------------------------------------
tiff(file = "./figures/fertility_vs_wealth_inherited_independent.tiff", width = 2000, height = 1600, res = 300)
ggplot(data=d, aes(x=wealth, y=fertility)) +
  geom_point(color="#69b3a2", alpha=0.4, size=1, position = position_jitter(seed = 1, width = 0.2)) + 
  theme_ipsum() +
  facet_wrap(~generation) +
  theme(
    # legend.position="none",
    panel.spacing = unit(0.5, "lines"),
    axis.ticks.x=element_blank()
  ) + 
  labs(title="Fertility vs Wealth Over Time \n (Inherited Strategy)", x ="Wealth", y = "Fertility") + 
  theme(plot.title = element_text(size = 14, hjust = 0.5))
dev.off()
