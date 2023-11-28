#27November2023
#Test the demoLuminexPipeline before testing the LuminexR pipeline.
#

library(here)
getwd()

#Set working directory to "code":
setwd(here::here("code"))

# install.packages("versions")
# library("versions")
# 
# # install earlier versions of checkpoint and devtools
# install.versions(c('devtools', 'openxlsx', 'usethis', 'forcats', 'dplyr', 'purrr', 'readr', 'tidyr', 'tibble', 'ggplot2', 'tidyverse', 'stringr', 'magrittr', 'lubridate'), c('2.4.4', '4.2.5', '2.1.6', '0.5.1', '1.0.9', '0.3.4', '2.1.2', '1.2.0', '3.1.8', '3.3.6', '1.3.2', '1.4.0', '2.0.3', '1.8.0'))
# 
# install.versions(c('devtools', 'openxlsx', 'usethis', 'forcats', 'dplyr'), c('2.4.4', '4.2.5', '2.1.6', '0.5.1', '1.0.9'))
# 
# install.versions(c('devtools'), c('2.4.4'))

install.packages("cli")
library("cli")

#Load libraries.
library(tidyverse)
library(usethis)
library(devtools)


# Load installr
library(installr)

install.versions(c('devtools'), c('2.4.4'))
install.versions(c('tidyverse'), c('1.3.2'))

install.version('devtools', '2.4.4')
install.version('tidyverse', '1.3.2')

#Install R package from local drive.
#Instal the demoLuminexPipeline R package from the C drive.
install.packages("C:/Users/ncite/demoluminex/demoLuminexPipeline/demoLuminexPipeline.Rproj", repos=NULL, type="source")

#Install remote R packages.
# 1.	Install demoLuminexPipeline R package from GitHub:
#   Please note this is a private repository (repo) therefore the following steps are required
# (i.e., run in the R Console):
  #Set config
  usethis::use_git_config(user.name = "Ncite", user.email = "ndc@sun.ac.za")
#Go to github page to generate token
usethis::create_github_token() 

#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 #16 November 2023

#Paste the personal access token (PAT) into pop-up that follows:
credentials::set_github_pat(504631559)
#Now remotes::install_github() will work
remotes::install_github("Ncite/demoLuminexPipeline/demoLuminexPipeline", auth_token = gh::gh_token(), dependencies=TRUE, force = TRUE)





#Set config
usethis::use_git_config(user.name = "Ncite", user.email = "ndc@sun.ac.za")
#Go to github page to generate token.
#usethis::create_github_token()
#Save the token in a save place.
#credentials::set_github_pat(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)

usethis::gh_token_help()
create_github_token()
#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 #24October2023
#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 #25October2023
#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 #30October2023
#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
gitcreds::gitcreds_set()
devtools::install_github("Ncite/demoLuminexPipeline/demoLuminexPipeline", auth_token = gh::gh_token())


#Remote install
remotes::install_github("demoLuminexPipeline", auth_token = gh::gh_token(), dependencies=TRUE)
