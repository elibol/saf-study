# Logistic Regression Sample

# setwd("~/GDrive/Harvard/E-139_Stats/project/saf-study")
library(data.table)

# Gets the probabilities out of the Logistical Model Coefficients
getProbs <- function(logisticModel) {
  intercept <- coefficients(logisticModel)[1]
  odds<- coefficients(logisticModel) + intercept
  odds[1]<- intercept
  probs<- exp(odds) / (exp(odds) + 1)
  print(probs)
}

i = 2008

fulltable <- data.table()
for (i in 2008:2014) {
  f.in<-paste0("arst_force_data/", i, ".force.csv")
  data <- read.csv(f.in)
  fulltable<-rbind(fulltable, data)
}
hist(fulltable$year)

## FULL TABLE REGRESSION ##
fit.force<-glm(FORCE_USED~race, data=fulltable, family=binomial())
summary(fit.force)
getProbs(fit.force)


fulltable[,.N, by='race']

## TABLE WITHOUT RACE UNKNOWN REGRESSION ##
table <- fulltable[race!='U']
fit.force<-glm(FORCE_USED~race, data=table, family=binomial())
summary(fit.force)
getProbs(fit.force)
conf<-confint.lm(fit.force, level=(1-0.05/8) )
intercept<-conf[1,1:2]
conf[2:7,1] <- conf[2:7,1] + intercept[1]
conf[2:7,2] <- conf[2:7,2] + intercept[2]
conf.probs<- exp(conf) / (exp(conf) + 1) * 100
conf.probs

## Arrests Made
table <- fulltable[race!='U']
fit.arst <- glm(arstmade~race, family=binomial(), data=table)
summary(fit.arst)
getProbs(fit.arst)
conf<-confint.lm(fit.arst, level=(1-0.05/8) )
intercept<-conf[1,1:2]
conf[2:7,1] <- conf[2:7,1] + intercept[1]
conf[2:7,2] <- conf[2:7,2] + intercept[2]
conf.probs<- exp(conf) / (exp(conf) + 1) * 100
conf.probs

# Weapon vs Race
fit.weapon<-glm(HAD_WEAPON~race, data=table, family=binomial())
summary(fit.weapon)
getProbs(fit.weapon)
conf<-confint.lm(fit.weapon, level=(1-0.05/8) )
intercept<-conf[1,1:2]
conf[2:7,1] <- conf[2:7,1] + intercept[1]
conf[2:7,2] <- conf[2:7,2] + intercept[2]
conf.probs<- exp(conf) / (exp(conf) + 1) * 100
conf.probs

fit.forcetoRaceweapon<-glm(FORCE_USED~race*HAD_WEAPON, data=table, family=binomial())
getProbs(fit.forcetoRaceweapon)


# Force to weapon
fit.forcetoweapon<-glm(FORCE_USED~HAD_WEAPON, data=table, family=binomial())
summary(fit.forcetoweapon)
getProbs(fit.forcetoweapon)
conf<-confint.lm(fit.forcetoweapon)
conf[2,] = conf[2,] + conf[1,] # add intercept
conf.probs<- exp(conf) / (exp(conf) + 1) * 100
conf.probs
