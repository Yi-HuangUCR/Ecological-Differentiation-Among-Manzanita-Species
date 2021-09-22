rm(list=ls())

library(biomod2)
library(ecospat)
library(raster)

rm(list = ls())
setwd("C:/Users/gzl02/Desktop/Yi2020Research/Ecological_differentiation_chapter/Esemble_of_Small_models")
ascii_list <- list.files(path = "./", pattern='.asc$', 
                         all.files=TRUE, full.names=FALSE)


asc_rasters <- lapply(ascii_list, raster)
asc_rasters

layers <- stack(asc_rasters)

densiflora <- read.table("./densiflora_Cleaned.txt", header = TRUE)
densiflora_presence <- densiflora[,2:3]
xy <- as.matrix(densiflora_presence)
coordinates(densiflora_presence) <- ~x+y
projection(densiflora_presence) <- CRS('+proj=longlat +datum=WGS84 +no_defs')
crs(layers) <- '+proj=longlat +datum=WGS84 +no_defs'
myBiomodData <- BIOMOD_FormatingData( resp.var = densiflora_presence,
                                             expl.var = layers,
                                             PA.nb.rep = 1,
                                             PA.nb.absences = 10000,
                                             PA.strategy = 'random',
                                             resp.xy = xy,
                                             resp.name = "A_densiflora")

#summary(myBiomodData)
#str(myBiomodData)
#myBiomodOption <- BIOMOD_ModelingOptions()
##extract the pseudo-absences tables for posterior 
library(dplyr)
## function to get PA dataset
get_PAtab <- function(bfd){
  dplyr::bind_cols(
    x = bfd@coord[, 1],
    y = bfd@coord[, 2],
    status = bfd@data.species,
    bfd@PA
  )
}

## function to get background mask
get_mask <- function(bfd){
  bfd@data.mask
}
## get the coordiantes of absences ==> No absences here
(abs.xy <- get_PAtab(myBiomodData) %>% 
    filter(status == 0) %>%
    select(x, y))

## get the coordiantes of pseudo - absences
## all repetition of pseudo absences sampling merged 
(pa.all.xy <- get_PAtab(myBiomodData) %>% 
    filter(is.na(status)) %>%
    select(x, y)) %>%
  distinct()
str(pa.all.xy)
##add column with the species name
pa.all.xy["sp"] <- c("A_densiflora")
pa.all.xy <- pa.all.xy[colnames(pa.all.xy)[c(3,1:2)]]
str(pa.all.xy)

my.ESM <- ecospat.ESM.Modeling( data=myBiomodData,
                                     models=c('MAXENT.Phillips'),
                                     NbRunEval=2,
                                     DataSplit=70,
                                     weighting.score=c("AUC"),
                                     parallel=FALSE)  

my.ESM_EF <- ecospat.ESM.EnsembleModeling(my.ESM,weighting.score=c("AUC"),threshold=0.8)

### Projection of simple bivariate models into new space 
my.ESM_proj_current<-ecospat.ESM.Projection(ESM.modeling.output=my.ESM,
                                            new.env=layers)

### Projection of calibrated ESMs into new space 
my.ESM_EFproj_current <- ecospat.ESM.EnsembleProjection(ESM.prediction.output=my.ESM_proj_current,
                                                        ESM.EnsembleModeling.output=my.ESM_EF)
plot(my.ESM_EFproj_current)

densiflora_ESM <- my.ESM_EFproj_current
names(densiflora_ESM) <- c("A_densiflora")
ESMdir <- "C:/Users/gzl02/Desktop/Yi2020Research/Ecological_differentiation_chapter/Esemble_of_Small_models"
dir.create(file.path(ESMdir, "densiflora_ESM_MSDS"))
dir <- file.path(ESMdir, "densiflora_ESM_MSDS")
writeRaster(densiflora_ESM, file.path(dir, names(densiflora_ESM)),
            bylayer=TRUE, format='GTiff', overwrite=TRUE)



## get the model performance of ESMs 
my.ESM_EF$ESM.evaluations
## get the weights of the single bivariate models used to build the ESMs
my.ESM_EF$weights

ecospat.ESM.VarContrib(my.ESM,my.ESM_EF)

require(devtools)  
#install_github("sjevelazco/MSDM")  
require(MSDM)
require(raster)
require(sp)

