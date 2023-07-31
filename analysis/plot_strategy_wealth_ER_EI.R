# Load Data ----
# source("./analysis/load_data.R")
d <- d_ER

plot(jitter(d$strategy) ~ jitter(d$wealth), ylab = "Strategy", xlab = "Wealth", main = "Wealthier Individuals Allocate Less to Reproduction", pch=20, cex=0.8, col=alpha("#69b3a2", 0.4), cex.main=1, cex.lab=0.9)
grid()


opar <- par()
par(mfrow=c(2,6))
# par(opar)

cases <- c("ER", "EI")
generations <- seq(0, 5, 1)

par(mfrow=c(length(cases), length(generations)))

for (i in cases) {
  for (j in generations) {
    plot()
  }
}