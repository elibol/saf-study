# Logistic Regression Sample

source_folder <- "/Users/saz/GDrive/Harvard/E-139_Stats/project/saf-study/force_data/"
  
i = 2008
f.in<-paste0(source_folder, i, ".force.csv")
data <- read.csv(f.in)
fit<-glm(FORCE_USED~race, data=data, family=binomial())
summary(fit)