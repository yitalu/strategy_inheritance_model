# this script visualize the relationship between offspring survival (success/rate) and fertility allocation # nolint

rm(list = ls())

# parameters
max_num_offspring <- 14
fertility_allocation <- seq(0, 14)
survival_birth <- 0.95
death_birth <- 1 - survival_birth

# Option 1: death rate as a linear function of fertility allocation
# death_rate <- (1 - survival_birth) + survival_birth * fertility_allocation / max_num_offspring # nolintr

# Option 2: death rate as a concave function of fertility allocation
death_rate <- 1 - survival_birth ^ fertility_allocation

# Option 3:
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
hazard <- 0.5
f <- seq(0, 15)
s00 <- exp(0 * (-f/15))
s02 <- exp(0.2 * (-f/15))
s05 <- exp(hazard * (-f/15))
s10 <- exp(1 * (-f/15))

# pdf(file="./figures/survival_rates.pdf", width = 6, height = 4.3)
# pdf(file="./figures/survival_rates.pdf")
# plot(s02 ~ f, type = "l", lty=1, main = "Per Kid Survival Rate Decreases with Parent Fertility", xlab = "Fertility", ylab = "Survival Rate for Each Child (rs)", ylim=c(0, 1))
plot(s02 ~ f, type = "l", lty=1, main = "Per Kid Survival Rate Decreases with Parent Fertility", xlab = expression('Fertility  f'[i]), ylab = expression('Survival Rate for Each Child  r'[s]), ylim=c(0, 1))
lines(s05 ~ f, type = "l", lty=2)
lines(s10 ~ f, type = "l", lty=4, lwd=1.5)
lines(s00 ~ f, type = "l", lty=5, lwd=1.5)
grid(col = "gray", lty = "dotted")
legend(12, 0.2, legend=c("0.2", "0.5", "1"), col=c("black", "black", "black"), lty=c(1,2,4), cex=0.8, text.font=2, title="Hazard Level")
# dev.off()


# # pdf(file="./figures/survived_offspring.pdf")
# # plot(s02 ~ f, type = "l", lty=1, main = "Per Kid Survival Rate Decreases with Parent Fertility", xlab = "Fertility", ylab = "Survival Rate for Each Child (rs)", ylim=c(0, 1))
# plot(s02*f ~ f, type = "l", lty=1, main = "Per Kid Survival Rate Decreases with Parent Fertility", xlab = expression('Fertility  f'[i]), ylab = expression('Survived Offspring n'[i]))
# lines(s05*f ~ f, type = "l", lty=2)
# lines(s10*f ~ f, type = "l", lty=4, lwd=1.5)
# grid(col = "gray", lty = "dotted")
# legend(0.5, 12, legend=c("0.2", "0.5", "1"), col=c("black", "black", "black"), lty=c(1,2,4), cex=0.8, text.font=2, title="Hazard Level")
# # dev.off()


grid()
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