rm(list = ls())

library(raster)
library(hypervolume)
library(rgdal)
library(dismo)
library(RStoolbox)
library(ggplot2)
library(dplyr)
library(tidyr)
library(gtools)

#setwd("C:/Users/gzl02/Desktop/Yi2020Research/Ecological_differentiation_chapter/ENMTML_MSDS/env_layers_1km")

##obtain environmental data
setwd("C:/Users/gzl02/Desktop/Yi2020Research/Ecological_differentiation_chapter/ENM_Input_soil_clim_layer_CFP/Resampled_asc_files_1km")
#setwd("C:/Users/gzl02/Desktop/Yi2020Research/Ecological_differentiation_chapter/Niche_comparison/env_layers_select_0.65_1km")
layer_list <- list.files(path = "./", pattern='.asc$', 
                         all.files=TRUE, full.names=FALSE)


allrasters <- lapply(layer_list, raster)
allrasters

envt.stack <- stack(allrasters)
crs(envt.stack) <- "+proj=longlat +datum=WGS84 +no_defs"


get_environmentaldata <- function(binary_projection, envt, save_dir) {
  dist.points <-  rasterToPoints(binary_projection)#Need predicted occurrence points (calculated from thresholded model)
  dist.points <- dist.points[dist.points[,3] == 1,]
  hv.dat <- raster::extract(envt, dist.points[,1:2]);
  hv.dat <- hv.dat[complete.cases(hv.dat),];
#  hv.dat <- scale(hv.dat, center=TRUE, scale=TRUE)
  hv.dat <- data.frame(hv.dat)
  hv.dat <- data.frame(append(hv.dat, c(species=names(binary_projection)), after=0))
#  hv.dat$species <- names(binary_projection)
  write.csv(hv.dat, file.path(save_dir, paste0(names(binary_projection),".csv")))
  #estimate_bandwidth(enaEnvt, method = "silverman")
  #enaExp <- expectation_ball(enaEnvt)
  #hv <- hypervolume(data = hv.dat, method = "box")
}


#setwd("C:/Users/gzl02/Desktop/Yi2020Research/Ecological_differentiation_chapter/Niche_comparison/env_layers_select_unscaled")

#dir = "C:/Users/gzl02/Desktop/Yi2020Research/Ecological_differentiation_chapter/Niche_comparison/raster_to_point_env_select_0.65"
dir = "C:/Users/gzl02/Desktop/Yi2020Research/Ecological_differentiation_chapter/Niche_comparison/raster_to_point_unscaled"

##For the output below, you still need to mannually delete the first column.
andersonii <- raster("C:/Users/gzl02/Desktop/Yi2020Research/Ecological_differentiation_chapter/ENMTML_MSDS/andersonii/Algorithm/MXD/MSDMPosterior/BIN/A_andersonii.tif")
get_environmentaldata(binary_projection = andersonii, envt=envt.stack, save_dir = dir)
plot(andersonii)
zoom(andersonii, ext=drawExtent(show=TRUE, col="red"))

auriculata <- raster("C:/Users/gzl02/Desktop/Yi2020Research/Ecological_differentiation_chapter/ENMTML_MSDS/auriculata/Algorithm/MXD/MSDMPosterior/BIN/A_auriculata.tif")
get_environmentaldata(binary_projection = auriculata, envt=envt.stack, save_dir = dir)
plot(auriculata)
zoom(auriculata, ext=drawExtent(show=TRUE, col="red"))

bakeri <- raster("C:/Users/gzl02/Desktop/Yi2020Research/Ecological_differentiation_chapter/ENMTML_MSDS/bakeri/Algorithm/MXD/MSDMPosterior/BIN/A_bakeri.tif")
get_environmentaldata(binary_projection = bakeri, envt=envt.stack, save_dir = dir)
plot(bakeri)
zoom(bakeri, ext=drawExtent(show=TRUE, col="red"))

catalinae <- raster("C:/Users/gzl02/Desktop/Yi2020Research/Ecological_differentiation_chapter/ENMTML_MSDS/catalinae/Algorithm/MXD/MSDMPosterior/BIN/A_catalinae.tif")
get_environmentaldata(binary_projection = catalinae, envt=envt.stack, save_dir = dir)
plot(catalinae)
zoom(catalinae, ext=drawExtent(show=TRUE, col="red"))


