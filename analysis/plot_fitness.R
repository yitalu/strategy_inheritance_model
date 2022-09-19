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
ancestor_number <- rep(0, max(d$`ancestor class`) + 1)
for (i in 0:max(d$`ancestor class`)) {
  descendant_number[i+1] <- d[generation == g_max & `ancestor class` == i, .N]
  ancestor_number[i+1] <- d[generation == 0 & wealth == i, .N]
}

d_barplot <- data.frame(
  ancestor_class = seq(min(d$`ancestor class`), max(d$`ancestor class`), 1), 
  descendant_number_per_ancestor = descendant_number / ancestor_number
  )


tiff(file = "./figures/descendant_number_by_wealth.tiff", width = 2000, height = 1600, res = 300)
ggplot(d_barplot, aes(x=ancestor_class, y=descendant_number_per_ancestor)) + 
  geom_bar(stat = "identity", fill="#69b3a2") + 
  scale_x_continuous(breaks = scales::pretty_breaks(n = 8)) + 
  theme_bw() + 
  labs(title="Wealthier Ancestors Have More Descendants", x ="Ancestor Wealth", y = "Descendant Per Individual") + 
  theme(plot.title = element_text(size = 14, hjust = 0.5))
dev.off()



# Plot Number of Descendant by Strategy -----------------------------------
dens(d[generation == 0, strategy])
num_strategy <- length(unique(d[generation == 0, strategy]))

seq(0, 10, 1)
descendant_number <- rep(0, num_strategy)
ancestor_number <- rep(0, num_strategy)
for (i in seq(0, 10, 1)) {
  descendant_number[i+1] <- d[generation == g_max & strategy == i/10, .N]
  ancestor_number[i+1] <- d[generation == 0 & strategy == i/10, .N]
}

d_barplot <- data.frame(
  ancestor_strategy = unique(d[generation == 0, strategy]), 
  descendant_number_per_strategy = descendant_number / ancestor_number
)

# tiff(file = "./figures/descendant_number_by_strategy.tiff", width = 2000, height = 1600, res = 300)
ggplot(d_barplot, aes(x=ancestor_strategy, y=descendant_number_per_strategy)) + 
  geom_bar(stat = "identity", fill="#69b3a2") + 
  scale_x_continuous(breaks = scales::pretty_breaks(n = 8)) + 
  theme_bw() + 
  labs(title="Ancestors Who Adopt Low Strategy Have More Descendants", x ="Ancestor Strategy", y = "Descendant for Each Strategy") + 
  theme(plot.title = element_text(size = 14, hjust = 0.5))
# dev.off()



# Plot Number of Descendant by Ancestor Class and Strategy ----------------
num_strategy <- length(unique(d[generation == 0, strategy]))

descendant_number <- rep(0, (max(d$`ancestor class`) + 1) * num_strategy)
ancestor_number <- rep(0, (max(d$`ancestor class`) + 1) * num_strategy)

for (i in 0:(length(ancestor_number)-1)) {
  descendant_number[i+1] <- d[generation == g_max & `ancestor class` == i, .N]
  ancestor_number[i+1] <- d[generation == 0 & wealth == i, .N]
}

library(hexbin)
library(RColorBrewer)
x <- d[generation==g_max, wealth]
y <- d[generation==g_max, strategy]

# 2d histogram with default option
bin <- hexbin(d$wealth, d$strategy, xbins=40)
my_colors=colorRampPalette(rev(brewer.pal(11,'Spectral')))
plot(bin, main="" , colramp=my_colors , legend=F )

ggplot(d, aes(x=x, y=y) ) +
  geom_bin2d(bins = 20) +
  theme_bw()

ggplot(d, aes(x=x, y=y) ) +
  geom_bin2d(bins = 20) +
  scale_fill_continuous(type = "viridis") +
  theme_bw()

# Hexbin chart with default option
ggplot(d, aes(x=x, y=y) ) +
  geom_hex() +
  theme_bw()

# Bin size control + color palette
# tiff(file="./figures/fertility_parents.tiff", width = 2000, height = 1600, res = 300)
ggplot(d, aes(x=wealth, y=strategy) ) +
  geom_hex(bins = 20) +
  # scale_fill_continuous(type = "viridis") + 
  # scale_fill_distiller(palette = 1, direction=-1) + 
  scale_fill_distiller(palette = "Spectral", direction=-1) +
  labs(title = "Fertility of Parents Across Generations", x = "Wealth", y = "Strategy", fill = "Fertility") + 
  scale_x_continuous(breaks = round(seq(min(d$wealth) - 1, max(d$wealth), by = 2),1)) +
  scale_y_continuous(breaks = round(seq(min(d$strategy) - 0.1, max(d$strategy), by = 0.2),1)) + 
  theme_bw() + 
  theme(plot.title = element_text(hjust = 0.5))
# dev.off()

