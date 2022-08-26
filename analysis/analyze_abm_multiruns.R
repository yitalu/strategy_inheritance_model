rm(list = ls())
# install.packages("hexbin")
library(data.table)
library(rethinking)
# library(lattice)
# library(ggplot2)
# library(hexbin)
library(RColorBrewer)




# Read Data ---------------------------------------------------------------
# d <- read.csv("./data/data.csv")
d <- fread("./data/data.csv")
d <- fread("./data/data_test.csv")
d <- fread("./data/data_ecological.csv")
d <- fread("./data/data_cultural.csv")
colnames(d)[1] <- "inheritance"


# Growth of Population ----------------------------------------------------
tiff(file="./figures/population_growth.tiff", width = 2000, height = 1600, res = 300)
pdf(file = "./figures/population_growth_death.pdf")
population_grwoth <- d[, .(.N), by = generation]
plot(population_grwoth, type = "l", main = "Population Growth", xlab = "Generation", ylab = "Population Size")
grid(col = "gray", lty = "dotted")
dev.off()


pdf(file = "./figures/population_growth_cost_multiruns.pdf")
plot(NULL, main = "Population Growth", xlab = "Generation", ylab = "Population Size", xlim = c(0, max(d$generation)), ylim = c(0, max(d[, .(.N), by = .(generation, run)]$N)))
grid(col = "gray", lty = "dotted")
for (i in 0:max(d$run)) {
  points(d[run == i, .(.N), by = generation], pch = 19, col=col.alpha(rangi2,0.4))
}
lines( d[, .N, by = .(generation, run)][, mean(N), by = generation] )
dev.off()


# generation <- 0:tail(d$generation, 1)
# population_size <- rep(0, length(generation))
# 
# for (i in generation) {
#   population_size[i+1] <- nrow(d[generation == i, ])
# }
# 
# plot(generation, population_size, type = "l", main = "Population Growth", xlab = "Generation", ylab = "Population Size")
# 
# table(d$generation)
# plot(table(d$generation))




# Wealth and Strategy Distribution ----------------------------------------
tiff(file="./figures/wealth_distribution_ancestor.tiff", width = 2000, height = 1600, res = 300)
pdf(file = "./figures/wealth_distribution_ancestor_death.pdf")
hist(d[generation == 0, wealth], breaks = 100, main = "Distribution of Wealth (Ancestors)", xlab = "Wealth") # ancestor
grid(col = "gray", lty = "dotted")
dev.off()

pdf(file = "./figures/wealth_distribution_ancestor_death_multiruns.pdf")
plot(density(d[generation == 0, wealth, by = run][run == 0, wealth]), col = "gray",  main = "Distribution of Wealth (Ancestors)", xlab = "Wealth", ylim = c(0, 0.1))
grid(col = "gray", lty = "dotted")
for (i in 1:max(d$run)) {
  lines(density(d[generation == 0, wealth, by = run][run == i, wealth]), col = "gray")
}
dev.off()


tiff(file="./figures/wealth_distribution_last_gen.tiff", width = 2000, height = 1600, res = 300)
pdf(file = "./figures/wealth_distribution_last_gen_death.pdf")
hist(d[generation == tail(d$generation, 1), wealth], breaks = 100, main = "Distribution of Wealth (Last Generation)", xlab = "Wealth") # last generation
grid(col = "gray", lty = "dotted")
dev.off()

pdf(file = "./figures/wealth_distribution_last_gen_death_multiruns.pdf")
plot(density(d[generation == tail(d$generation, 1), wealth, by = run][run == 0, wealth]), col = "gray",  main = "Distribution of Wealth (Last Generation)", xlab = "Wealth", ylim = c(0, 0.6))
grid(col = "gray", lty = "dotted")
for (i in 1:max(d$run)) {
  lines(density(d[generation == tail(d$generation, 1), wealth, by = run][run == i, wealth]), col = "gray")
}
dev.off()



tiff(file="./figures/strategy_distribution_ancestor.tiff", width = 2000, height = 1600, res = 300)
pdf(file = "./figures/strategy_distribution_ancestor_death.pdf")
hist(d[generation == 0, strategy], breaks = 100, main = "Distribution of Strategies (Ancestors)", xlab = "Strategy") # ancestor
grid(col = "gray", lty = "dotted")
dev.off()