confertiflora <- raster("C:/Users/gzl02/Desktop/Yi2020Research/Ecological_differentiation_chapter/ENMTML_MSDS/confertiflora/Algorithm/MXD/MSDMPosterior/BIN/A_confertiflora.tif")
get_environmentaldata(binary_projection = confertiflora, envt=envt.stack, save_dir = dir)

crustacea <- raster("C:/Users/gzl02/Desktop/Yi2020Research/Ecological_differentiation_chapter/ENMTML_MSDS/crustacea/Algorithm/MXD/MSDMPosterior/BIN/A_crustacea.tif")
get_environmentaldata(binary_projection = crustacea, envt=envt.stack, save_dir = dir)

cruzensis <- raster("C:/Users/gzl02/Desktop/Yi2020Research/Ecological_differentiation_chapter/ENMTML_MSDS/cruzensis/Algorithm/MXD/MSDMPosterior/BIN/A_cruzensis.tif")
get_environmentaldata(binary_projection = cruzensis, envt=envt.stack, save_dir = dir)

densiflora <- raster("C:/Users/gzl02/Desktop/Yi2020Research/Ecological_differentiation_chapter/Esemble_of_Small_models/densiflora_ESM_MSDS/BINr/A_densiflora.tif")
get_environmentaldata(binary_projection = densiflora, envt=envt.stack, save_dir = dir)

edmundsii <- raster("C:/Users/gzl02/Desktop/Yi2020Research/Ecological_differentiation_chapter/ENMTML_MSDS/edmundsii/Algorithm/MXD/MSDMPosterior/BIN/A_edmundsii.tif")
get_environmentaldata(binary_projection = edmundsii, envt=envt.stack, save_dir = dir)

gabilanensis <- raster("C:/Users/gzl02/Desktop/Yi2020Research/Ecological_differentiation_chapter/Esemble_of_Small_models/gabilanensis_ESM_MSDS/BINr/A_gabilanensis.tif")
get_environmentaldata(binary_projection = gabilanensis, envt=envt.stack, save_dir = dir)

glandulosa <- raster("C:/Users/gzl02/Desktop/Yi2020Research/Ecological_differentiation_chapter/ENMTML_MSDS/glandulosa/Algorithm/MXD/MSDMPosterior/BIN/A_glandulosa.tif")
get_environmentaldata(binary_projection = glandulosa, envt=envt.stack, save_dir = dir)

glauca <- raster("C:/Users/gzl02/Desktop/Yi2020Research/Ecological_differentiation_chapter/ENMTML_MSDS/glauca/Algorithm/MXD/MSDMPosterior/BIN/A_glauca.tif")
get_environmentaldata(binary_projection = glauca, envt=envt.stack, save_dir = dir)

glutinosa <- raster("C:/Users/gzl02/Desktop/Yi2020Research/Ecological_differentiation_chapter/ENMTML_MSDS/glutinosa/Algorithm/MXD/MSDMPosterior/BIN/A_glutinosa.tif")
get_environmentaldata(binary_projection = glutinosa, envt=envt.stack, save_dir = dir)

hookeri <- raster("C:/Users/gzl02/Desktop/Yi2020Research/Ecological_differentiation_chapter/ENMTML_MSDS/hookeri/Algorithm/MXD/MSDMPosterior/BIN/A_hookeri.tif")
get_environmentaldata(binary_projection = hookeri, envt=envt.stack, save_dir = dir)

hooveri <- raster("C:/Users/gzl02/Desktop/Yi2020Research/Ecological_differentiation_chapter/ENMTML_MSDS/hooveri/Algorithm/MXD/MSDMPosterior/BIN/A_hooveri.tif")
get_environmentaldata(binary_projection = hooveri, envt=envt.stack, save_dir = dir)

imbricata <- raster("C:/Users/gzl02/Desktop/Yi2020Research/Ecological_differentiation_chapter/Esemble_of_Small_models/imbricata_ESM_MSDS/BINr/A_imbricata.tif")
get_environmentaldata(binary_projection = imbricata, envt=envt.stack, save_dir = dir)

insularis <- raster("C:/Users/gzl02/Desktop/Yi2020Research/Ecological_differentiation_chapter/ENMTML_MSDS/insularis/Algorithm/MXD/MSDMPosterior/BIN/A_insularis.tif")
get_environmentaldata(binary_projection = insularis, envt=envt.stack, save_dir = dir)

