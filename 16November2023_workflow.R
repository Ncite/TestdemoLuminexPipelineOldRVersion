#16November2023
#Test the demoLuminexPipeline before testing the LuminexR pipeline.
#

#Load libraries.
library(tidyverse)
library(usethis)
library(devtools)


# Load installr
library(installr)

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