densiflora_ESM_MSDS <- MSDM_Posteriori(
  records = densiflora,
  absence = pa.all.xy,
  x = "x",
  y = "y",
  sp = "sp",
  method = c("MCP"),
  dirraster = dir,
  threshold = c("spec_sens"),
  buffer = NULL,
  dirsave = "C:/Users/gzl02/Desktop/Yi2020Research/Ecological_differentiation_chapter/Esemble_of_Small_models/densiflora_ESM_MSDS"
)


###Do the ESM and MSDS to the other endemic species.

##franciscana with only one unique presence
franciscana <- read.table("./franciscana_Cleaned.txt", header = TRUE)
franciscana_presence <- franciscana[,2:3]
xy <- as.matrix(franciscana_presence)
coordinates(franciscana_presence) <- ~x+y
projection(franciscana_presence) <- CRS('+proj=longlat +datum=WGS84 +no_defs')
franciscana_myBiomodData <- BIOMOD_FormatingData( resp.var = franciscana_presence,
                                      expl.var = layers,
                                      PA.nb.rep = 1,
                                      PA.nb.absences = 10000,
                                      PA.strategy = 'random',
                                      resp.xy = xy,
                                      resp.name = "A_franciscana")

##below script(line139-155) failed as Error in modOut[[d1]][[d2]][[d3]][["ModelName"]] : 
#subscript out of bounds
franciscana_my.ESM <- ecospat.ESM.Modeling( data=franciscana_myBiomodData,
                                models=c('MAXENT.Phillips'),
                                NbRunEval=2,
                                DataSplit=70,
                                weighting.score=c("AUC"),
                                parallel=FALSE)  

franciscana_my.ESM_EF <- ecospat.ESM.EnsembleModeling(franciscana_my.ESM,weighting.score=c("AUC"),threshold=0.8)

### Projection of simple bivariate models into new space 
franciscana_my.ESM_proj_current<-ecospat.ESM.Projection(ESM.modeling.output=franciscana_my.ESM,
                                            new.env=layers)

### Projection of calibrated ESMs into new space 
franciscana_my.ESM_EFproj_current <- ecospat.ESM.EnsembleProjection(ESM.prediction.output=franciscana_my.ESM_proj_current,
                                                        ESM.EnsembleModeling.output=franciscana_my.ESM_EF)
plot(franciscana_my.ESM_EFproj_current)


##gabilanensis
gabilanensis <- read.table("./gabilanensis_Cleaned.txt", header = TRUE)
gabilanensis_presence <- gabilanensis[,2:3]
xy <- as.matrix(gabilanensis_presence)
coordinates(gabilanensis_presence) <- ~x+y
projection(gabilanensis_presence) <- CRS('+proj=longlat +datum=WGS84 +no_defs')
gabilaensis_myBiomodData <- BIOMOD_FormatingData( resp.var = gabilanensis_presence,
                                                  expl.var = layers,
                                                  PA.nb.rep = 1,
                                                  PA.nb.absences = 10000,
                                                  PA.strategy = 'random',
                                                  resp.xy = xy,
                                                  resp.name = "A_gabilanensis")

gabilanensis_my.ESM <- ecospat.ESM.Modeling( data=gabilaensis_myBiomodData,
                                            models=c('MAXENT.Phillips'),
                                            NbRunEval=2,
                                            DataSplit=70,
                                            weighting.score=c("AUC"),
                                            parallel=FALSE)  

gabilanensis_my.ESM_EF <- ecospat.ESM.EnsembleModeling(gabilanensis_my.ESM,weighting.score=c("AUC"),threshold=0.8)

### Projection of simple bivariate models into new space 
gabilanensis_my.ESM_proj_current<-ecospat.ESM.Projection(ESM.modeling.output=gabilanensis_my.ESM,
                                                        new.env=layers)

### Projection of calibrated ESMs into new space 
gabilanensis_my.ESM_EFproj_current <- ecospat.ESM.EnsembleProjection(ESM.prediction.output=gabilanensis_my.ESM_proj_current,
                                                                    ESM.EnsembleModeling.output=gabilanensis_my.ESM_EF)
plot(gabilanensis_my.ESM_EFproj_current)


