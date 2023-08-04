# Load Data ----
source("./analysis/load_data.R")

# plot(jitter(d$strategy) ~ jitter(d$wealth), ylab = "Strategy", xlab = "Wealth", main = "Wealthier Individuals Allocate Less to Reproduction", pch=20, cex=0.8, col=alpha("#69b3a2", 0.4), cex.main=1, cex.lab=0.9)
# grid()

opar <- par(no.readonly=TRUE)
cases <- c("d_ER", "d_EI")
generations <- seq(0, min(max(d_ER$generation), max(d_EI$generation)), 1)
# par(mfrow=c(length(cases), length(generations)))
max_wealth <- max(d_ER$wealth, d_EI$wealth)

# Create the layout
pdf("./figures/strategy_wealth_ER_EI.pdf", width = 6*2.414, height = 6)
layout(matrix(seq(1, length(generations) * 2, 1), nrow = 2, byrow = TRUE))
# layout.show()
par(oma=c(5, 5, 5, 4), mar=c(0, 0, 0, 0))
for (i in 1:2) {
  d <- get(cases[i])
  for (j in generations) {
    plot(    # try smoothScatter
      d$wealth[d$generation == j],
      d$strategy[d$generation == j],
      axes = FALSE,
      xlim = c(0, max_wealth),
      ylim = c(0, 1),
      # main = paste("Generation ", j+1, sep = ""),
      pch = 20,
      cex = 0.8,
      # col = alpha("red", 0.4), 
      col = alpha("#69b3a2", 0.8), 
      # colramp = colorRampPalette(c("white", '#69b3a2')),
      # colramp = colorRampPalette(c("white", 'pink')),
      # bandwidth = 0.2
    )
    box()
    if (j == 0) axis(2)
    if (i == 2) axis(1)
    if (i == 1) title(main = paste("Generation ", j+1, sep = ""), line = -1.5)
    if (i == 1 & j == min(generations)) mtext("Egalitarian \n Random", side = 1, line = -5, adj = 0.95, cex = 0.8, font = 3)
    if (i == 2 & j == min(generations)) mtext("Egalitarian \n Inherited", side = 1, line = -5, adj = 0.95, cex = 0.8, font = 3)
    # if (i == 1 & j == min(generations)) mtext("Egalitarian Inherited", side = 1, line = -5, adj = 0.95, cex = 0.8, font = 3)
    # if (i == 2 & j == min(generations)) mtext("Egalitarian Inherited \n + Horizontal", side = 1, line = -5, adj = 0.95, cex = 0.8, font = 3)
    grid(col = "gray", lty = "dotted", lwd = 0.8)
  }
}
title(main = "Strategy vs Wealth over Generation", outer=TRUE, line = 2, cex.main=2)
title(xlab = "Wealth", ylab = "Strategy", outer=TRUE, adj = 0.5, cex.lab=1.2)
# mtext("Egalitarian Random", side = 2, outer = T, line = 5, adj=0.75)
# mtext("Egalitarian Inherited", side = 2, outer = T, line = 5, adj=0.25)
# mtext("Wealth", side=1, outer=T, line=1)
# mtext("Strategy", side=2, outer=T, line=-1)
# par(opar)
dev.off()




# Using split.screen() ----------------------------------------------------

# Example 1
m <- rbind(c(0.1, 0.55, 0.55, 1), c(0.55, 1, 0.55, 1), c(0.1, 0.55, 0.1, 0.55), c(0.55, 1, 0.1, 0.55))
split.screen(m)
for (i in 1:4) {
  screen(i)
  par(mar = c(0, 0, 0, 0))
  plot(1, axes = FALSE, type = "n")
  box()
  if (i %in% c(3, 4)) axis(1)
  if (i %in% c(1, 3)) axis(2)
}
close.screen(all.screens = TRUE)


# Example 2
n <- rbind(c(0.1, 0.292, 0.1, 0.98), c(0.312, 0.95, 0.1, 0.98))
split.screen(n)
screen(1)
par(mar = c(0, 0, 0, 0))
plot(1:30, rnorm(30), xaxs = "i", ylim = c(-3, 3), xaxt = "n")
axis(1, at = seq(0, 30, 20))

screen(2)
par(mar = c(0, 0, 0, 0))
plot(1:100, rnorm(100), xaxs = "i", ylim = c(-3, 3), yaxt = "n", col = "red")

close.screen(all.screens = TRUE)




# By coplot ---------------------------------------------------------------
coplot(strategy ~ wealth | factor(generation), data = d_MI, rows = 1, overlap = 0.5, col = "red", bg = "pink", pch = 21, bar.bg = c(fac = "light blue"), show.given = TRUE, xlim = c(0, 40))




# By xyplot from Lattice --------------------------------------------------
mypanel <- function(x, y) {
  panel.xyplot(x, y, pch = 19, col = "#69b3a2", alpha = 0.6)
  # panel.rug(x, y, col = "#69b3a2")
  panel.grid(h=-1, v=-1)
  panel.abline(v = 10, lty=2, col="darkgreen")
  # panel.text(5, 0.5, "ER")
}

graph_ER <- xyplot(strategy ~ wealth | generation, data = d_ER, 
                   main="Strategy vs Wealth over Generations", 
                   xlab = "Wealth", ylab = "Strategy", layout = c(max(d_ER$generation)+1, 1), col = "#69b3a2", alpha = 0.6, 
                   panel = mypanel, aspect = 1.5, 
                   strip = strip.custom(bg="lightgrey", par.strip.text=list(col="black", cex=.8, font=3)))
graph_EI <- xyplot(strategy ~ wealth | generation, data = d_EI,
                   main="",
                   xlab = "Wealth", ylab = "Strategy", layout = c(max(d_EI$generation)+1, 1), col = "#69b3a2", alpha = 0.6, 
                   panel = mypanel, aspect = 1.5, 
                   strip = strip.custom(bg="lightgrey", par.strip.text=list(col="black", cex=.8, font=3)))
plot(graph_ER, split = c(1, 1, 1, 2))
plot(graph_EI, split = c(1, 2, 1, 2), newpage = FALSE)
# mtext(side=3, line=3, at=-0.07, adj=0, cex=1, text = "ER")
# mtext(side=3, line=3, at=-0.07, adj=0, cex=1, text = "EI")


# text(5, 10, "Model predicts \n confirm case.")
