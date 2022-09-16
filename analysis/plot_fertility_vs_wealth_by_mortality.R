# Look at Fertility vs Wealth in last generations, for each value of mortality




# Function ----------------------------------------------------------------
wilcox.report <- function(x, y){
  test <- wilcox.test(x, y)
  W <- test$statistic # W statistics
  Z <- qnorm(test$p.value/2) # Z statistics
  p <- test$p.value # p value
  N <- length(x)+length(y) # for unpaired x y
  r <- abs(Z)/sqrt(N) # effect size
  return(data.frame(w_statistics = W, z_statistics = Z, p_value = p, effect_size = r, row.names = NULL))
}



# Load Data ----
source("./analysis/load_data.R")
d0 <- d1c0_h00
d3 <- d1c0_h03
d6 <- d1c0_h06
d9 <- d1c0_h09



# Prepare Data Frame ------------------------------------------------------
d0 <- d0[generation == max(d0$generation), .(fertility, wealth)]
d3 <- d3[generation == max(d3$generation), .(fertility, wealth)]
d6 <- d6[generation == max(d6$generation), .(fertility, wealth)]
d9 <- d9[generation == max(d9$generation), .(fertility, wealth)]

d0[, mortality := rep(0, nrow(d0))]
d3[, mortality := rep(0.3, nrow(d3))]
d6[, mortality := rep(0.6, nrow(d6))]
d9[, mortality := rep(0.9, nrow(d9))]

d_combined <- rbind(d0, d3, d6, d9)



# Plot Fertility vs Wealth by Mortality -----------------------------------
ggplot(data=d_combined, aes(x=wealth, y=fertility, group = mortality, fill=mortality)) +
  geom_point(color="#69b3a2", alpha=0.4, size=1, position = position_jitter(seed = 1, width = 0.2)) +
  theme_ipsum() +
  facet_wrap(~mortality) +
  theme(
    legend.position="none",
    panel.spacing = unit(0.5, "lines"),
    axis.ticks.x=element_blank()
  ) + 
  xlab("Wealth Strata") +
  ylab("Fertility")



# Statistics --------------------------------------------------------------
d0[, mean(fertility)]
d3[, mean(fertility)]
d6[, mean(fertility)]
d9[, mean(fertility)]

d0[wealth > 9, mean(fertility)]
d3[wealth > 9, mean(fertility)]
d6[wealth > 9, mean(fertility)]
d9[wealth > 9, mean(fertility)]

t.test(d3[, fertility], d9[, fertility])

wilcox.test(d0[, fertility], d3[, fertility])
wilcox.test(d0[, fertility], d6[, fertility])
wilcox.test(d0[, fertility], d9[, fertility])
wilcox.test(d3[, fertility], d9[, fertility])
wilcox.report(d0[, fertility], d9[, fertility])

fit <- lm(fertility ~ mortality, data = d_combined)
summary(fit)
plot(fit)