names(gabilanensis_my.ESM_EFproj_current) = "A_gabilanensis"
dir = "C:/Users/gzl02/Desktop/Yi2020Research/Ecological_differentiation_chapter/Esemble_of_Small_models/gabilanensis_ESM_MSDS"
writeRaster(gabilanensis_my.ESM_EFproj_current, file.path(dir, names(gabilanensis_my.ESM_EFproj_current)),
            bylayer=TRUE, format='GTiff', overwrite=TRUE)
## get the coordiantes of pseudo - absences
## all repetition of pseudo absences sampling merged 
(gabilanensis_pa.all.xy <- get_PAtab(gabilaensis_myBiomodData) %>% 
    filter(is.na(status)) %>%
    select(x, y)) %>%
  distinct()
str(gabilanensis_pa.all.xy)
##add column with the species name
gabilanensis_pa.all.xy["sp"] <- c("A_gabilanensis")
gabilanensis_pa.all.xy <- gabilanensis_pa.all.xy[colnames(gabilanensis_pa.all.xy)[c(3,1:2)]]
str(gabilanensis_pa.all.xy)


gabilanensis_ESM_MSDS <- MSDM_Posteriori(
  records = gabilanensis,
  absence = gabilanensis_pa.all.xy,
  x = "x",
  y = "y",
  sp = "sp",
  method = c("MCP"),
  dirraster = dir,
  threshold = c("spec_sens"),
  buffer = NULL,
  dirsave = dir
)


##imbricata
imbricata <- read.table("./imbricata_Cleaned.txt", header = TRUE)
imbricata_presence <- imbricata[,2:3]
xy <- as.matrix(imbricata_presence)
coordinates(imbricata_presence) <- ~x+y
projection(imbricata_presence) <- CRS('+proj=longlat +datum=WGS84 +no_defs')
imbricata_myBiomodData <- BIOMOD_FormatingData( resp.var = imbricata_presence,
                                                  expl.var = layers,
                                                  PA.nb.rep = 1,
                                                  PA.nb.absences = 10000,
                                                  PA.strategy = 'random',
                                                  resp.xy = xy,
                                                  resp.name = "A_imbricata")

imbricata_my.ESM <- ecospat.ESM.Modeling( data=imbricata_myBiomodData,
                                             models=c('MAXENT.Phillips'),
                                             NbRunEval=2,
                                             DataSplit=70,
                                             weighting.score=c("AUC"),
                                             parallel=FALSE)  

imbricata_my.ESM_EF <- ecospat.ESM.EnsembleModeling(imbricata_my.ESM,weighting.score=c("AUC"),threshold=0.8)

### Projection of simple bivariate models into new space 
imbricata_my.ESM_proj_current<-ecospat.ESM.Projection(ESM.modeling.output=imbricata_my.ESM,
                                                         new.env=layers)

### Projection of calibrated ESMs into new space 
imbricata_my.ESM_EFproj_current <- ecospat.ESM.EnsembleProjection(ESM.prediction.output=imbricata_my.ESM_proj_current,
                                                                     ESM.EnsembleModeling.output=imbricata_my.ESM_EF)
plot(imbricata_my.ESM_EFproj_current)


names(imbricata_my.ESM_EFproj_current) = "A_imbricata"
ESMdir <- "C:/Users/gzl02/Desktop/Yi2020Research/Ecological_differentiation_chapter/Esemble_of_Small_models"
dir.create(file.path(ESMdir, "imbricata_ESM_MSDS"))
dir <- file.path(ESMdir, "imbricata_ESM_MSDS")
#dir = "C:/Users/gzl02/Desktop/Yi2020Research/Ecological_differentiation_chapter/Esemble_of_Small_models/imbricata_ESM_MSDS"
writeRaster(imbricata_my.ESM_EFproj_current, file.path(dir, names(imbricata_my.ESM_EFproj_current)),
            bylayer=TRUE, format='GTiff', overwrite=TRUE)
## get the coordiantes of pseudo - absences
## all repetition of pseudo absences sampling merged 
(imbricata_pa.all.xy <- get_PAtab(imbricata_myBiomodData) %>% 
    filter(is.na(status)) %>%
    select(x, y)) %>%
  distinct()
