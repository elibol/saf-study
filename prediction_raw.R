force_by_race <- function(year){
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
  model <- lm(pf~race, data=data)
  # summary(model)
  
  names = make.names(c("A Asian/Pacific Islander",
                       "B Black",
                       "I American Indian/Alaskan native",
                       "P Black-Hispanic",
                       "Q White-Hispanic",
                       "U Not Listed",
                       "W White",
                       "X Unknown",
                       "Z Other"))
  
  results = predict(model, data.frame(race=c("A", "B", "I", "P", "Q", "U", "W", "X", "Z")))
  x <- vector(mode = "list", length = length(results))
  
  for(i in 1:length(x)){
    x[[i]] <- c(results[i], names[i])
  }
  
  sorted_names <- names[order(results, decreasing=TRUE)]
  return(sorted_names)
}

force_by_race("2003")
