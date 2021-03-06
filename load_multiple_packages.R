########################### FUNCTION TO INSTALL ALL THE NEEDED PACKAGES AT ONCE ########################### 
# INPUT: a vector of package names
#   checks if packages are already installed or installs them
#   loads all the selected packages
#   outputs a string to signal packages installed correctly or not
# Doesn't work with packages which are not in the selected repositories or that require installation via github, biocLite, etc.

load_multiple_lib<-function(needed_pkgs){
  
  setRepositories(ind=c(1:6))
  if(length(needed_pkgs[!(needed_pkgs%in%rownames(installed.packages()))])){
    
    pkgs_to_install<-as.vector(needed_pkgs[!(needed_pkgs%in%rownames(installed.packages()))])
    cat(paste(paste(as.vector(needed_pkgs[(needed_pkgs%in%rownames(installed.packages()))]),collapse = ", ")," already installed","\n"))
    
    for(i in pkgs_to_install){
      cat(paste("Loading/installing",i))
      if(!require(i)){
        install.packages(i, dependencies = TRUE)
      } 
    }
    
  }else{
    cat("All needed packages are already installed")
  }
  
  exit_status<-sapply(needed_pkgs, require, character.only = TRUE)
  if(length(exit_status[!exit_status])) cat(paste("Unable to install/load",paste(names(exit_status)[exit_status==F],collapse=", ")))
  
}

############### TEST

needed_pkgs<-c("ggplot2", "randomForest", "FactoMineR",
                "factoextra", "glmnet", "ape")
load_multiple_lib(needed_pkgs)
