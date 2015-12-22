end2014 <- read.csv(file.choose(),header=T)
end2014
head(end2014)
names(end2014)

subsetdata1 <- subset(end2014, month <= 12) # This keeps only the data that has real months
head(subsetdata1)

# Now we want to make a binary response if after 21st of the month=1 else 0.
binaryendmonth <- ifelse((subsetdata1$day > 21), 1, 0)
subsetdata2<-cbind(subsetdata1, binaryendmonth)
head(subsetdata2)

binaryfrisk <- ifelse((subsetdata1$frisked == 'Y'), 1, 0)
subsetdata3 <- cbind(subsetdata2, binaryfrisk)
head(subsetdata3)
subsetdata3

# Logistic regression.
endmonth.model <- glm(binaryfrisk ~ binaryendmonth*race, family=binomial(), data=subsetdata3)
summary(endmonth.model)

round(exp(cbind(Estimate=coef(endmonth.model), confint(endmonth.model))), 2) 