klamathensis <- raster("C:/Users/gzl02/Desktop/Yi2020Research/Ecological_differentiation_chapter/ENMTML_MSDS/klamathensis/Algorithm/MXD/MSDMPosterior/BIN/A_klamathensis.tif")
get_environmentaldata(binary_projection = klamathensis, envt=envt.stack, save_dir = dir)

luciana <- raster("C:/Users/gzl02/Desktop/Yi2020Research/Ecological_differentiation_chapter/ENMTML_MSDS/luciana/Algorithm/MXD/MSDMPosterior/BIN/A_luciana.tif")
get_environmentaldata(binary_projection = luciana, envt=envt.stack, save_dir = dir)

malloryi <- raster("C:/Users/gzl02/Desktop/Yi2020Research/Ecological_differentiation_chapter/ENMTML_MSDS/malloryi/Algorithm/MXD/MSDMPosterior/BIN/A_malloryi.tif")
get_environmentaldata(binary_projection = malloryi, envt=envt.stack, save_dir = dir)

manzanita <- raster("C:/Users/gzl02/Desktop/Yi2020Research/Ecological_differentiation_chapter/ENMTML_MSDS/manzanita/Algorithm/MXD/MSDMPosterior/BIN/A_manzanita.tif")
get_environmentaldata(binary_projection = manzanita, envt=envt.stack, save_dir = dir)

mewukka <- raster("C:/Users/gzl02/Desktop/Yi2020Research/Ecological_differentiation_chapter/ENMTML_MSDS/mewukka/Algorithm/MXD/MSDMPosterior/BIN/A_mewukka.tif")
get_environmentaldata(binary_projection = mewukka, envt=envt.stack, save_dir = dir)

montana <- raster("C:/Users/gzl02/Desktop/Yi2020Research/Ecological_differentiation_chapter/ENMTML_MSDS/montana/Algorithm/MXD/MSDMPosterior/BIN/A_montana.tif")
get_environmentaldata(binary_projection = montana, envt=envt.stack, save_dir = dir)

montaraensis <- raster("C:/Users/gzl02/Desktop/Yi2020Research/Ecological_differentiation_chapter/Esemble_of_Small_models/montaraensis_ESM_MSDS/BINr/A_montaraensis.tif")
get_environmentaldata(binary_projection = montaraensis, envt=envt.stack, save_dir = dir)

montereyensis <- raster("C:/Users/gzl02/Desktop/Yi2020Research/Ecological_differentiation_chapter/ENMTML_MSDS/montereyensis/Algorithm/MXD/MSDMPosterior/BIN/A_montereyensis.tif")
get_environmentaldata(binary_projection = montereyensis, envt=envt.stack, save_dir = dir)

morroensis <- raster("C:/Users/gzl02/Desktop/Yi2020Research/Ecological_differentiation_chapter/ENMTML_MSDS/morroensis/Algorithm/MXD/MSDMPosterior/BIN/A_morroensis.tif")
get_environmentaldata(binary_projection = morroensis, envt=envt.stack, save_dir = dir)

myrtifolia <- raster("C:/Users/gzl02/Desktop/Yi2020Research/Ecological_differentiation_chapter/ENMTML_MSDS/myrtifolia/Algorithm/MXD/MSDMPosterior/BIN/A_myrtifolia.tif")
get_environmentaldata(binary_projection = myrtifolia, envt=envt.stack, save_dir = dir)

nevadensis <- raster("C:/Users/gzl02/Desktop/Yi2020Research/Ecological_differentiation_chapter/ENMTML_MSDS/nevadensis/Algorithm/MXD/MSDMPosterior/BIN/A_nevadensis.tif")
get_environmentaldata(binary_projection = nevadensis, envt=envt.stack, save_dir = dir)

nissenana <- raster("C:/Users/gzl02/Desktop/Yi2020Research/Ecological_differentiation_chapter/ENMTML_MSDS/nissenana/Algorithm/MXD/MSDMPosterior/BIN/A_nissenana.tif")
get_environmentaldata(binary_projection = nissenana, envt=envt.stack, save_dir = dir)

nortensis <- raster("C:/Users/gzl02/Desktop/Yi2020Research/Ecological_differentiation_chapter/ENMTML_MSDS/nortensis/Algorithm/MXD/MSDMPosterior/BIN/A_nortensis.tif")
get_environmentaldata(binary_projection = nortensis, envt=envt.stack, save_dir = dir)

