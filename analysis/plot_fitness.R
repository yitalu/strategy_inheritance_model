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
num_strategy <- length(unique(d[generation == 0, strategy])) # 11
num_ancestor_wealth <- 10

ancestor_strategy <- rep(seq(0, 1, 0.1), num_ancestor_wealth)

ancestor_wealth <- rep(0, num_strategy)
for (i in 1:9) {
  ancestor_wealth <- c(ancestor_wealth, rep(i, num_strategy))
}

num_descendant <- rep(0, length(ancestor_strategy))
num_ancestor <- rep(0, length(ancestor_strategy))
k <- 1
for (i in 0:9) {
  for (j in 0:10) {
    num_descendant[k] <- d[generation == max(d$generation) & `ancestor class` == i & strategy == j/10, .N]
    num_ancestor[k] <- d[generation == 0 & `ancestor class` == i & strategy == j/10, .N]
    k <- k + 1
  }
}

num_descendant <- num_descendant / num_ancestor

d_density2d <- data.frame(ancestor_wealth = ancestor_wealth, ancestor_strategy = ancestor_strategy, num_descendant = num_descendant)


tiff(file = "./figures/descendant_number.tiff", width = 2000, height = 1600, res = 300)
ggplot(d_density2d, aes(ancestor_wealth, ancestor_strategy, fill= num_descendant)) + 
  geom_tile() + 
  # scale_fill_gradient(low="white", high="blue") + 
  # scale_fill_distiller(palette = "RdPu") + 
  scale_fill_viridis(discrete=F, alpha = 0.7, name = "Descendant Number") +
  theme_ipsum() + 
  labs(title="Descendant Numbers for Ancestor with Different \n Combinations of Wealth and Strategy", x ="Ancestor Wealth", y = "Ancestor Strategy") + 
  theme(plot.title = element_text(hjust = 0.5, size = 14))
dev.off()