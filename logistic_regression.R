# Logistic Regression Sample

#setwd("~/GDrive/Harvard/E-139_Stats/project/saf-study")

i = 2014
f.in<-paste0("force_data/", i, ".force.csv")
data <- read.csv(f.in)

fit<-glm(FORCE_USED~race, data=data, family=binomial())
summary(fit)