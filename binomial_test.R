# install.packages("aod")
library(aod)

# setwd("~/Desktop/STAT139/FINAL/repo/saf-study")

year = 2014
fn = paste("data/", year, ".csv", sep="")
data <- read.csv(file=fn, head=TRUE,sep=",")

data$pf = with(data, pf_hands  == 'Y' | pf_hands == 1 |
                 pf_wall   == 'Y' | pf_wall == 1 |
                 pf_grnd   == 'Y' | pf_grnd == 1 |
                 pf_drwep  == 'Y' | pf_drwep == 1 |
                 pf_ptwep  == 'Y' | pf_ptwep == 1 |
                 pf_baton  == 'Y' | pf_baton == 1 |
                 pf_hcuff  == 'Y' | pf_hcuff == 1 |
                 pf_pepsp  == 'Y' | pf_pepsp == 1 |
                 pf_other  == 'Y' | pf_other == 1)

# model <- lm(pf~race + sex + age + weight + haircolr + eyecolor, data=data)
model <- glm(pf~race, data=data, family="binomial")

names = make.names(c("A Asian/Pacific Islander",
                     "B Black",
                     "I American Indian/Alaskan native",
                     "P Black-Hispanic",
                     "Q White-Hispanic",
                     "U Not Listed",
                     "W White",
                     "Z Other"))
races = c("A", "B", "I", "P", "Q", "U", "W", "Z")
results = predict(model, data.frame(race=races))
ord = order(results, decreasing=TRUE)
A = matrix(results[ord], nrow=1, ncol=length(names))
dimnames(A) = list(c(year), names[ord])
A

confint(model)
summary(model)
wald.test(b = coef(model), Sigma = vcov(model), Terms = 1:1)

# Probability of stop and frisk on BLACK
x.all <- as.factor(data$race == "B")
length(x.all[x.all==TRUE])/length(x.all)
binom.test(c(length(x.all[x.all==TRUE]), length(x.all[x.all==FALSE])), 
           p = 1.0/length(races),
           alternative = "two.sided")

# Probability of stop and frisk on WHITE
x.all <- as.factor(data$race == "W")
length(x.all[x.all==TRUE])/length(x.all)
binom.test(c(length(x.all[x.all==TRUE]), length(x.all[x.all==FALSE])), 
           p = 1.0/length(races),
           alternative = "greater")

# Probability of force on BLACK
x.pf <- as.factor((data[data$pf,])$race == "B")
# length(x.pf)/length(data$pf)
binom.test(c(length(x.pf[x.pf==TRUE]), length(x.pf[x.pf==FALSE])), 
           p = length(data$pf[data$race == "B"])/length(data$pf),
           alternative = "greater")


# Probability of force on WHITE
x.pf <- as.factor((data[data$pf,])$race == "W")
# length(x.pf)/length(data$pf)
binom.test(c(length(x.pf[x.pf==TRUE]), length(x.pf[x.pf==FALSE])), 
           p = length(data$pf[data$race == "W"])/length(data$pf),
           alternative = "greater")


# Probability of force on HISPANIC BLACK
x.pf <- as.factor((data[data$pf,])$race == "P")
# length(x.pf)/length(data$pf)
binom.test(c(length(x.pf[x.pf==TRUE]), length(x.pf[x.pf==FALSE])), 
           p = length(data$pf[data$race == "P"])/length(data$pf),
           alternative = "greater",
           conf.level = 1-0.05/length(races))


# stuff <- data[data$race=="P",]
# stuff2 <- stuff[stuff$pf == TRUE,]
# length(stuff2$pf) / length(stuff$pf)


# test1 = data[data$race == "W",]
# test2 = test1[test1$pf == TRUE,]
# length(test2$pf) / length(data[data$race == "W",]$pf)