pdf(file = "./figures/strategy_distribution_ancestor_death_multiruns.pdf")
plot(density(d[generation == 0, strategy, by = run][run == 0, strategy]), col = "gray",  main = "Distribution of Strategies (Ancestors)", xlab = "Strategy", ylim = c(0, 1.5))
grid(col = "gray", lty = "dotted")
for (i in 1:max(d$run)) {
  lines(density(d[generation == 0, strategy, by = run][run == i, strategy]), col = "gray")
}
dev.off()



tiff(file="./figures/strategy_distribution_last_gen.tiff", width = 2000, height = 1600, res = 300)
pdf(file = "./figures/strategy_distribution_last_gen_death.pdf")
hist(d[generation == tail(d$generation, 1), strategy], breaks = 100, main = "Distribution of Strategies (Last Generation)", xlab = "Strategy") # last generation
grid(col = "gray", lty = "dotted")
dev.off()

pdf(file = "./figures/strategy_distribution_last_gen_death_multiruns.pdf")
plot(density(d[generation == tail(d$generation, 1), strategy, by = run][run == 0, strategy]), col = "gray",  main = "Distribution of Strategies (Ancestors)", xlab = "Strategy", ylim = c(0, 90))
grid(col = "gray", lty = "dotted")
for (i in 1:max(d$run)) {
  lines(density(d[generation == tail(d$generation, 1), strategy, by = run][run == i, strategy]), col = "gray")
}
dev.off()




tiff(file="./figures/fertility_distribution_ancestor.tiff", width = 2000, height = 1600, res = 300)
pdf(file = "./figures/fertility_distribution_ancestor_death.pdf")
hist(d[generation == 0, fertility], breaks = 100, main = "Fertilities of Ancestors", xlab = "Fertility") # ancestor
grid(col = "gray", lty = "dotted")
dev.off()

pdf(file = "./figures/fertility_distribution_ancestor_death_multiruns.pdf")
plot(density(d[generation == 0, fertility, by = run][run == 0, fertility]), col = "gray",  main = "Fertilities of Ancestors", xlab = "Fertility", ylim = c(0, 0.5))
grid(col = "gray", lty = "dotted")
for (i in 1:max(d$run)) {
  lines(density(d[generation == 0, fertility, by = run][run == i, fertility]), col = "gray")
}
dev.off()


tiff(file="./figures/fertility_distribution_last_gen.tiff", width = 2000, height = 1600, res = 300)
pdf(file = "./figures/fertility_distribution_last_gen_death.pdf")
hist(d[generation == tail(d$generation, 1), fertility], breaks = 100, main = "Fertilities of the Last Generation", xlab = "Fertility") # last generation
grid(col = "gray", lty = "dotted")
dev.off()

pdf(file = "./figures/fertility_distribution_last_gen_death_multiruns.pdf")
plot(density(d[generation == tail(d$generation, 1), fertility, by = run][run == 0, fertility]), col = "gray",  main = "Fertilities of the Last Generation", xlab = "Fertility", ylim = c(0, 2))
grid(col = "gray", lty = "dotted")
for (i in 1:max(d$run)) {
  lines(density(d[generation == tail(d$generation, 1), fertility, by = run][run == i, fertility]), col = "gray")
}
dev.off()



# Average Strategy Over Generation ----------------------------------------
tiff(file="./figures/strategy_over_generation.tiff", width = 2000, height = 1600, res = 300)
pdf(file = "./figures/strategy_over_generation_death.pdf")
plot(d[, mean(strategy), by = generation], type = "l", main = "Average Strategy Over Generation", xlab = "Generation", ylab = "Average Strategy")
grid(col = "gray", lty = "dotted")
dev.off()

pdf(file = "./figures/strategy_over_generation_death_multiruns.pdf")
plot(NULL, main = "Average Strategy Over Generation", xlab = "Generation", ylab = "Average Strategy", xlim = c(0, max(d$generation)), ylim = c(0.2, 1))
grid(col = "gray", lty = "dotted")
for (i in 0:max(d$run)) {
  points(d[run == i, mean(strategy), by = generation], pch = 19, col=col.alpha(rangi2,0.4))
}
lines( d[, mean(strategy), keyby = generation] )
dev.off()


