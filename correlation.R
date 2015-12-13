# install.packages("ggplot2")
# install.packages("reshape2")
# install.packages("Hmisc")
library(ggplot2)
library(reshape2)
library(Hmisc)

data.variables <- read.csv(file="data/variables_desc.csv", head=TRUE, sep=",")
data.variables = data.variables[c("Variable", "Label")]

year = 2014
fn = paste("data/", year, ".csv", sep="")
data.raw <- read.csv(file=fn, head=TRUE,sep=",")

data.raw$pf = with(data.raw, pf_hands  == 'Y' | pf_hands == 1 |
                             pf_wall   == 'Y' | pf_wall == 1 |
                             pf_grnd   == 'Y' | pf_grnd == 1 |
                             pf_drwep  == 'Y' | pf_drwep == 1 |
                             pf_ptwep  == 'Y' | pf_ptwep == 1 |
                             pf_baton  == 'Y' | pf_baton == 1 |
                             pf_hcuff  == 'Y' | pf_hcuff == 1 |
                             pf_pepsp  == 'Y' | pf_pepsp == 1 |
                             pf_other  == 'Y' | pf_other == 1)

# pf <- c("pf_hands", "pf_wall", "pf_grnd", "pf_drwep", "pf_ptwep", "pf_baton", "pf_hcuff", "pf_pepsp", "pf_other")
# data = data.raw[,!(names(data.raw) %in% pf)]

keeps <- c("pf", "race", "sex",
           "age", "weight", "haircolr", 
           "eyecolor", "build", "othfeatr")
keeps <- c(as.vector(data.variables$Variable), "pf")
data = data.raw[keeps]

columns <- seq(1, length(keeps), 1)
vars <- names(data)[columns]

indexmat = expand.grid(columns, columns)
indexmat = t(matrix(c(indexmat$Var1, indexmat$Var2), ncol=2, nrow=length(indexmat$Var1)))
out <- apply(indexmat, 2, function(x){
  chisq.test(table(data[,x[1]],data[,x[2]]),correct=F)$p.value
})

A = matrix(out, nrow=length(columns), ncol=length(columns))
dimnames(A) = list(vars, vars)
A

# out <- apply(combn(columns,2),2,function(x){
#   chisq.test(table(data[,x[1]],data[,x[2]]),correct=F)$p.value
# })
# out <- cbind(as.data.frame(t(combn(vars,2))),out)

melted.A = melt(A)
# melted.A = melted.A[order(melted.A$value),]
# melted.A$Var1 = factor(melted.A$Var1, levels = melted.A$Var1[order(melted.A$value)])
# melted.A$Var2 = factor(melted.A$Var2, levels = melted.A$Var2[order(melted.A$value)])
# melted.A$value = melted.A$value[order(melted.A$value)]
# ord = order(melted.A$value, decreasing=TRUE)

# melted.A = melted.A[melted.A$value > 0.0 & melted.A$value < 0.9,]
qplot(x=Var1, y=Var2, data=melted.A, fill=value, geom="tile")

# qplot(x=Var1, y=Var2, data=melt(cor(data, use="p")), fill=value, geom="tile") +
#       scale_fill_gradient2(limits=c(-1, 1))
