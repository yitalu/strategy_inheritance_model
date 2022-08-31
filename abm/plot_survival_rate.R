# this script visualize the relationship between offspring survival (success/rate) and fertility allocation # nolint

rm(list = ls())

# parameters
max_num_offspring <- 14
fertility_allocation <- seq(0, 14)
survival_birth <- 0.95
death_birth <- 1 - survival_birth

# option 1: death rate as a linear function of fertility allocation
# death_rate <- (1 - survival_birth) + survival_birth * fertility_allocation / max_num_offspring # nolintr

# option 2: death rate as a concave function of fertility allocation
death_rate <- 1 - survival_birth ^ fertility_allocation

# option 3:
s <- 0.9 - 0.005 * fertility_allocation - 0.008 * fertility_allocation^2

plot(s ~ fertility_allocation)


# Option 4:
fertility_allocation <- seq(0, 14)
s <- -0.99 + 1.23 * fertility_allocation - 0.06 * fertility_allocation^2

s <- -0.37 + 1.03 * fertility_allocation - 0.04 * fertility_allocation^2

s <- s / fertility_allocation

plot(s ~ fertility_allocation)
grid()


# Option 5:
odd <- c(12, 14.5, 11, 9, 8, 7, 6, 5.5, 4.5, 4, 3.8, 3.5, 3)
rate <- 1 - (1 / odd)
fertility_allocation <- seq(1, 13)

lm(rate ~ fertility_allocation + I(fertility_allocation ^ 2))
plot(rate ~ fertility_allocation)

fertility_allocation <- seq(1, 14)
odd <- c(0.9, 1.5, 2.5, 3.5, 4, 4.5, 5.5, 6, 6.5, 7, 7.5, 8, 8.5, 9)
odd <- odd/fertility_allocation
plot(odd ~ fertility_allocation)

# 6
f <- seq(0, 14)
s <- exp(0.5 * (-f/14))
plot(s ~ f)
plot((s * f) ~ f)
grid()

# plot the relationship
# pdf(file = "./figures/density_dependent_death.pdf")
plot(death_rate ~ fertility_allocation, type = "l", xlab = "Fertility Allocation", ylab = "Death Rate", main = "Density-Dependent Death Rate", ylim = c(0, 1))
points(death_rate ~ fertility_allocation, pch = 19)
grid(col = "gray", lty = "dotted")
# dev.off()

# compare effects of different survival rates
# survival_birth <- seq(0, 1, 0.1)
# for (s in survival_birth) {
#    death_rate <- 1 - s ^ fertility_allocation
#    lines(death_rate ~ fertility_allocation, lty = s * 10)
# }