# Average Fertility Over Generation ---------------------------------------
tiff(file="./figures/fertility_over_generation.tiff", width = 2000, height = 1600, res = 300)
pdf(file = "./figures/fertility_over_generation_death.pdf")
plot(d[, mean(fertility), by = generation], type = "l", main = "Average Fertility Over Generation", xlab = "Generation", ylab = "Average Fertility")
grid(col = "gray", lty = "dotted")
dev.off()

pdf(file = "./figures/fertility_over_generation_death_multiruns.pdf")
plot(NULL, main = "Average Fertility Over Generation", xlab = "Generation", ylab = "Average Fertility", xlim = c(0, max(d$generation)), ylim = c(1, 2.5))
grid(col = "gray", lty = "dotted")
for (i in 0:max(d$run)) {
  points(d[run == i, mean(fertility), by = generation], pch = 19, col=col.alpha(rangi2,0.4))
}
lines( d[, mean(fertility), keyby = generation] )
dev.off()

# fertility_over_generation <- rep(0, max(d$generation) + 1)
# for (i in 0:max(d$generation)) {
#   fertility_over_generation[i+1] <- d[generation == i, mean(fertility)]
# }
# plot(fertility_over_generation, type = "l", main = "Average Fertility over Generation", xlab = "Generation", ylab = "Average Fertility")




# Average Wealth Over Generation ------------------------------------------
tiff(file="./figures/wealth_over_generation.tiff", width = 2000, height = 1600, res = 300)
pdf(file = "./figures/wealth_over_generation_death.pdf")
plot(d[, mean(wealth), by = generation], type = "l", main = "Average Wealth Over Generation", xlab = "Generation", ylab = "Average Wealth")
grid(col = "gray", lty = "dotted")
dev.off()

pdf(file = "./figures/wealth_over_generation_death_multiruns.pdf")
plot(NULL, main = "Average Wealth Over Generation", xlab = "Generation", ylab = "Average Wealth", xlim = c(0, max(d$generation)), ylim = c(0, 10))
grid(col = "gray", lty = "dotted")
for (i in 0:max(d$run)) {
  points(d[run == i, mean(wealth), by = generation], pch = 19, col=col.alpha(rangi2,0.4))
}
lines( d[, mean(wealth), keyby = generation] )
dev.off()



# Average Fertility for Different Wealth ----------------------------------
d <- fread("./data/data_test.csv")
colnames(d)[1] <- "inheritance"

# tiff(file="./figures/fertility_by_wealth.tiff", width = 2000, height = 1600, res = 300)
# pdf(file = "./figures/fertility_by_wealth_death.pdf")
plot(d[, mean(fertility), by = wealth], pch = 19, main = "Average Fertility by Wealth", xlab = "Wealth", ylab = "Average Fertility")
grid(col = "gray", lty = "dotted")
# dev.off()

# pdf(file = "./figures/fertility_by_wealth_death_multiruns.pdf")
plot(NULL, main = "Average Fertility by Wealth", xlab = "Wealth", ylab = "Average Fertility", xlim = c(0, max(d$wealth)), ylim = c(0, 8))
grid(col = "gray", lty = "dotted")
for (i in 0:max(d$run)) {
   points(d[run == i, mean(fertility), by = wealth], pch = 19, col=col.alpha(rangi2,0.4))
}
lines( d[, mean(fertility), keyby = wealth] )
# dev.off()


# single run; generation by generation
plot(NULL, main = "Average Fertility by Wealth in Generations", xlim = c(0, max(d$wealth)), ylim = c(0, 10))
grid(col = "gray", lty = "dotted")
for (i in 0:tail(d$generation, 1)) {
  lines(d[generation == i & run == 0, mean(fertility), keyby = wealth], pch = 19, col="black")
}




# fertility_by_wealth <- rep(0, max(d$wealth) + 1)
# for (i in 0:max(d$wealth)) {
#   fertility_by_wealth[i+1] <- d[wealth == i, mean(fertility)]
# }
# plot(fertility_by_wealth, pch = 19, main = "Average Fertility by Wealth", xlab = "Wealth", ylab = "Average Fertility")




