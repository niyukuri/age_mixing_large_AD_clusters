# Wrapper function which source all others and the main computatinal age.mix.MCAR.MAR.comput script 
# which is the master model

# work.dir <- "/home/niyukuri/Desktop/mastermodeltest" # on PC


work.dir <- "/home/dniyukuri/lustre/age_mixing_narrow_AD_1" # on PCHPC


setwd(paste0(work.dir))


pacman::p_load(snow, parallel, RSimpactCyan, RSimpactHelper, ape, Rsamtools)


wrapper.age.mix <- function(inputvector=inputvector){
  
  # work.dir <- "/home/niyukuri/Desktop/mastermodeltest" # on PC
  
  work.dir <- "/home/dniyukuri/lustre/age_mixing_narrow_AD_1" # on CHPC
  
  
  setwd(paste0(work.dir))
  
  library(RSimpactCyan)
  library(RSimpactHelper)
  library(Rcpp)
  library(ape)
  library(expoTree)
  library(data.table)
  library(readr)
  library(phangorn)
  library(lme4)
  library(nlme)
  library(dplyr)
  library(adephylo)
  library(treedater)
  library(geiger)
  library(picante)
  library(igraph)
  library(phyloTop)
  library(phytools)
  library(Rsamtools)
  library(robustbase)
  library(intergraph)
  library(lubridate)
  library(tidyr)
  
  source("/home/dniyukuri/lustre/age_mixing_narrow_AD_1/needed.functions.RSimpactHelp.R")
  source("/home/dniyukuri/lustre/age_mixing_narrow_AD_1/advanced.transmission.network.builder.R")
  source("/home/dniyukuri/lustre/age_mixing_narrow_AD_1/age.mixing.MCAR.fun.R")
  source("/home/dniyukuri/lustre/age_mixing_narrow_AD_1/age.mixing.MAR.fun.R")
  source("/home/dniyukuri/lustre/age_mixing_narrow_AD_1/age.mix.MCAR.MAR.comput.R")

  
  results.f <- tryCatch(age.mix.MCAR.MAR.comput(inputvector = inputvector),
                        error=function(e) return(rep(NA, 10513)))
  
  return(results.f)
  
}



inputvector <- c(-0.52, -0.05, 2, 0, 3, 0.25, -0.3, -0.1,
                 -1, -90, 0.5, 0.05, -0.14, 5, 7, 12, -1.7) 


reps <- 56


inputmatrix <- matrix(rep(inputvector, reps), byrow = TRUE, nrow = reps)

narrow.AD.age.mix <- simpact.parallel(model = wrapper.age.mix,
                                     actual.input.matrix = inputmatrix,
                                     seed_count = 111,
                                     n_cluster = 56)

write.csv(narrow.AD.age.mix, file = "Results.mcarmar.narrow.AD_1_56_111.csv")






