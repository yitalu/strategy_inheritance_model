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
