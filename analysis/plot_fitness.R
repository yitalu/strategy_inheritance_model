# Load Data ----
source("./analysis/load_data.R")
d <- d1c0
# d <- d1c1



# Plot Number of Descendant by Ancestor -----------------------------------------------
g_max <- max(d$generation)
dens(d[generation == g_max, `ancestor class`])
table(d[generation == g_max, `ancestor class`])
hist(d[generation == g_max, `ancestor class`], breaks = 10)


descendant_number <- rep(0, max(d$`ancestor class`) + 1)
for (i in 0:max(d$`ancestor class`)) {
  descendant_number[i+1] <- d[generation == g_max & `ancestor class` == i, .N]
}

d_barplot <- data.frame(
  ancestor_class = seq(min(d$`ancestor class`), max(d$`ancestor class`), 1), 
  descendant_number = descendant_number
  )


tiff(file = "./figures/descendant_number.tiff", width = 2000, height = 1600, res = 300)
ggplot(d_barplot, aes(x=ancestor_class, y=descendant_number)) + 
  geom_bar(stat = "identity") + 
  scale_x_continuous(breaks = scales::pretty_breaks(n = 8)) + 
  theme_bw()
dev.off()
