# Logistic Regression Sample

#setwd("~/GDrive/Harvard/E-139_Stats/project/saf-study")

i = 2014
f.in<-paste0("force_data/", i, ".force.csv")
  data <- read.csv(f.in)


fit.force<-glm(FORCE_USED~race, data=data, family=binomial())
summary(fit.force)
# Find probability
odds<-coefficients(fit.force)
probs <- exp(odds) / (exp(odds) + 1)
print(probs)


fit.weapon<-glm(HAD_WEAPON~race, data=data, family=binomial())
summary(fit.weapon)
# Find probability
odds<-coefficients(fit.weapon)
probs <- exp(odds) / (exp(odds) + 1)
print(probs)


fit.forcetoweapon<-glm(FORCE_USED~race*HAD_WEAPON, data=data, family=binomial())
# Find probability
odds<-coefficients(fit.forcetoweapon)
probs <- exp(odds) / (exp(odds) + 1)
print(probs)


data2<-read.csv(f.in)
data2$white<-data$race=="W" | data$race=="Q"
data2$black<-data$race=="B" | data$race=="P"


fit.color <- glm(FORCE_USED~(white+black)*HAD_WEAPON, data=data2, family=binomial())
summary(fit.color)
# Find probability
odds<-coefficients(fit.color)
probs <- exp(odds) / (exp(odds) + 1)
print(probs)

