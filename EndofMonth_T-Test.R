setwd("~/GDrive/Harvard/E-139_Stats/project/stats_project/source files/day")
library("data.table")


i <- 2013
for (i in 2010:2013) {
  table<- data.table()
  data = read.csv(paste0(i, ".day.csv"))
  table<-rbind(table, data)
}
head(table)
beforeTable <- table[dayOfMonth<22,.N, by='month']
afterTable <- table[dayOfMonth>=22,.N, by='month']
before <- beforeTable$N
after <- afterTable$N * 3

t.test(before, after)