obispoensis <- raster("C:/Users/gzl02/Desktop/Yi2020Research/Ecological_differentiation_chapter/ENMTML_MSDS/obispoensis/Algorithm/MXD/MSDMPosterior/BIN/A_obispoensis.tif")
get_environmentaldata(binary_projection = obispoensis, envt=envt.stack, save_dir = dir)

ohloneana <- raster("C:/Users/gzl02/Desktop/Yi2020Research/Ecological_differentiation_chapter/Esemble_of_Small_models/ohloneana_ESM_MSDS/BINr/A_ohloneana.tif")
get_environmentaldata(binary_projection = ohloneana, envt=envt.stack, save_dir = dir)

osoensis <- raster("C:/Users/gzl02/Desktop/Yi2020Research/Ecological_differentiation_chapter/Esemble_of_Small_models/osoensis_ESM_MSDS/BINr/A_osoensis.tif")
get_environmentaldata(binary_projection = osoensis, envt=envt.stack, save_dir = dir)

otayensis <- raster("C:/Users/gzl02/Desktop/Yi2020Research/Ecological_differentiation_chapter/ENMTML_MSDS/otayensis/Algorithm/MXD/MSDMPosterior/BIN/A_otayensis.tif")
get_environmentaldata(binary_projection = otayensis, envt=envt.stack, save_dir = dir)

pacifica <- raster("C:/Users/gzl02/Desktop/Yi2020Research/Ecological_differentiation_chapter/Esemble_of_Small_models/pacifica_ESM_MSDS/BINr/A_pacifica.tif")
get_environmentaldata(binary_projection = pacifica, envt=envt.stack, save_dir = dir)

pajaroensis <- raster("C:/Users/gzl02/Desktop/Yi2020Research/Ecological_differentiation_chapter/ENMTML_MSDS/pajaroensis/Algorithm/MXD/MSDMPosterior/BIN/A_pajaroensis.tif")
get_environmentaldata(binary_projection = pajaroensis, envt=envt.stack, save_dir = dir)

pallida <- raster("C:/Users/gzl02/Desktop/Yi2020Research/Ecological_differentiation_chapter/ENMTML_MSDS/pallida/Algorithm/MXD/MSDMPosterior/BIN/A_pallida.tif")
get_environmentaldata(binary_projection = pallida, envt=envt.stack, save_dir = dir)

parrayana <- raster("C:/Users/gzl02/Desktop/Yi2020Research/Ecological_differentiation_chapter/ENMTML_MSDS/parrayana/Algorithm/MXD/MSDMPosterior/BIN/A_parrayana.tif")
get_environmentaldata(binary_projection = parrayana, envt=envt.stack, save_dir = dir)

pechoensis <- raster("C:/Users/gzl02/Desktop/Yi2020Research/Ecological_differentiation_chapter/ENMTML_MSDS/pechoensis/Algorithm/MXD/MSDMPosterior/BIN/A_pechoensis.tif")
get_environmentaldata(binary_projection = pechoensis, envt=envt.stack, save_dir = dir)

pilosula <- raster("C:/Users/gzl02/Desktop/Yi2020Research/Ecological_differentiation_chapter/ENMTML_MSDS/pilosula/Algorithm/MXD/MSDMPosterior/BIN/A_pilosula.tif")
get_environmentaldata(binary_projection = pilosula, envt=envt.stack, save_dir = dir)

pumila <- raster("C:/Users/gzl02/Desktop/Yi2020Research/Ecological_differentiation_chapter/ENMTML_MSDS/pumila/Algorithm/MXD/MSDMPosterior/BIN/A_pumila.tif")
get_environmentaldata(binary_projection = pumila, envt=envt.stack, save_dir = dir)

purrisima <- raster("C:/Users/gzl02/Desktop/Yi2020Research/Ecological_differentiation_chapter/ENMTML_MSDS/purrisima/Algorithm/MXD/MSDMPosterior/BIN/A_purissima.tif")
get_environmentaldata(binary_projection = purrisima, envt=envt.stack, save_dir = dir)

rainbowensis <- raster("C:/Users/gzl02/Desktop/Yi2020Research/Ecological_differentiation_chapter/ENMTML_MSDS/rainbowensis/Algorithm/MXD/MSDMPosterior/BIN/A_rainbowensis.tif")
get_environmentaldata(binary_projection = rainbowensis, envt=envt.stack, save_dir = dir)

