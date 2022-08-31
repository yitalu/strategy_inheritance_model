# this script visualize the relationship between starvation threshold and wealth/class # nolint

rm(list = ls())

# parameters
wealth <- seq(0, 14)
threshold_base <- 1

# a logarithmic function
threshold <- threshold_base + log(wealth + 1)

# pdf(file = "./figures/class_dependent_living_cost.pdf")
plot(threshold ~ wealth, type = "l", ylim = c(0, max(wealth)), ylab = "Living Cost", xlab = "Wealth", main = "Class-Dependent Cost of Living")
points(threshold ~ wealth, pch = 19)
abline(a = 0, b = 1)
grid(col = "gray", lty = "dashed")
# dev.off()


# plot Disposable Income
disposable_income <- wealth - threshold
plot(disposable_income ~ wealth, type = "l", xlab = "Class", ylab = "Disposable Income", ylim = c(0, max(wealth)))
points(disposable_income ~ wealth, pch = 19)
abline(a = 0, b = 1)
grid(col = "gray", lty = "dashed")