str(imbricata_pa.all.xy)
##add column with the species name
imbricata_pa.all.xy["sp"] <- c("A_imbricata")
imbricata_pa.all.xy <- imbricata_pa.all.xy[colnames(imbricata_pa.all.xy)[c(3,1:2)]]
str(imbricata_pa.all.xy)


imbricata_ESM_MSDS <- MSDM_Posteriori(
  records = imbricata,
  absence = imbricata_pa.all.xy,
  x = "x",
  y = "y",
  sp = "sp",
  method = c("MCP"),
  dirraster = dir,
  threshold = c("spec_sens"),
  buffer = NULL,
  dirsave = dir
)

##montaraensis
montaraensis <- read.table("./montaraensis_Cleaned.txt", header = TRUE)
montaraensis_presence <- montaraensis[,2:3]
xy <- as.matrix(montaraensis_presence)
coordinates(montaraensis_presence) <- ~x+y
projection(montaraensis_presence) <- CRS('+proj=longlat +datum=WGS84 +no_defs')
montaraensis_myBiomodData <- BIOMOD_FormatingData( resp.var = montaraensis_presence,
                                                expl.var = layers,
                                                PA.nb.rep = 1,
                                                PA.nb.absences = 10000,
                                                PA.strategy = 'random',
                                                resp.xy = xy,
                                                resp.name = "A_montaraensis")

montaraensis_my.ESM <- ecospat.ESM.Modeling( data=montaraensis_myBiomodData,
                                          models=c('MAXENT.Phillips'),
                                          NbRunEval=2,
                                          DataSplit=70,
                                          weighting.score=c("AUC"),
                                          parallel=FALSE)  

montaraensis_my.ESM_EF <- ecospat.ESM.EnsembleModeling(montaraensis_my.ESM,weighting.score=c("AUC"),threshold=0.8)

### Projection of simple bivariate models into new space 
montaraensis_my.ESM_proj_current<-ecospat.ESM.Projection(ESM.modeling.output=montaraensis_my.ESM,
                                                      new.env=layers)

### Projection of calibrated ESMs into new space 
montaraensis_my.ESM_EFproj_current <- ecospat.ESM.EnsembleProjection(ESM.prediction.output=montaraensis_my.ESM_proj_current,
                                                                  ESM.EnsembleModeling.output=montaraensis_my.ESM_EF)
plot(montaraensis_my.ESM_EFproj_current)


names(montaraensis_my.ESM_EFproj_current) = "A_montaraensis"
ESMdir <- "C:/Users/gzl02/Desktop/Yi2020Research/Ecological_differentiation_chapter/Esemble_of_Small_models"
dir.create(file.path(ESMdir, "montaraensis_ESM_MSDS"))
dir <- file.path(ESMdir, "montaraensis_ESM_MSDS")
#dir = "C:/Users/gzl02/Desktop/Yi2020Research/Ecological_differentiation_chapter/Esemble_of_Small_models/imbricata_ESM_MSDS"
writeRaster(montaraensis_my.ESM_EFproj_current, file.path(dir, names(montaraensis_my.ESM_EFproj_current)),
            bylayer=TRUE, format='GTiff', overwrite=TRUE)
## get the coordiantes of pseudo - absences
## all repetition of pseudo absences sampling merged 
(montaraensis_pa.all.xy <- get_PAtab(montaraensis_myBiomodData) %>% 
    filter(is.na(status)) %>%
    select(x, y)) %>%
  distinct()
str(montaraensis_pa.all.xy)
##add column with the species name
montaraensis_pa.all.xy["sp"] <- c("A_montaraensis")
montaraensis_pa.all.xy <- montaraensis_pa.all.xy[colnames(montaraensis_pa.all.xy)[c(3,1:2)]]
str(montaraensis_pa.all.xy)


montaraensis_ESM_MSDS <- MSDM_Posteriori(
  records = montaraensis,
  absence = montaraensis_pa.all.xy,
  x = "x",
  y = "y",
  sp = "sp",
  method = c("MCP"),
  dirraster = dir,
  threshold = c("spec_sens"),
  buffer = NULL,
  dirsave = dir
)

