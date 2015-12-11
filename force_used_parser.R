# SET TO FALSE TO PROCESS ALL THE DATA
TEST_MODE <- FALSE;

# Start Clock for time reporting
start_time <- proc.time()
data <- NULL
source_folder <- "/Users/saz/GDrive/Harvard/E-139_Stats/project/stats_project/source files/"

## FUNCTIONS ##
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

run <- function(i) {
  f.in<-paste0(source_folder, i, ".csv")
  data <- read.csv(f.in)
  
  data <- add_derived_fields(data)
  data <- subset(data,select=c("year", "race", "FORCE_USED", "HAD_WEAPON"))
  
  # Write
  dest_folder <- paste0(source_folder, 'dest/')
  if (!dir.exists(dest_folder)) {
    dir.create(dest_folder)
  }
  f.out<- paste0(dest_folder, i, '.force.csv')
  write.csv(data, file=f.out)
}

### RUN ###

if (TEST_MODE) {
  ## OPTION B. For testing
  i <- 2004
  print(paste("Processing",i,"..."))
  run(i)
  print("...Processed.")
} else {
  ## Load All Data
  for (i in 2003:2014) {
    #paste0 concatenates strings without space, paste adds space
    print(paste("Processing",i,"..."))
    run(i)
    print("...Processed.")
    print(i)
  }
}

# - Stop clock and report
print(paste("Duration:",proc.time() - start_time))