# Average Fertility for Different Wealth; Class Number Effect -------------
d15 <- fread("./data/data_class_number_15_ecological.csv")
d12 <- fread("./data/data_class_number_12_ecological.csv")
d09 <- fread("./data/data_class_number_09_ecological.csv")
d06 <- fread("./data/data_class_number_06_ecological.csv")

d24 <- fread("./data/data_class_number_24_cultural.csv")
d21 <- fread("./data/data_class_number_21_cultural.csv")
d18 <- fread("./data/data_class_number_18_cultural.csv")
d15 <- fread("./data/data_class_number_15_cultural.csv")
d12 <- fread("./data/data_class_number_12_cultural.csv")
d09 <- fread("./data/data_class_number_09_cultural.csv")
d06 <- fread("./data/data_class_number_06_cultural.csv")
my_colors <- colorRampPalette(rev(brewer.pal(11,'Spectral')))
my_color <- my_colors(7)

pdf(file = "./figures/fertility_by_wealth_class_number_effect_ecological.pdf")

plot(NULL, main = "Average Fertility by Wealth", xlab = "Wealth", ylab = "Average Fertility", xlim = c(0, 15), ylim = c(0, 8))
grid(col = "gray", lty = "dotted")

# colnames(d)[1] <- "inheritance"
# for (i in 0:max(d$run)) {
#   points(d[run == i, mean(fertility), by = wealth], pch = 19, col=col.alpha(rangi2,0.4))
# }
# my_color <- display.brewer.pal(n = 8, name = 'Dark2')

lines( d15[, mean(fertility), keyby = wealth], col=alpha(my_color[2], 0.8), lwd = 2)
lines( d12[, mean(fertility), keyby = wealth], col=alpha(my_color[3], 1), lwd = 2.5)
lines( d09[, mean(fertility), keyby = wealth], col=alpha(my_color[6], 0.8), lwd = 2)
lines( d06[, mean(fertility), keyby = wealth], col=alpha(my_color[7], 0.8), lwd = 2)

lines( d24[, mean(fertility), keyby = wealth], col=alpha(my_color[1], 0.8), lwd = 2)
lines( d21[, mean(fertility), keyby = wealth], col=alpha(my_color[2], 0.8), lwd = 2)
lines( d18[, mean(fertility), keyby = wealth], col=alpha(my_color[3], 1), lwd = 2.5)
lines( d15[, mean(fertility), keyby = wealth], col=alpha(my_color[4], 1), lwd = 2.5)
lines( d12[, mean(fertility), keyby = wealth], col=alpha(my_color[5], 0.8), lwd = 2)
lines( d09[, mean(fertility), keyby = wealth], col=alpha(my_color[6], 0.8), lwd = 2)
lines( d06[, mean(fertility), keyby = wealth], col=alpha(my_color[7], 0.8), lwd = 2)



# lines( d06[, mean(fertility), keyby = wealth], col=col.alpha(rangi2,0.8))
# lines( d09[, mean(fertility), keyby = wealth], col=col.alpha(rangi2,0.8))
# lines( d12[, mean(fertility), keyby = wealth], col=col.alpha(rangi2,0.8))
# lines( d15[, mean(fertility), keyby = wealth], col=col.alpha(rangi2,0.8))
# lines( d18[, mean(fertility), keyby = wealth], col=col.alpha(rangi2,0.8))
# lines( d21[, mean(fertility), keyby = wealth], col=col.alpha(rangi2,0.8))
# lines( d24[, mean(fertility), keyby = wealth], col=col.alpha(rangi2,0.8))

dev.off()



# Average Strategy for Different Wealth ----------------------------------
tiff(file="./figures/strategy_by_wealth.tiff", width = 2000, height = 1600, res = 300)
pdf(file = "./figures/strategy_by_wealth_death.pdf")
plot(d[, mean(strategy), by = wealth], pch = 20, main = "Average Strategy for Different Wealth", xlab = "Wealth", ylab = "Average Strategy")
grid(col = "gray", lty = "dotted")
dev.off()

