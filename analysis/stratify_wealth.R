# Stratify Wealth ---------------------------------------------------------
d_strata <- d[, .(generation, strategy, fertility, wealth)]
strata_max <- floor(max(d$wealth)/strata_interval)

for (i in 0:strata_max) {
  d_strata[wealth >= strata_interval * i & wealth < strata_interval * (i+1), ]$wealth <- i
}