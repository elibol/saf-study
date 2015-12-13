force_by_race <- function(year){
  fn = paste("force_data/", year, ".force.csv", sep="")
  data <- read.csv(file=fn, head=TRUE,sep=",")
  
  # model <- lm(pf~race + sex + age + weight + haircolr + eyecolor, data=data)
  # model <- lm(FORCE_USED~race, data=data)
  model <- glm(FORCE_USED~race, data=data, family = "binomial")
  # summary(model)
  
  names = make.names(c("A Asian/Pacific Islander",
                       "B Black",
                       "I American Indian/Alaskan native",
                       "P Black-Hispanic",
                       "Q White-Hispanic",
#                       "U Not Listed",
                       "W White",
#                       "X Unknown",
                       "Z Other"))
  
  # results = predict(model, data.frame(race=c("A", "B", "I", "P", "Q", "U", "W", "X", "Z")))
  results = predict(model, data.frame(race=c("A", "B", "I", "P", "Q", "W", "Z")))
  # sorted_names <- names[order(results, decreasing=TRUE)]
  # return(sorted_names)
  # return(append(results, year, after=0))
  return(results)
}

start = 2003
end = 2014
num_years = end-start
years = seq(start, end, 1)
names = make.names(c("A Asian/Pacific Islander",
                     "B Black",
                     "I American Indian/Alaskan native",
                     "P Black-Hispanic",
                     "Q White-Hispanic",
                     "W White",
                     "Z Other"))

A <- matrix(nrow=num_years+1, ncol=length(names))
dimnames(A) = list(years, names)
for(i in 1:(num_years+1)){
  print(years[[i]])
  A[i,] <- force_by_race(years[[i]])
}

A

plot_pred <- function(index){
  return(plot(years, A[,index], ylab=names[index]))
}

# layout(matrix(c(1,2), ncol=1, nrow=2), heights=c(1,1))  # put legend on bottom 1/8th of the chart
layout(matrix(c(1)))

# colors = rainbow(length(names), s = 1, v = 1, start = 0, end = max(1, n - 1)/n, alpha = 1)
colors = rainbow(length(names))
plot(years, A[,1], type="l", col=colors[[1]], ylab="Force Used", lwd=2.5, ylim = c(0.13, 0.38))
for(i in 2:length(names)){
  print(names[[i]])
  lines(years, A[, i], col=colors[[i]], lwd=2.5)
}

plot.new()
legend("center", "groups", # places a legend at the appropriate place 
       names, # puts text in the legend
       lty=rep(1, length(names)), # gives the legend appropriate symbols (lines)
       lwd=rep(2.5, length(names)), 
       # y.intersp=0.8,
       col=colors) # gives the legend lines the correct color and width

# xdf = data.frame(x)
