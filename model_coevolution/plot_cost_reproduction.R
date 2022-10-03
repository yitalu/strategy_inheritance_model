# this script visualize the relationship between starvation threshold and wealth/class # nolint

rm(list = ls())

# parameters
wealth <- seq(0, 9)
cost_base <- 0

# a logarithmic function
cost <- cost_base + log(wealth + 1)
# cost <- cost_base + log(0.2 * wealth + 1)
# cost <- cost_base + 0.5 * log(wealth + 1)

disposable_income <- wealth - cost

pdf(file = "./figures/cost_reproduction.pdf")
plot(cost ~ wealth, type = "l", ylim = c(0, max(wealth)), ylab = "Reproduction Cost", xlab = "Wealth", main = "Reproduction Cost Increases with Wealth Class", lty=2)
points(cost ~ wealth, pch = 20)
abline(a = 0, b = 1)
points(c(0:9) ~ wealth, pch = 20)
grid(col = "gray", lty = "dashed")
legend(0.2, 9, legend=c("total wealth", "reproduction cost"), col=c("black", "black"), lty=c(1,2), cex=0.8, text.font=2)
dev.off()




# plot Disposable Income
disposable_income <- wealth - cost
plot(disposable_income ~ wealth, type = "l", xlab = "Class", ylab = "Disposable Income", ylim = c(0, max(wealth)))
points(disposable_income ~ wealth, pch = 19)
abline(a = 0, b = 1)
grid(col = "gray", lty = "dashed")