##obispoensis
obispoensis <- read.table("./obispoensis_Cleaned.txt", header = TRUE)
obispoensis_presence <- obispoensis[,2:3]
xy <- as.matrix(obispoensis_presence)
coordinates(obispoensis_presence) <- ~x+y
projection(obispoensis_presence) <- CRS('+proj=longlat +datum=WGS84 +no_defs')
obispoensis_myBiomodData <- BIOMOD_FormatingData( resp.var = obispoensis_presence,
                                                expl.var = layers,
                                                PA.nb.rep = 1,
                                                PA.nb.absences = 10000,
                                                PA.strategy = 'random',
                                                resp.xy = xy,
                                                resp.name = "A_obispoensis")

obispoensis_my.ESM <- ecospat.ESM.Modeling( data=obispoensis_myBiomodData,
                                          models=c('MAXENT.Phillips'),
                                          NbRunEval=2,
                                          DataSplit=70,
                                          weighting.score=c("AUC"),
                                          parallel=FALSE)  

obispoensis_my.ESM_EF <- ecospat.ESM.EnsembleModeling(obispoensis_my.ESM,weighting.score=c("AUC"),threshold=0.8)

### Projection of simple bivariate models into new space 
obispoensis_my.ESM_proj_current<-ecospat.ESM.Projection(ESM.modeling.output=obispoensis_my.ESM,
                                                      new.env=layers)

### Projection of calibrated ESMs into new space 
obispoensis_my.ESM_EFproj_current <- ecospat.ESM.EnsembleProjection(ESM.prediction.output=obispoensis_my.ESM_proj_current,
                                                                  ESM.EnsembleModeling.output=obispoensis_my.ESM_EF)
plot(obispoensis_my.ESM_EFproj_current)


names(obispoensis_my.ESM_EFproj_current) = "A_obispoensis"
ESMdir <- "C:/Users/gzl02/Desktop/Yi2020Research/Ecological_differentiation_chapter/Esemble_of_Small_models"
dir.create(file.path(ESMdir, "obispoensis_ESM_MSDS"))
dir <- file.path(ESMdir, "obispoensis_ESM_MSDS")
writeRaster(obispoensis_my.ESM_EFproj_current, file.path(dir, names(obispoensis_my.ESM_EFproj_current)),
            bylayer=TRUE, format='GTiff', overwrite=TRUE)
## get the coordiantes of pseudo - absences
## all repetition of pseudo absences sampling merged 
(obispoensis_pa.all.xy <- get_PAtab(obispoensis_myBiomodData) %>% 
    filter(is.na(status)) %>%
    select(x, y)) %>%
  distinct()
str(obispoensis_pa.all.xy)
##add column with the species name
obispoensis_pa.all.xy["sp"] <- c("A_obispoensis")
obispoensis_pa.all.xy <- obispoensis_pa.all.xy[colnames(obispoensis_pa.all.xy)[c(3,1:2)]]
str(obispoensis_pa.all.xy)


obispoensis_ESM_MSDS <- MSDM_Posteriori(
  records = obispoensis,
  absence = obispoensis_pa.all.xy,
  x = "x",
  y = "y",
  sp = "sp",
  method = c("MCP"),
  dirraster = dir,
  threshold = c("spec_sens"),
  buffer = NULL,
  dirsave = dir
)

##ohloneana
ohloneana <- read.table("./ohloneana_Cleaned.txt", header = TRUE)
ohloneana_presence <- ohloneana[,2:3]
xy <- as.matrix(ohloneana_presence)
coordinates(ohloneana_presence) <- ~x+y
projection(ohloneana_presence) <- CRS('+proj=longlat +datum=WGS84 +no_defs')
ohloneana_myBiomodData <- BIOMOD_FormatingData( resp.var = ohloneana_presence,
                                               expl.var = layers,
                                               PA.nb.rep = 1,
                                               PA.nb.absences = 10000,
                                               PA.strategy = 'random',
                                               resp.xy = xy,
                                               resp.name = "A_ohloneana")

ohloneana_my.ESM <- ecospat.ESM.Modeling( data=ohloneana_myBiomodData,
                                         models=c('MAXENT.Phillips'),
                                         NbRunEval=2,
                                         DataSplit=70,
                                         weighting.score=c("AUC"),
                                         parallel=FALSE)  

ohloneana_my.ESM_EF <- ecospat.ESM.EnsembleModeling(ohloneana_my.ESM,weighting.score=c("AUC"),threshold=0.8)