pdf(file = "./figures/strategy_by_wealth_death_multiruns.pdf")
plot(NULL, main = "Average Strategy by Wealth", xlab = "Wealth", ylab = "Average Strategy", xlim = c(0, max(d$wealth)), ylim = c(0, 1))
grid(col = "gray", lty = "dotted")
for (i in 0:max(d$run)) {
   points(d[run == i, mean(strategy), by = wealth], pch = 19, col=col.alpha(rangi2,0.4))
}
lines( d[, mean(strategy), keyby = wealth] )
dev.off()


# Average Fertility for Different Strategies ------------------------------
tiff(file="./figures/fertility_by_strategy.tiff", width = 2000, height = 1600, res = 300)
pdf(file = "./figures/fertility_by_strategy_death_multiruns.pdf")
plot(d[, mean(fertility), keyby = strategy], pch=20, main = "Average Fertility for Different Strategies", xlab = "Strategy", ylab = "Average Fertility", col=col.alpha(rangi2,0.8))
grid(col = "gray", lty = "dotted")
dev.off()




# What Strategies Survive? ------------------------------------------------
# at first
hist(d[generation == min(d$generation), strategy], breaks = 50, main = "Strategies Among Ancestors", xlab = "Strategy")
grid(col = "gray", lty = "dotted")

# last generation
hist(d[generation == max(d$generation), strategy], breaks = 50, main = "Strategies in Last Generation", xlab = "Strategy")
grid(col = "gray", lty = "dotted")




# Which ancestors have the most descendants? -------------------------
hist(d[generation == tail(d$generation, 1), `ancestor class`], ylab = "Number of Decendants", xlab = "Ancestor Class", main = "Number of Decendants in the Last Generation")
grid(col = "gray", lty = "dotted")

pdf(file = "./figures/descendant_number_by_ancestor_death.pdf")
plot(d[generation == tail(d$generation, 1), .N, `ancestor class`], pch = 19, main = "Number of Decendants in the Last Generation", xlab = "Ancestor Class", ylab = "Number of Decendants")
grid(col = "gray", lty = "dotted")
dev.off()

pdf(file = "./figures/descendant_number_by_ancestor_death_multiruns.pdf")
plot(NULL, main = "Number of Decendants in the Last Generation", xlab = "Ancestor Class", ylab = "Number of Decendants", xlim = c(0, 15), ylim = c(0, 6000))
grid(col = "gray", lty = "dotted")
for (i in 0:max(d$run)) {
  points(d[generation == tail(d$generation, 1) & run == i, .N, `ancestor class`], pch = 19, col=col.alpha(rangi2,0.4))
}
lines(d[generation == tail(d$generation, 1), .N, keyby = .(`ancestor class`, run)][, mean(N), by = `ancestor class`])
dev.off()



# 2D Density Plots --------------------------------------------------------

x <- d$wealth
y <- d$strategy

# 2d histogram with default option
bin <- hexbin(d$wealth, d$strategy, xbins=40)
my_colors=colorRampPalette(rev(brewer.pal(11,'Spectral')))
plot(bin, main="" , colramp=my_colors , legend=F )

ggplot(d, aes(x=x, y=y) ) +
  geom_bin2d(bins = 20) +
  theme_bw()

ggplot(d, aes(x=x, y=y) ) +
  geom_bin2d(bins = 20) +
  scale_fill_continuous(type = "viridis") +
  theme_bw()

# Hexbin chart with default option
ggplot(d, aes(x=x, y=y) ) +
  geom_hex() +
  theme_bw()

# Bin size control + color palette
# tiff(file="./figures/fertility_parents.tiff", width = 2000, height = 1600, res = 300)
ggplot(d, aes(x=wealth, y=strategy) ) +
  geom_hex(bins = 20) +
  # scale_fill_continuous(type = "viridis") + 
  # scale_fill_distiller(palette = 1, direction=-1) + 
  scale_fill_distiller(palette = "Spectral", direction=-1) +
  labs(title = "Fertility of Parents Across Generations", x = "Wealth", y = "Strategy", fill = "Fertility") + 
  scale_x_continuous(breaks = round(seq(min(d$wealth) - 1, max(d$wealth), by = 2),1)) +
  scale_y_continuous(breaks = round(seq(min(d$strategy) - 0.1, max(d$strategy), by = 0.2),1)) + 
  theme_bw() + 
  theme(plot.title = element_text(hjust = 0.5))
# dev.off()