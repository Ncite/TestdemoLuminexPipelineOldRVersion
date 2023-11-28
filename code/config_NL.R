#config_NL.R file
#
#Please note this is a configuration file to set-up the paths to the folders and
#the files used in and during the demoLuminexPipeline (LuminexPipeline).
#
#The following steps are done in the config_NL.R file.
#First, add user initials (i.e., analyst initials).
#Second, set investigation (i.e., study name).
#Third, check and create directories (i.e., a "rds", "csv", and the "output" directory 
#in the current working directory).
#Fourth, set path to raw Luminex data files and save in an object called:
#"directory_data" that will be used as the input argument (parameter) for the
#R functions called in the demoLuminexPipeline. Please note that the object
#"directory_data" will be used as the input argument and the output object of
#the R functions called throughout the demoLuminexPipeline. Therefore, the object
#"directory_data" will change according to each step’s R functions purpose
#(accordingly).
#Fifth, set path to md5sums file and save in an object called:
#"directory_md5sums".
#Sixth, create a summary list that will serve as the final output report to
#the analyst. The summary list will be saved in an object called "summaryList"
#and a .RData file called "summaryList.RData".
#Seven, read in "dataset_project.rds" file from .rds folder, if it exists and
#save it in an object called: "dataset_project" in the R global environment.
#Eight, set path to metadata files saved in the "rds" folder and read in the
#metadata files.
#Step1: Please add user initials (i.e., analyst initials).
user <- "NL" 

#Step2: Set investigation (i.e., study name: "R01AI128765").
#Remove hash (i.e., "#") to activate investigation AND add "#" to deactivate 
#investigation.
investigation <-  "R01AI128765"
#investigation <- "nexgen"
#investigation <- "mph_hiv"

#Step3:Check and create directories (i.e., "rds", "csv", and the "output" directory).
#Step3: Check and create rds directory.
tmp <- sum(grepl("./rds", list.dirs()))
if(tmp == 0){
  if (!dir.exists("./rds")) {dir.create("./rds")}
}

#Step3: Check and create csv directory.
tmp <- sum(grepl("./csv", list.dirs()))
if(tmp == 0){
  if (!dir.exists("./csv")) {dir.create("./csv")}
}

#Step3: Check and create Microsoft Excel directory.
# tmp <- sum(grepl("./xlsx", list.dirs()))
# if(tmp == 0){
#   if (!dir.exists("./xlsx")) {dir.create("./xlsx")}
# }

#Step3: Check and create output directory.
tmp <- sum(grepl("./output", list.dirs()))
if(tmp == 0){
  if (!dir.exists("./output")) {dir.create("./output")}
}

#Step4: Set path to data files.
#Remove hash (i.e., "#") to activate the path to the data files.
# directory_data <- "/home/elizna/Documents/Data/Luminex_scramlx/R01AI128765"
# directory_data <- "/home/elizna/Documents/Data/Luminex_scramlx/NexGen"
#directory_data <- "/home/elizna/Documents/Data/MPH_HIV_forNDC"

directory_data <- "C:/Users/ncite/OneDrive - Stellenbosch University/Documents/demoLuminexPipeline/data/R01AI128765"
#directory_data <- "C:/Users/ncite/OneDrive - Stellenbosch University/Documents/demoLuminexPipeline/data/NexGen/NexGenDataAll"
#directory_data <- "C:/Users/ncite/OneDrive - Stellenbosch University/Documents/demoLuminexPipeline/data/MPH_HIV_forNDC"

#Please insert your own path to the data files for each data set used and set the 
#path by removing the hash ("#" sign).
#directory_data <-
#directory_data <-
#directory_data <-

#Step5: Set path to md5sums.
#directory_md5sums <- ""

#Step6: Create the summary list (report) called "summaryList".
tmp <- sum(grepl("^summaryList$", list.files("./output")))

if(tmp == 0){
  summaryList <- list()
  summaryList[["Investigation"]] <- investigation

  save(summaryList, file = "./output/summaryList.RData")
}

#Step7: Read in dataset_project from .rds, if it exists.
tmp <- sum(grepl("dataset_project", list.files("./rds/")))
if(tmp == 1){
  dataset_project <- read_rds("./rds/dataset_project.rds")
}

#Step8: Read in metadata.
## Set path to metadata
metadata_path <- "./rds/metadata.rds"