### Projection of simple bivariate models into new space 
ohloneana_my.ESM_proj_current<-ecospat.ESM.Projection(ESM.modeling.output=ohloneana_my.ESM,
                                                     new.env=layers)

### Projection of calibrated ESMs into new space 
ohloneana_my.ESM_EFproj_current <- ecospat.ESM.EnsembleProjection(ESM.prediction.output=ohloneana_my.ESM_proj_current,
                                                                 ESM.EnsembleModeling.output=ohloneana_my.ESM_EF)
plot(ohloneana_my.ESM_EFproj_current)


names(ohloneana_my.ESM_EFproj_current) = "A_ohloneana"
ESMdir <- "C:/Users/gzl02/Desktop/Yi2020Research/Ecological_differentiation_chapter/Esemble_of_Small_models"
dir.create(file.path(ESMdir, "ohloneana_ESM_MSDS"))
dir <- file.path(ESMdir, "ohloneana_ESM_MSDS")
writeRaster(ohloneana_my.ESM_EFproj_current, file.path(dir, names(ohloneana_my.ESM_EFproj_current)),
            bylayer=TRUE, format='GTiff', overwrite=TRUE)
## get the coordiantes of pseudo - absences
## all repetition of pseudo absences sampling merged 
(ohloneana_pa.all.xy <- get_PAtab(ohloneana_myBiomodData) %>% 
    filter(is.na(status)) %>%
    select(x, y)) %>%
  distinct()
str(ohloneana_pa.all.xy)
##add column with the species name
ohloneana_pa.all.xy["sp"] <- c("A_ohloneana")
ohloneana_pa.all.xy <- ohloneana_pa.all.xy[colnames(ohloneana_pa.all.xy)[c(3,1:2)]]
str(ohloneana_pa.all.xy)


ohloneana_ESM_MSDS <- MSDM_Posteriori(
  records = ohloneana,
  absence = ohloneana_pa.all.xy,
  x = "x",
  y = "y",
  sp = "sp",
  method = c("MCP"),
  dirraster = dir,
  threshold = c("spec_sens"),
  buffer = NULL,
  dirsave = dir
)


##osoensis
osoensis <- read.table("./osoensis_Cleaned.txt", header = TRUE)
osoensis_presence <- osoensis[,2:3]
xy <- as.matrix(osoensis_presence)
coordinates(osoensis_presence) <- ~x+y
projection(osoensis_presence) <- CRS('+proj=longlat +datum=WGS84 +no_defs')
osoensis_myBiomodData <- BIOMOD_FormatingData( resp.var = osoensis_presence,
                                                   expl.var = layers,
                                                   PA.nb.rep = 1,
                                                   PA.nb.absences = 10000,
                                                   PA.strategy = 'random',
                                                   resp.xy = xy,
                                                   resp.name = "A_osoensis")

osoensis_my.ESM <- ecospat.ESM.Modeling( data=osoensis_myBiomodData,
                                             models=c('MAXENT.Phillips'),
                                             NbRunEval=2,
                                             DataSplit=70,
                                             weighting.score=c("AUC"),
                                             parallel=FALSE)  

osoensis_my.ESM_EF <- ecospat.ESM.EnsembleModeling(osoensis_my.ESM,weighting.score=c("AUC"),threshold=0.8)

### Projection of simple bivariate models into new space 
osoensis_my.ESM_proj_current<-ecospat.ESM.Projection(ESM.modeling.output=osoensis_my.ESM,
                                                         new.env=layers)

### Projection of calibrated ESMs into new space 
osoensis_my.ESM_EFproj_current <- ecospat.ESM.EnsembleProjection(ESM.prediction.output=osoensis_my.ESM_proj_current,
                                                                     ESM.EnsembleModeling.output=osoensis_my.ESM_EF)
plot(osoensis_my.ESM_EFproj_current)


names(osoensis_my.ESM_EFproj_current) = "A_osoensis"
ESMdir <- "C:/Users/gzl02/Desktop/Yi2020Research/Ecological_differentiation_chapter/Esemble_of_Small_models"
dir.create(file.path(ESMdir, "osoensis_ESM_MSDS"))
dir <- file.path(ESMdir, "osoensis_ESM_MSDS")
writeRaster(osoensis_my.ESM_EFproj_current, file.path(dir, names(osoensis_my.ESM_EFproj_current)),
            bylayer=TRUE, format='GTiff', overwrite=TRUE)
