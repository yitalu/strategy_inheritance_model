# Stratify Wealth ---------------------------------------------------------
d_strata <- d[, .(generation, strategy, fertility, wealth)]
d_strata <- d_strata[, class:=rep(0, nrow(d_strata))]
colnames(d_strata)
strata_max <- floor(max(d$wealth)/strata_interval)

for (i in 0:strata_max) {
  d_strata[wealth >= strata_interval * i & wealth < strata_interval * (i+1), ]$class <- i
}