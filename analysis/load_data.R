# Load Package ----
# library("reticulate")
library("data.table")
library("rethinking")
# library("ggplot2")
# library("hrbrthemes")
# library("viridis")
# library("lattice")



# Run Model ----
# use_virtualenv("./env", required = TRUE)
# py_run_file("./model_strategy_inheritance/case_egalitarian_random.py")




# Load Data ----
d_ER <- fread("./data/data_case_egalitarian_random.csv")
d_EI <- fread("./data/data_case_egalitarian_inherited.csv")
d_MR <- fread("./data/data_case_market_random.csv")
d_MI <- fread("./data/data_case_market_inherited.csv")
d_EIH <- fread("./data/data_case_egalitarian_inherited_horizontal.csv")
