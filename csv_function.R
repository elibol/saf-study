#f <- file.choose()

# A. Load All Data

start_time <- proc.time()

# - Process
data <- NULL
for (i in 2003:2014) {
  #paste0 concatenates strings
  path<-paste0("/Users/saz/GDrive/Harvard/E-139_Stats/project/stats_project/source files/",i,".csv")
#   print(paste("Processing ",path,"..."))
#   data = rbind(data, read.csv(path))
#   print("...Processed.")
  
  print(i)
  data = read.csv(path)
  print(names(data))
}

# - Stop clock and report
print(proc.time() - start_time)

# B. For testing
data <- read.csv("/Users/saz/GDrive/Harvard/E-139_Stats/project/stats_project/source files/2014.csv")

data <- read.csv(f)
head(data)

add_derived_fields <- function (data) {
  # Yes can be 1 or Y
  
  return (within(data, {
    # Combine Weapons
    HAD_WEAPON <- 
        pistol=='Y' | pistol==1 |
        riflshot == 'Y' | riflshot == 1 |
        asltweap == 'Y' | asltweap == 1 |
        knifcuti == 'Y' | knifcuti == 1 |
        machgun  == 'Y' | machgun == 1 |
        othrweap == 'Y' | othrweap == 1
    # Combine Force
    FORCE_USED <-
      pf_hands  == 'Y' | pf_hands == 1 |
      pf_wall   == 'Y' | pf_wall == 1 |
      pf_grnd   == 'Y' | pf_grnd == 1 |
      pf_drwep  == 'Y' | pf_drwep == 1 |
      pf_ptwep  == 'Y' | pf_ptwep == 1 |
      pf_baton  == 'Y' | pf_baton == 1 |
      pf_hcuff  == 'Y' | pf_hcuff == 1 |
      pf_pepsp  == 'Y' | pf_pepsp == 1 |
      pf_other  == 'Y' | pf_other == 1
    # Height
    HEIGHT <- ht_feet * 12 + ht_inch
  }))
}