refugioensis <- raster("C:/Users/gzl02/Desktop/Yi2020Research/Ecological_differentiation_chapter/ENMTML_MSDS/refugioensis/Algorithm/MXD/MSDMPosterior/BIN/A_refugioensis.tif")
get_environmentaldata(binary_projection = refugioensis, envt=envt.stack, save_dir = dir)

regismontana <- raster("C:/Users/gzl02/Desktop/Yi2020Research/Ecological_differentiation_chapter/ENMTML_MSDS/regismontana/Algorithm/MXD/MSDMPosterior/BIN/A_regismontana.tif")
get_environmentaldata(binary_projection = regismontana, envt=envt.stack, save_dir = dir)

rudis <- raster("C:/Users/gzl02/Desktop/Yi2020Research/Ecological_differentiation_chapter/ENMTML_MSDS/rudis/Algorithm/MXD/MSDMPosterior/BIN/A_rudis.tif")
get_environmentaldata(binary_projection = rudis, envt=envt.stack, save_dir = dir)

sensitiva <- raster("C:/Users/gzl02/Desktop/Yi2020Research/Ecological_differentiation_chapter/ENMTML_MSDS/sensitiva/Algorithm/MXD/MSDMPosterior/BIN/A_sensitiva.tif")
get_environmentaldata(binary_projection = sensitiva, envt=envt.stack, save_dir = dir)

silvicola <- raster("C:/Users/gzl02/Desktop/Yi2020Research/Ecological_differentiation_chapter/ENMTML_MSDS/silvicola/Algorithm/MXD/MSDMPosterior/BIN/A_silvicola.tif")
get_environmentaldata(binary_projection = silvicola, envt=envt.stack, save_dir = dir)

stanfordiana <- raster("C:/Users/gzl02/Desktop/Yi2020Research/Ecological_differentiation_chapter/ENMTML_MSDS/stanfordiana/Algorithm/MXD/MSDMPosterior/BIN/A_stanfordiana.tif")
get_environmentaldata(binary_projection = stanfordiana, envt=envt.stack, save_dir = dir)

tomentosa <- raster("C:/Users/gzl02/Desktop/Yi2020Research/Ecological_differentiation_chapter/ENMTML_MSDS/tomentosa/Algorithm/MXD/MSDMPosterior/BIN/A_tomentosa.tif")
get_environmentaldata(binary_projection = tomentosa, envt=envt.stack, save_dir = dir)

virgata <- raster("C:/Users/gzl02/Desktop/Yi2020Research/Ecological_differentiation_chapter/ENMTML_MSDS/virgata/Algorithm/MXD/MSDMPosterior/BIN/A_virgata.tif")
get_environmentaldata(binary_projection = virgata, envt=envt.stack, save_dir = dir)

viridissima <- raster("C:/Users/gzl02/Desktop/Yi2020Research/Ecological_differentiation_chapter/ENMTML_MSDS/viridissima/Algorithm/MXD/MSDMPosterior/BIN/A_viridissima.tif")
get_environmentaldata(binary_projection = viridissima, envt=envt.stack, save_dir = dir)

viscida <- raster("C:/Users/gzl02/Desktop/Yi2020Research/Ecological_differentiation_chapter/ENMTML_MSDS/viscida/Algorithm/MXD/MSDMPosterior/BIN/A_viscida.tif")
get_environmentaldata(binary_projection = viscida, envt=envt.stack, save_dir = dir)



##combine multiple csv files into one
##need to delete the csv file of combined dataset before running the code below

dir = "C:/Users/gzl02/Desktop/Yi2020Research/Ecological_differentiation_chapter/Niche_comparison/raster_to_point_unscaled"

library(data.table)

multmerge = function(path){
  filenames=list.files(path=path, full.names=TRUE)
  rbindlist(lapply(filenames, fread))
}


combined <- multmerge(path = dir)

save_dir = "C:/Users/gzl02/Desktop/Yi2020Research/Ecological_differentiation_chapter/Niche_comparison/raster_to_point_unscaled"
write.csv(combined,"C:/Users/gzl02/Desktop/Yi2020Research/Ecological_differentiation_chapter/Niche_comparison/raster_to_point_unscaled/Combined_data_set/combined_unscaled.csv")

combined <- read.table("C:/Users/gzl02/Desktop/Yi2020Research/Ecological_differentiation_chapter/Niche_comparison/raster_to_point_unscaled/Combined_data_set/combined_unscaled.csv", sep = ",", header = TRUE)


