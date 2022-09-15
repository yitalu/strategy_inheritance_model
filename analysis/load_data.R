# Load Package ----
# library("data.table")
# library("rethinking")
# library("ggplot2")
# library("hrbrthemes")



# Load Data ----
d1c0 <- fread("./data/data_d1c0.csv")
colnames(d1c0)[1] <- "inheritance"

# d1c0_h00 <- fread("./data/data_d1c0_h00.csv")
# d1c0_h03 <- fread("./data/data_d1c0_h03.csv")
# d1c0_h06 <- fread("./data/data_d1c0_h06.csv")
# d1c0_h09 <- fread("./data/data_d1c0_h09.csv")

d1c1 <- fread("./data/data_d1c1.csv")
colnames(d1c1)[1] <- "inheritance"