## get the coordiantes of pseudo - absences
## all repetition of pseudo absences sampling merged 
(osoensis_pa.all.xy <- get_PAtab(osoensis_myBiomodData) %>% 
    filter(is.na(status)) %>%
    select(x, y)) %>%
  distinct()
str(osoensis_pa.all.xy)
##add column with the species name
osoensis_pa.all.xy["sp"] <- c("A_osoensis")
osoensis_pa.all.xy <- osoensis_pa.all.xy[colnames(osoensis_pa.all.xy)[c(3,1:2)]]
str(osoensis_pa.all.xy)


osoensis_ESM_MSDS <- MSDM_Posteriori(
  records = osoensis,
  absence = osoensis_pa.all.xy,
  x = "x",
  y = "y",
  sp = "sp",
  method = c("MCP"),
  dirraster = dir,
  threshold = c("spec_sens"),
  buffer = NULL,
  dirsave = dir
)


##pacifica
pacifica <- read.table("./pacifica_Cleaned.txt", header = TRUE)
pacifica_presence <- pacifica[,2:3]
xy <- as.matrix(pacifica_presence)
coordinates(pacifica_presence) <- ~x+y
projection(pacifica_presence) <- CRS('+proj=longlat +datum=WGS84 +no_defs')
pacifica_myBiomodData <- BIOMOD_FormatingData( resp.var = pacifica_presence,
                                               expl.var = layers,
                                               PA.nb.rep = 1,
                                               PA.nb.absences = 10000,
                                               PA.strategy = 'random',
                                               resp.xy = xy,
                                               resp.name = "A_pacifica")

pacifica_my.ESM <- ecospat.ESM.Modeling( data=pacifica_myBiomodData,
                                         models=c('MAXENT.Phillips'),
                                         NbRunEval=2,
                                         DataSplit=70,
                                         weighting.score=c("AUC"),
                                         parallel=FALSE)  

pacifica_my.ESM_EF <- ecospat.ESM.EnsembleModeling(pacifica_my.ESM,weighting.score=c("AUC"),threshold=0.8)

### Projection of simple bivariate models into new space 
pacifica_my.ESM_proj_current<-ecospat.ESM.Projection(ESM.modeling.output=pacifica_my.ESM,
                                                     new.env=layers)

### Projection of calibrated ESMs into new space 
pacifica_my.ESM_EFproj_current <- ecospat.ESM.EnsembleProjection(ESM.prediction.output=pacifica_my.ESM_proj_current,
                                                                 ESM.EnsembleModeling.output=pacifica_my.ESM_EF)
plot(pacifica_my.ESM_EFproj_current)


names(pacifica_my.ESM_EFproj_current) = "A_pacifica"
ESMdir <- "C:/Users/gzl02/Desktop/Yi2020Research/Ecological_differentiation_chapter/Esemble_of_Small_models"
dir.create(file.path(ESMdir, "pacifica_ESM_MSDS"))
dir <- file.path(ESMdir, "pacifica_ESM_MSDS")
writeRaster(pacifica_my.ESM_EFproj_current, file.path(dir, names(pacifica_my.ESM_EFproj_current)),
            bylayer=TRUE, format='GTiff', overwrite=TRUE)
## get the coordiantes of pseudo - absences
## all repetition of pseudo absences sampling merged 
(pacifica_pa.all.xy <- get_PAtab(pacifica_myBiomodData) %>% 
    filter(is.na(status)) %>%
    select(x, y)) %>%
  distinct()
str(pacifica_pa.all.xy)
##add column with the species name
pacifica_pa.all.xy["sp"] <- c("A_pacifica")
pacifica_pa.all.xy <- pacifica_pa.all.xy[colnames(pacifica_pa.all.xy)[c(3,1:2)]]
str(pacifica_pa.all.xy)


pacifica_ESM_MSDS <- MSDM_Posteriori(
  records = pacifica,
  absence = pacifica_pa.all.xy,
  x = "x",
  y = "y",
  sp = "sp",
  method = c("MCP"),
  dirraster = dir,
  threshold = c("spec_sens"),
  buffer = NULL,
  dirsave = dir
)


