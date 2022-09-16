library(GGally)

# Data set is provided by R natively
data <- iris
head(data)

# Plot
ggparcoord(data, columns = 1:4, groupColumn = 5) + 
  theme_bw()