## PCA 
### Create two dataframes.
data.clim <- combined[, 3:33]
data.species <- combined[, 2]



library(factoextra)
library(FactoMineR)
### Using only the bioclim columns to run the principal components analysis.
data.pca <- prcomp(data.clim, scale = TRUE) 


##### When you use the command prcomp your loading variables show up as rotational variables. 
##### Thanks to a really great answer on stack overflow: https://stackoverflow.com/questions/43407859/how-do-i-find-the-link-between-principal-components-and-raw-datas-variables
##### you can even convert the rotational 
##### variable to show the relative contribution.

loadings <- data.pca$rotation
summary(loadings)

##### There are two options to convert the loading to show the relative contribution, 
##### they both give the same answer so either can be used.
loadings_relative_A <- t(t(abs(loadings))/rowSums(t(abs(loadings))))*100
summary(loadings_relative_A)

loadings_relative_B <- sweep(x = abs(loadings), MARGIN = 2, STATS = colSums(abs(loadings)), FUN = "/")*100
summary(loadings_relative_B)

fviz_eig(data.pca)
windows()
colz <- ifelse(data.species == "A_glandulosa", "glandulosa","other species")

fviz_pca_biplot(data.pca, geom = c("point"),col.ind = colz, fill.var = "transparent")
fviz_pca_var(data.pca,
             col.var = "contrib", # Color by contributions to the PC
             gradient.cols = c("#00AFBB", "#E7B800", "#FC4E07"),
             repel = TRUE     # Avoid text overlapping
)
#### Plotting the PCA
##### First, I made a theme to change the background of the plot. Next, I changed the plot margins and the text size.
theme <- theme(panel.background = element_blank(),panel.border=element_rect(fill=NA),
               panel.grid.major = element_blank(),panel.grid.minor = element_blank(),
               strip.background=element_blank(),axis.ticks=element_line(colour="black"),
               plot.margin=unit(c(1,1,1,1),"line"), axis.text = element_text(size = 12), 
               legend.text = element_text(size = 12), legend.title = element_text(size = 12),
               text = element_text(size = 12))
##### Next, ggbiplot where obs.scale indicates the scale factor to apply to observation, 
##### var.scale indicates the scale factor to apply to variables, 
##### ellipse as TRUE draws a normal data ellipse for each group, 
##### and circle as TRUE draws a correlation circle.

if(!require(devtools)) install.packages("devtools")
devtools::install_github("vqv/ggbiplot", force = TRUE)
library(ggbiplot)
g <- ggbiplot(data.pca[,1:2], obs.scale = 1, var.scale = 1, groups = data.species, ellipse = TRUE, circle = TRUE)
g <- g + theme
g <- g + scale_colour_manual(values = c("#73dfff", "#ff8700", "#7a8ef5"))
g <- g + theme(legend.direction = 'horizontal', legend.position = 'bottom')
g


library(hypervolume)
library(devtools)
#devtools::install_github('gangwug/limma')
library(limma)

rm(list = ls())
list <- list.files(path = "C:/Users/gzl02/Desktop/Yi2020Research/Ecological_differentiation_chapter/Niche_comparison/raster_to_point_env", pattern='.csv', 
                        all.files=TRUE, full.names=FALSE)
#names_list <- removeExt(list, sep=".")

setwd("C:/Users/gzl02/Desktop/Yi2020Research/Ecological_differentiation_chapter/Niche_comparison/raster_to_point_env")
for (i in 1:length(list)) assign(list[i], read.csv(list[i], header = TRUE))

for (i in 1:3) assign(list[i], read.csv(list[i], header = TRUE))
for (i in 7:9) assign(list[i], read.csv(list[i], header = TRUE))
object_list <- ls(pattern=".csv")

#i = 1
for (i in 1:length(object_list)) {
  x <- get(object_list[i])
  x <- data.matrix(x[,2:12])
  assign(substr(list[i],1,nchar(list[i])-4), hypervolume(data = x, method = "box"))
}

rm(list = object_list)

hv_list <- ls(pattern="A_*")

jaccard_matrix <-matrix(data=NA, nrow=length(hv_list), ncol=length(hv_list))
jaccard_matrix <-as.data.frame(jaccard_matrix)
names(jaccard_matrix)<- hv_list
rownames(jaccard_matrix)<- hv_list
sorensen_matrix <- jaccard_matrix


