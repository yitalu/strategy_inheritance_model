pdf_pareto <- function(x, inequality, minimum){
  if (x >= minimum) {
    probability <- (inequality * (minimum^inequality)) / (x^(inequality+1))
  } else if (x < minimum) {
    probability <- 0
  }
  return(probability)
}

pdf_pareto(10, 0.1, m)

sapply(seq(1, 10, 0.1), FUN = pdf_pareto, inequality = 0.01, minimum = m)

m <- 1
x <- seq(1, 10, 0.1)
y <- sapply(x, pdf_pareto, inequality = 0.1, minimum = m)
plot(y ~ x, type = "l", xlim = c(m, 10), ylim = c(0, 4))
grid()
lines(sapply(x, pdf_pareto, inequality = 0.5, minimum = m) ~ x)
lines(sapply(x, pdf_pareto, inequality = 1, minimum = m) ~ x)
lines(sapply(x, pdf_pareto, inequality = 2, minimum = m) ~ x)
lines(sapply(x, pdf_pareto, inequality = 3, minimum = m) ~ x)



alpha <- 1.5
x <- seq(0, 1000, 1)
A <- log(1000) # population size
y <- A - alpha * x
y <- A - alpha * log(x)

plot(y ~ x, type = 'l')

k <- 1
f_x <- 1 - (k/x)^alpha
plot(f_x ~ x, type = 'l')

plot(y ~ x, type = 'l')

library(sads)

plot(density(rpareto(100, 1.5, scale = 1)))