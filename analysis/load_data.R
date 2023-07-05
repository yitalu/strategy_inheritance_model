# Load Package ----
library("data.table")
library("rethinking")
library("ggplot2")
library("hrbrthemes")
# library("viridis")



# Load Data ----
# d1c0 <- fread("./data/data_d1c0.csv")
# d1c0 <- fread("./data/testing_area/data_d1c0.csv")
# colnames(d1c0)[1] <- "inheritance"
d <- fread("./data/testing_area/data_fine.csv")
# d <- fread("./data/testing_area/data_coarse.csv")
colnames(d)[1] <- "inheritance"


# d1c0_h00 <- fread("./data/data_d1c0_h00.csv")
# d1c0_h03 <- fread("./data/data_d1c0_h03.csv")
# d1c0_h06 <- fread("./data/data_d1c0_h06.csv")
# d1c0_h09 <- fread("./data/data_d1c0_h09.csv")

# d1c1 <- fread("./data/data_d1c1.csv")
# colnames(d1c1)[1] <- "inheritance"