for (i in 1:(length(hv_list)-1))
{
  for (j in i:length(hv_list))
  {
    if (j == i) {
      jaccard_matrix[i,j]<- 1
      sorensen_matrix[i,j] <- 1
    } else {
      hv_set <- hypervolume_set(hv1 = get(hv_list[i]), hv2 = get(hv_list[j]), check.memory = F)
      x <- hypervolume_overlap_statistics(hv_set)
      y <- as.data.frame(x)
      hv_list[i]
      hv_list[j]
      y
      jaccard_matrix[i,j]<- y[1,1]
      jaccard_matrix[j,i]<- y[1,1]
      sorensen_matrix[i,j] <- y[2,1]
      sorensen_matrix[j,i] <- y[2,1]
    }
  }
}


jaccard_matrix
sorensen_matrix
write.csv(jaccard_matrix,"jaccard_matrix.csv")
write.csv(sorensen_matrix,"sorensen_matrix.csv")

##still need to work on the code below
##for June 26th, try i=3 to generate a new hv and then process to a new matrix to see if the tree script works

###Run line245-249 if need to read an saved csv file.
#jaccard_matrix <- data.matrix(read.csv("C:/Users/gzl02/Desktop/Yi2020Research/Botany2021/jaccard_matrix_central_coast.csv", row.names = 1, header = TRUE))
#class(jaccard_matrix)
#str(jaccard_matrix)
#jaccard_dist <- as.dist(1 - jaccard_matrix)

jaccard_dist <- as.dist(1 - jaccard_matrix)
species.tree <- hclust(jaccard_dist, method="complete")
diff(species.tree$height)

plot(species.tree)

clusters <- identify(hclust(jaccard_dist))
rect.hclust(species.tree,
            k = 4, # k is used to specify the number of clusters
            border = "blue"
)
barplot(diff(species.tree$height, names.arg = (nrow(y) - 1):2 ))

jaccard_matrix <- data.matrix(read.csv("C:/Users/gzl02/Desktop/Yi2020Research/2021_annual_report_meeting/jaccard_matrix_40spp.csv", row.names = 1, header = TRUE))
species_labels <- dimnames(jaccard_matrix)[[1]]
class(jaccard_matrix)
str(jaccard_matrix)
jaccard_dist <- as.dist(1 - jaccard_matrix)
library(MASS)
#MASS::isoMDS(): Non-metric Multi-dimensional scaling
mds <- isoMDS(jaccard_dist)
windows()
plot(mds$points, type = "n")
text(mds$points, labels = species_labels)

k_means_list <- vector(mode = "list", length = 39)
for (i in 1:39){
  kmeans_clust <- kmeans(mds$points, i)
  #Within cluster sum of squares by cluster
  k_means_list[i] <- sum((kmeans_clust)$withinss)
}
plot(1:39, k_means_list, type="b", xlab="Number of Clusters",
     ylab="Within groups sum of squares")

kmeans_clust <- kmeans(mds$points, 10)  # k-means wihth 3 clusters.
plot(mds$points, type = "n", main="MDS and k-means clustering (k=10)", xlab = "X-Dim", ylab="Y-Dim")
text(mds$points, labels = species_labels, col = kmeans_clust$cluster)  # set color using k-means output
#sum((kmeans_clust)$withinss)

#MASS::sammon(): Another form of non-metric MDS
sam <- sammon(jaccard_dist)

k_means_list <- vector(mode = "list", length = 39)
for (i in 1:39){
  kmeans_clust <- kmeans(sam$points, i)
  #Within cluster sum of squares by cluster
  k_means_list[i] <- sum((kmeans_clust)$withinss)
}
plot(1:39, k_means_list, type="b", xlab="Number of Clusters",
     ylab="Within groups sum of squares")
#Assume best k=16
kmeans_clust <- kmeans(sam$points, 16)  # k-means wihth 3 clusters.
plot(sam$points, type = "n", main="MDS with sammon() and k-means clustering (k=16)", xlab = "X-Dim", ylab="Y-Dim")
text(sam$points, labels = species_labels, col = kmeans_clust$cluster)  # set color using k-means output
#sum((kmeans_clust)$withinss)

library(mclust)
d_clust <- Mclust(as.matrix(sam$points), G=1:39)
m.best <- dim(d_clust$z)[2]
cat("model-based optimal number of clusters:", m.best, "\n")
# 21 clusters
windows()
plot(d_clust)
