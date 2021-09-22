rm(list = ls())

wd = "C:/Users/gzl02/Desktop/Yi2020Research/Ecological_differentiation_chapter/ENMTML_MSDS"
setwd(wd)

###If you could install the ENMTML successfully, try to install Rtools first and then use the devtools to install the package.
###Another way for troubleshooting the installation of ENMTML is to uninstall all dependent R package and then reinstall them again.
#writeLines('PATH="${RTOOLS40_HOME}\\usr\\bin;${PATH}"', con = "~/.Renviron")
#Sys.which("make")
#install.packages("rgdal", type = "source")
#library(devtools)
#if (!"devtools"%in%installed.packages()){install.packages("devtools")}  
#devtools::install_github("andrefaa/ENMTML")  


library(ENMTML)

##check the number of core available for R
parallel::detectCores()


###if you are working on one species per time. core =1. There is no point to use multiple core
##thin_occ: use c(method='CELLSIZE') when the occurence # > 50

andersonii_ENM <- ENMTML(pred_dir = "./env_layers_1km", 
                         proj_dir = NULL, 
                         result_dir = "./andersonii",
                         occ_file = "./occurence_data/A_andersonii_cleaned.txt", 
                         sp = "species", 
                         x = "decimalLon", 
                         y = "decimalLat", 
                         min_occ = 10,
                         thin_occ =c(method='CELLSIZE'), 
                         eval_occ = NULL, 
                         colin_var = c(method='PEARSON', threshold='0.7'),
                         imp_var = TRUE, 
                         sp_accessible_area = c(method='BUFFER', type='1'), 
                         pseudoabs_method = c(method='RND'),
                         pres_abs_ratio = 1, 
                         part = c(method= 'BLOCK'), save_part = FALSE, 
                         save_final = TRUE,
                         algorithm = c('MXD',"MXS"), 
                         #thr = c(type='MAX_TSS','JACCARD','SORENSEN'), 
                         thr = c(type='MAX_TSS'),
                         msdm = c(method='PRES'), 
                         ensemble = NULL,
                         extrapolation = FALSE, 
                         cores = 1)

auriculata_ENM <- ENMTML(pred_dir = "./env_layers_1km", 
                         proj_dir = NULL, 
                         result_dir = "./auriculata",
                         occ_file = "./occurence_data/A_auriculata_cleaned.txt", 
                         sp = "species", 
                         x = "decimalLon", 
                         y = "decimalLat", 
                         min_occ = 10,
                         thin_occ =NULL, 
                         eval_occ = NULL, 
                         colin_var = c(method='PEARSON', threshold='0.7'),
                         imp_var = TRUE, 
                         sp_accessible_area = c(method='BUFFER', type='1'), 
                         pseudoabs_method = c(method='RND'),
                         pres_abs_ratio = 1, 
                         part = c(method='BOOT', replicates='2', proportion='0.7'), save_part = FALSE, 
                         save_final = TRUE,
                         algorithm = c('MXD',"MXS"), 
                         #thr = c(type='MAX_TSS','JACCARD','SORENSEN'), 
                         thr = c(type='MAX_TSS'),
                         msdm = c(method='PRES'), 
                         ensemble = NULL,
                         extrapolation = FALSE, 
                         cores = 1)

bakeri_ENM <- ENMTML(pred_dir = "./env_layers_1km", 
                         proj_dir = NULL, 
                         result_dir = "./bakeri",
                         occ_file = "./occurence_data/A_bakeri_cleaned.txt", 
                         sp = "species", 
                         x = "decimalLon", 
                         y = "decimalLat", 
                         min_occ = 10,
                         thin_occ =NULL, 
                         eval_occ = NULL, 
                         colin_var = c(method='PEARSON', threshold='0.7'),
                         imp_var = TRUE, 
                         sp_accessible_area = c(method='BUFFER', type='1'), 
                         pseudoabs_method = c(method='RND'),
                         pres_abs_ratio = 1, 
                         part = c(method= 'BLOCK'), save_part = FALSE, 
                         save_final = TRUE,
                         algorithm = c('MXD',"MXS"), 
                         #thr = c(type='MAX_TSS','JACCARD','SORENSEN'), 
                         thr = c(type='MAX_TSS'),
                         msdm = c(method='PRES'), 
                         ensemble = NULL,
                         extrapolation = FALSE, 
                         cores = 1)

catalinae_ENM <- ENMTML(pred_dir = "./env_layers_1km", 
                     proj_dir = NULL, 
                     result_dir = "./catalinae",
                     occ_file = "./occurence_data/A_catalinae_cleaned.txt", 
                     sp = "species", 
                     x = "decimalLon", 
                     y = "decimalLat", 
                     min_occ = 10,
                     thin_occ =NULL, 
                     eval_occ = NULL, 
                     colin_var = c(method='PEARSON', threshold='0.7'),
                     imp_var = TRUE, 
                     sp_accessible_area = c(method='BUFFER', type='1'), 
                     pseudoabs_method = c(method='RND'),
                     pres_abs_ratio = 1, 
                     ##use BOOTSTRAP when the # of unque occurence is smaller than 20
                     part = c(method='BOOT', replicates='2', proportion='0.7'), save_part = FALSE, 
                     save_final = TRUE,
                     algorithm = c('MXD',"MXS"), 
                     #thr = c(type='MAX_TSS','JACCARD','SORENSEN'), 
                     thr = c(type='MAX_TSS'),
                     msdm = c(method='PRES'), 
                     ensemble = NULL,
                     extrapolation = FALSE, 
                     cores = 1)

confertiflora_ENM <- ENMTML(pred_dir = "./env_layers_1km", 
                            proj_dir = NULL, 
                            result_dir = "./confertiflora",
                            occ_file = "./occurence_data/A_confertiflora_cleaned.txt", 
                            sp = "species", 
                            x = "decimalLon", 
                            y = "decimalLat", 
                            min_occ = 10,
                            thin_occ =NULL, 
                            eval_occ = NULL, 
                            colin_var = c(method='PEARSON', threshold='0.7'),
                            imp_var = TRUE, 
                            sp_accessible_area = c(method='BUFFER', type='1'), 
                            pseudoabs_method = c(method='RND'),
                            pres_abs_ratio = 1, 
                            ##use BOOTSTRAP when the # of unque occurence is smaller than 20
                            part = c(method='BOOT', replicates='2', proportion='0.7'), save_part = FALSE, 
                            save_final = TRUE,
                            algorithm = c('MXD',"MXS"), 
                            #thr = c(type='MAX_TSS','JACCARD','SORENSEN'), 
                            thr = c(type='MAX_TSS'),
                            msdm = c(method='PRES'), 
                            ensemble = NULL,
                            extrapolation = FALSE, 
                            cores = 1)

crustacea_ENM <- ENMTML(pred_dir = "./env_layers_1km", 
                         proj_dir = NULL, 
                         result_dir = "./crustacea",
                         occ_file = "./occurence_data/A_crustacea_cleaned.txt", 
                         sp = "species", 
                         x = "decimalLon", 
                         y = "decimalLat", 
                         min_occ = 10,
                         thin_occ =c(method='CELLSIZE'), 
                         eval_occ = NULL, 
                         colin_var = c(method='PEARSON', threshold='0.7'),
                         imp_var = TRUE, 
                         sp_accessible_area = c(method='BUFFER', type='1'), 
                         pseudoabs_method = c(method='RND'),
                         pres_abs_ratio = 1, 
                         part = c(method= 'BLOCK'), save_part = FALSE, 
                         save_final = TRUE,
                         algorithm = c('MXD',"MXS"), 
                         #thr = c(type='MAX_TSS','JACCARD','SORENSEN'), 
                         thr = c(type='MAX_TSS'),
                         msdm = c(method='PRES'), 
                         ensemble = NULL,
                         extrapolation = FALSE, 
                         cores = 1)

cruzensis_ENM <- ENMTML(pred_dir = "./env_layers_1km", 
                         proj_dir = NULL, 
                         result_dir = "./cruzensis",
                         occ_file = "./occurence_data/A_cruzensis_cleaned.txt", 
                         sp = "species", 
                         x = "decimalLongitude", 
                         y = "decimalLatitude", 
                         min_occ = 10,
                         thin_occ =NULL, 
                         eval_occ = NULL, 
                         colin_var = c(method='PEARSON', threshold='0.7'),
                         imp_var = TRUE, 
                         sp_accessible_area = c(method='BUFFER', type='1'), 
                         pseudoabs_method = c(method='RND'),
                         pres_abs_ratio = 1, 
                         ##use BOOTSTRAP when the # of unque occurence is smaller than 20
                         part = c(method='BOOT', replicates='2', proportion='0.7'), save_part = FALSE, 
                         save_final = TRUE,
                         algorithm = c('MXD',"MXS"), 
                         #thr = c(type='MAX_TSS','JACCARD','SORENSEN'), 
                         thr = c(type='MAX_TSS'),
                         msdm = c(method='PRES'), 
                         ensemble = NULL,
                         extrapolation = FALSE, 
                         cores = 1)
##only five unique records
densiflora_ENM <- ENMTML(pred_dir = "./env_layers_1km", 
                        proj_dir = NULL, 
                        result_dir = "./densiflora",
                        occ_file = "./occurence_data/A_densiflora_cleaned.txt", 
                        sp = "species", 
                        x = "decimalLon", 
                        y = "decimalLat", 
                        min_occ = 10,
                        thin_occ =NULL, 
                        eval_occ = NULL, 
                        colin_var = c(method='PEARSON', threshold='0.7'),
                        imp_var = TRUE, 
                        sp_accessible_area = c(method='BUFFER', type='1'), 
                        pseudoabs_method = c(method='RND'),
                        pres_abs_ratio = 1, 
                        ##use BOOTSTRAP when the # of unque occurence is smaller than 20
                        part = c(method='BOOT', replicates='2', proportion='0.7'), save_part = FALSE, 
                        save_final = TRUE,
                        algorithm = c('MXD',"MXS"), 
                        #thr = c(type='MAX_TSS','JACCARD','SORENSEN'), 
                        thr = c(type='MAX_TSS'),
                        msdm = c(method='PRES'), 
                        ensemble = NULL,
                        extrapolation = FALSE, 
                        cores = 1)

edmundsii_ENM <- ENMTML(pred_dir = "./env_layers_1km", 
                         proj_dir = NULL, 
                         result_dir = "./edmundsii",
                         occ_file = "./occurence_data/A_edmundsii_cleaned.txt", 
                         sp = "species", 
                         x = "decimalLon", 
                         y = "decimalLat", 
                         min_occ = 10,
                         thin_occ =NULL, 
                         eval_occ = NULL, 
                         colin_var = c(method='PEARSON', threshold='0.7'),
                         imp_var = TRUE, 
                         sp_accessible_area = c(method='BUFFER', type='1'), 
                         pseudoabs_method = c(method='RND'),
                         pres_abs_ratio = 1, 
                         ##use BOOTSTRAP when the # of unque occurence is smaller than 20
                         part = c(method='BOOT', replicates='2', proportion='0.7'), save_part = FALSE, 
                         save_final = TRUE,
                         algorithm = c('MXD',"MXS"), 
                         #thr = c(type='MAX_TSS','JACCARD','SORENSEN'), 
                         thr = c(type='MAX_TSS'),
                         msdm = c(method='PRES'), 
                         ensemble = NULL,
                         extrapolation = FALSE, 
                         cores = 1)
###only one unique record
franciscana_ENM <- ENMTML(pred_dir = "./env_layers_1km", 
                            proj_dir = NULL, 
                            result_dir = "./franciscana",
                            occ_file = "./occurence_data/A_franciscana_cleaned.txt", 
                            sp = "species", 
                            x = "decimalLon", 
                            y = "decimalLat", 
                            min_occ = 10,
                            thin_occ =NULL, 
                            eval_occ = NULL, 
                            colin_var = c(method='PEARSON', threshold='0.7'),
                            imp_var = TRUE, 
                            sp_accessible_area = c(method='BUFFER', type='1'), 
                            pseudoabs_method = c(method='RND'),
                            pres_abs_ratio = 1, 
                            ##use BOOTSTRAP when the # of unque occurence is smaller than 20
                            part = c(method='BOOT', replicates='2', proportion='0.7'), save_part = FALSE, 
                            save_final = TRUE,
                            algorithm = c('MXD',"MXS"), 
                            #thr = c(type='MAX_TSS','JACCARD','SORENSEN'), 
                            thr = c(type='MAX_TSS'),
                            msdm = c(method='PRES'), 
                            ensemble = NULL,
                            extrapolation = FALSE, 
                            cores = 1)

gabilanensis_ENM <- ENMTML(pred_dir = "./env_layers_1km", 
                          proj_dir = NULL, 
                          result_dir = "./gabilanensis",
                          occ_file = "./occurence_data/A_gabilanensis_cleaned.txt", 
                          sp = "species", 
                          x = "decimalLon", 
                          y = "decimalLat", 
                          min_occ = 10,
                          thin_occ =NULL, 
                          eval_occ = NULL, 
                          colin_var = c(method='PEARSON', threshold='0.7'),
                          imp_var = TRUE, 
                          sp_accessible_area = c(method='BUFFER', type='1'), 
                          pseudoabs_method = c(method='RND'),
                          pres_abs_ratio = 1, 
                          ##use BOOTSTRAP when the # of unque occurence is smaller than 20
                          part = c(method='BOOT', replicates='2', proportion='0.7'), save_part = FALSE, 
                          save_final = TRUE,
                          algorithm = c('MXD',"MXS"), 
                          #thr = c(type='MAX_TSS','JACCARD','SORENSEN'), 
                          thr = c(type='MAX_TSS'),
                          msdm = c(method='PRES'), 
                          ensemble = NULL,
                          extrapolation = FALSE, 
                          cores = 1)

glandulosa_ENM <- ENMTML(pred_dir = "./env_layers_1km", 
                        proj_dir = NULL, 
                        result_dir = "./glandulosa",
                        occ_file = "./occurence_data/A_glandulosa_cleaned.txt", 
                        sp = "species", 
                        x = "decimalLongitude", 
                        y = "decimalLatitude", 
                        min_occ = 10,
                        thin_occ =c(method='CELLSIZE'), 
                        eval_occ = NULL, 
                        colin_var = c(method='PEARSON', threshold='0.7'),
                        imp_var = TRUE, 
                        sp_accessible_area = c(method='BUFFER', type='1'), 
                        pseudoabs_method = c(method='RND'),
                        pres_abs_ratio = 1, 
                        part = c(method= 'BLOCK'), save_part = FALSE, 
                        save_final = TRUE,
                        algorithm = c('MXD',"MXS"), 
                        #thr = c(type='MAX_TSS','JACCARD','SORENSEN'), 
                        thr = c(type='MAX_TSS'),
                        msdm = c(method='PRES'), 
                        ensemble = NULL,
                        extrapolation = FALSE, 
                        cores = 1)

glauca_ENM <- ENMTML(pred_dir = "./env_layers_1km", 
                         proj_dir = NULL, 
                         result_dir = "./glauca",
                         occ_file = "./occurence_data/A_glauca_cleaned.txt", 
                         sp = "species", 
                         x = "decimalLon", 
                         y = "decimalLat", 
                         min_occ = 10,
                         thin_occ =c(method='CELLSIZE'), 
                         eval_occ = NULL, 
                         colin_var = c(method='PEARSON', threshold='0.7'),
                         imp_var = TRUE, 
                         sp_accessible_area = c(method='BUFFER', type='1'), 
                         pseudoabs_method = c(method='RND'),
                         pres_abs_ratio = 1, 
                         part = c(method= 'BLOCK'), save_part = FALSE, 
                         save_final = TRUE,
                         algorithm = c('MXD',"MXS"), 
                         #thr = c(type='MAX_TSS','JACCARD','SORENSEN'), 
                         thr = c(type='MAX_TSS'),
                         msdm = c(method='PRES'), 
                         ensemble = NULL,
                         extrapolation = FALSE, 
                         cores = 1)

glutinosa_ENM <- ENMTML(pred_dir = "./env_layers_1km", 
                     proj_dir = NULL, 
                     result_dir = "./glutinosa",
                     occ_file = "./occurence_data/A_glutinosa_cleaned.txt", 
                     sp = "species", 
                     x = "decimalLon", 
                     y = "decimalLat", 
                     min_occ = 10,
                     thin_occ =NULL, 
                     eval_occ = NULL, 
                     colin_var = c(method='PEARSON', threshold='0.7'),
                     imp_var = TRUE, 
                     sp_accessible_area = c(method='BUFFER', type='1'), 
                     pseudoabs_method = c(method='RND'),
                     pres_abs_ratio = 1, 
                     part = c(method='BOOT', replicates='2', proportion='0.7'), save_part = FALSE, 
                     save_final = TRUE,
                     algorithm = c('MXD',"MXS"), 
                     #thr = c(type='MAX_TSS','JACCARD','SORENSEN'), 
                     thr = c(type='MAX_TSS'),
                     msdm = c(method='PRES'), 
                     ensemble = NULL,
                     extrapolation = FALSE, 
                     cores = 1)

hookeri_ENM <- ENMTML(pred_dir = "./env_layers_1km", 
                     proj_dir = NULL, 
                     result_dir = "./hookeri",
                     occ_file = "./occurence_data/A_hookeri_cleaned.txt", 
                     sp = "species", 
                     x = "decimalLon", 
                     y = "decimalLat", 
                     min_occ = 10,
                     thin_occ =NULL, 
                     eval_occ = NULL, 
                     colin_var = c(method='PEARSON', threshold='0.7'),
                     imp_var = TRUE, 
                     sp_accessible_area = c(method='BUFFER', type='1'), 
                     pseudoabs_method = c(method='RND'),
                     pres_abs_ratio = 1, 
                     part = c(method= 'BLOCK'), save_part = FALSE, 
                     save_final = TRUE,
                     algorithm = c('MXD',"MXS"), 
                     #thr = c(type='MAX_TSS','JACCARD','SORENSEN'), 
                     thr = c(type='MAX_TSS'),
                     msdm = c(method='PRES'), 
                     ensemble = NULL,
                     extrapolation = FALSE, 
                     cores = 1)

hooveri_ENM <- ENMTML(pred_dir = "./env_layers_1km", 
                      proj_dir = NULL, 
                      result_dir = "./hooveri",
                      occ_file = "./occurence_data/A_hooveri_cleaned.txt", 
                      sp = "species", 
                      x = "decimalLon", 
                      y = "decimalLat", 
                      min_occ = 10,
                      thin_occ =NULL, 
                      eval_occ = NULL, 
                      colin_var = c(method='PEARSON', threshold='0.7'),
                      imp_var = TRUE, 
                      sp_accessible_area = c(method='BUFFER', type='1'), 
                      pseudoabs_method = c(method='RND'),
                      pres_abs_ratio = 1, 
                      part = c(c(method='BOOT', replicates='2', proportion='0.7')), save_part = FALSE, 
                      save_final = TRUE,
                      algorithm = c('MXD',"MXS"), 
                      #thr = c(type='MAX_TSS','JACCARD','SORENSEN'), 
                      thr = c(type='MAX_TSS'),
                      msdm = c(method='PRES'), 
                      ensemble = NULL,
                      extrapolation = FALSE, 
                      cores = 1)

imbricata_ENM <- ENMTML(pred_dir = "./env_layers_1km", 
                          proj_dir = NULL, 
                          result_dir = "./imbricata",
                          occ_file = "./occurence_data/A_imbricata_cleaned.txt", 
                          sp = "species", 
                          x = "decimalLon", 
                          y = "decimalLat", 
                          min_occ = 10,
                          thin_occ =NULL, 
                          eval_occ = NULL, 
                          colin_var = c(method='PEARSON', threshold='0.7'),
                          imp_var = TRUE, 
                          sp_accessible_area = c(method='BUFFER', type='1'), 
                          pseudoabs_method = c(method='RND'),
                          pres_abs_ratio = 1, 
                          ##use BOOTSTRAP when the # of unque occurence is smaller than 20
                          part = c(method='BOOT', replicates='2', proportion='0.7'), save_part = FALSE, 
                          save_final = TRUE,
                          algorithm = c('MXD',"MXS"), 
                          #thr = c(type='MAX_TSS','JACCARD','SORENSEN'), 
                          thr = c(type='MAX_TSS'),
                          msdm = c(method='PRES'), 
                          ensemble = NULL,
                          extrapolation = FALSE, 
                          cores = 1)

insularis_ENM <- ENMTML(pred_dir = "./env_layers_1km", 
                           proj_dir = NULL, 
                           result_dir = "./insularis",
                           occ_file = "./occurence_data/A_insularis_cleaned.txt", 
                           sp = "species", 
                           x = "decimalLon", 
                           y = "decimalLat", 
                           min_occ = 10,
                           thin_occ =c(method='CELLSIZE'), 
                           eval_occ = NULL, 
                           colin_var = c(method='PEARSON', threshold='0.7'),
                           imp_var = TRUE, 
                           sp_accessible_area = c(method='BUFFER', type='1'), 
                           pseudoabs_method = c(method='RND'),
                           pres_abs_ratio = 1, 
                           ##use BOOTSTRAP when the # of unque occurence is smaller than 20
                           part = c(method='BLOCK'), save_part = FALSE, 
                           save_final = TRUE,
                           algorithm = c('MXD',"MXS"), 
                           #thr = c(type='MAX_TSS','JACCARD','SORENSEN'), 
                           thr = c(type='MAX_TSS'),
                           msdm = c(method='PRES'), 
                           ensemble = NULL,
                           extrapolation = FALSE, 
                           cores = 1)

klamathensis_ENM <- ENMTML(pred_dir = "./env_layers_1km", 
                      proj_dir = NULL, 
                      result_dir = "./klamathensis",
                      occ_file = "./occurence_data/A_klamathensis_cleaned.txt", 
                      sp = "species", 
                      x = "decimalLon", 
                      y = "decimalLat", 
                      min_occ = 10,
                      thin_occ =NULL, 
                      eval_occ = NULL, 
                      colin_var = c(method='PEARSON', threshold='0.7'),
                      imp_var = TRUE, 
                      sp_accessible_area = c(method='BUFFER', type='1'), 
                      pseudoabs_method = c(method='RND'),
                      pres_abs_ratio = 1, 
                      ##use BOOTSTRAP when the # of unque occurence is smaller than 20
                      part = c(method='BOOT', replicates='2', proportion='0.7'), save_part = FALSE, 
                      save_final = TRUE,
                      algorithm = c('MXD',"MXS"), 
                      #thr = c(type='MAX_TSS','JACCARD','SORENSEN'), 
                      thr = c(type='MAX_TSS'),
                      msdm = c(method='PRES'), 
                      ensemble = NULL,
                      extrapolation = FALSE, 
                      cores = 1)


luciana_ENM <- ENMTML(pred_dir = "./env_layers_1km", 
                        proj_dir = NULL, 
                        result_dir = "./luciana",
                        occ_file = "./occurence_data/A_luciana_cleaned.txt", 
                        sp = "species", 
                        x = "decimalLon", 
                        y = "decimalLat", 
                        min_occ = 10,
                        thin_occ =NULL, 
                        eval_occ = NULL, 
                        colin_var = c(method='PEARSON', threshold='0.7'),
                        imp_var = TRUE, 
                        sp_accessible_area = c(method='BUFFER', type='1'), 
                        pseudoabs_method = c(method='RND'),
                        pres_abs_ratio = 1, 
                        ##use BOOTSTRAP when the # of unque occurence is smaller than 20
                        part = c(method='BOOT', replicates='2', proportion='0.7'), save_part = FALSE, 
                        save_final = TRUE,
                        algorithm = c('MXD',"MXS"), 
                        #thr = c(type='MAX_TSS','JACCARD','SORENSEN'), 
                        thr = c(type='MAX_TSS'),
                        msdm = c(method='PRES'), 
                        ensemble = NULL,
                        extrapolation = FALSE, 
                        cores = 1)

malloryi_ENM <- ENMTML(pred_dir = "./env_layers_1km", 
                      proj_dir = NULL, 
                      result_dir = "./malloryi",
                      occ_file = "./occurence_data/A_malloryi_cleaned.txt", 
                      sp = "species", 
                      x = "decimalLon", 
                      y = "decimalLat", 
                      min_occ = 10,
                      thin_occ =NULL, 
                      eval_occ = NULL, 
                      colin_var = c(method='PEARSON', threshold='0.7'),
                      imp_var = TRUE, 
                      sp_accessible_area = c(method='BUFFER', type='1'), 
                      pseudoabs_method = c(method='RND'),
                      pres_abs_ratio = 1, 
                      ##use BOOTSTRAP when the # of unque occurence is smaller than 20
                      part = c(method='BOOT', replicates='2', proportion='0.7'), save_part = FALSE, 
                      save_final = TRUE,
                      algorithm = c('MXD',"MXS"), 
                      #thr = c(type='MAX_TSS','JACCARD','SORENSEN'), 
                      thr = c(type='MAX_TSS'),
                      msdm = c(method='PRES'), 
                      ensemble = NULL,
                      extrapolation = FALSE, 
                      cores = 1)


manzanita_ENM <- ENMTML(pred_dir = "./env_layers_1km", 
                         proj_dir = NULL, 
                         result_dir = "./manzanita",
                         occ_file = "./occurence_data/A_manzanita_cleaned.txt", 
                         sp = "species", 
                         x = "decimalLon", 
                         y = "decimalLat", 
                         min_occ = 10,
                         thin_occ =c(method='CELLSIZE'), 
                         eval_occ = NULL, 
                         colin_var = c(method='PEARSON', threshold='0.7'),
                         imp_var = TRUE, 
                         sp_accessible_area = c(method='BUFFER', type='1'), 
                         pseudoabs_method = c(method='RND'),
                         pres_abs_ratio = 1, 
                         part = c(method= 'BLOCK'), save_part = FALSE, 
                         save_final = TRUE,
                         algorithm = c('MXD',"MXS"), 
                         #thr = c(type='MAX_TSS','JACCARD','SORENSEN'), 
                         thr = c(type='MAX_TSS'),
                         msdm = c(method='PRES'), 
                         ensemble = NULL,
                         extrapolation = FALSE, 
                         cores = 1)

mewukka_ENM <- ENMTML(pred_dir = "./env_layers_1km", 
                        proj_dir = NULL, 
                        result_dir = "./mewukka",
                        occ_file = "./occurence_data/A_mewukka_cleaned.txt", 
                        sp = "species", 
                        x = "decimalLon", 
                        y = "decimalLat", 
                        min_occ = 10,
                        thin_occ =c(method='CELLSIZE'), 
                        eval_occ = NULL, 
                        colin_var = c(method='PEARSON', threshold='0.7'),
                        imp_var = TRUE, 
                        sp_accessible_area = c(method='BUFFER', type='1'), 
                        pseudoabs_method = c(method='RND'),
                        pres_abs_ratio = 1, 
                        part = c(method= 'BLOCK'), save_part = FALSE, 
                        save_final = TRUE,
                        algorithm = c('MXD',"MXS"), 
                        #thr = c(type='MAX_TSS','JACCARD','SORENSEN'), 
                        thr = c(type='MAX_TSS'),
                        msdm = c(method='PRES'), 
                        ensemble = NULL,
                        extrapolation = FALSE, 
                        cores = 1)

montana_ENM <- ENMTML(pred_dir = "./env_layers_1km", 
                      proj_dir = NULL, 
                      result_dir = "./montana",
                      occ_file = "./occurence_data/A_montana_cleaned.txt", 
                      sp = "species", 
                      x = "decimalLon", 
                      y = "decimalLat", 
                      min_occ = 10,
                      thin_occ =NULL, 
                      eval_occ = NULL, 
                      colin_var = c(method='PEARSON', threshold='0.7'),
                      imp_var = TRUE, 
                      sp_accessible_area = c(method='BUFFER', type='1'), 
                      pseudoabs_method = c(method='RND'),
                      pres_abs_ratio = 1, 
                      part = c(method= 'BLOCK'), save_part = FALSE, 
                      save_final = TRUE,
                      algorithm = c('MXD',"MXS"), 
                      #thr = c(type='MAX_TSS','JACCARD','SORENSEN'), 
                      thr = c(type='MAX_TSS'),
                      msdm = c(method='PRES'), 
                      ensemble = NULL,
                      extrapolation = FALSE, 
                      cores = 1)


montaraensis_ENM <- ENMTML(pred_dir = "./env_layers_1km", 
                      proj_dir = NULL, 
                      result_dir = "./montaraensis",
                      occ_file = "./occurence_data/A_montaraensis_cleaned.txt", 
                      sp = "species", 
                      x = "decimalLon", 
                      y = "decimalLat", 
                      min_occ = 10,
                      thin_occ =NULL, 
                      eval_occ = NULL, 
                      colin_var = c(method='PEARSON', threshold='0.7'),
                      imp_var = TRUE, 
                      sp_accessible_area = c(method='BUFFER', type='1'), 
                      pseudoabs_method = c(method='RND'),
                      pres_abs_ratio = 1, 
                      part = c(method='BOOT', replicates='2', proportion='0.7'), save_part = FALSE, 
                      save_final = TRUE,
                      algorithm = c('MXD',"MXS"), 
                      #thr = c(type='MAX_TSS','JACCARD','SORENSEN'), 
                      thr = c(type='MAX_TSS'),
                      msdm = c(method='PRES'), 
                      ensemble = NULL,
                      extrapolation = FALSE, 
                      cores = 1)

montereyensis_ENM <- ENMTML(pred_dir = "./env_layers_1km", 
                           proj_dir = NULL, 
                           result_dir = "./montereyensis",
                           occ_file = "./occurence_data/A_montereyensis_cleaned.txt", 
                           sp = "species", 
                           x = "decimalLon", 
                           y = "decimalLat", 
                           min_occ = 10,
                           thin_occ =NULL, 
                           eval_occ = NULL, 
                           colin_var = c(method='PEARSON', threshold='0.7'),
                           imp_var = TRUE, 
                           sp_accessible_area = c(method='BUFFER', type='1'), 
                           pseudoabs_method = c(method='RND'),
                           pres_abs_ratio = 1, 
                           part = c(method='BOOT', replicates='2', proportion='0.7'), save_part = FALSE, 
                           save_final = TRUE,
                           algorithm = c('MXD',"MXS"), 
                           #thr = c(type='MAX_TSS','JACCARD','SORENSEN'), 
                           thr = c(type='MAX_TSS'),
                           msdm = c(method='PRES'), 
                           ensemble = NULL,
                           extrapolation = FALSE, 
                           cores = 1)

morroensis_ENM <- ENMTML(pred_dir = "./env_layers_1km", 
                            proj_dir = NULL, 
                            result_dir = "./morroensis",
                            occ_file = "./occurence_data/A_morroensis_cleaned.txt", 
                            sp = "species", 
                            x = "decimalLon", 
                            y = "decimalLat", 
                            min_occ = 10,
                            thin_occ =NULL, 
                            eval_occ = NULL, 
                            colin_var = c(method='PEARSON', threshold='0.7'),
                            imp_var = TRUE, 
                            sp_accessible_area = c(method='BUFFER', type='1'), 
                            pseudoabs_method = c(method='RND'),
                            pres_abs_ratio = 1, 
                            part = c(method='BOOT', replicates='2', proportion='0.7'), save_part = FALSE, 
                            save_final = TRUE,
                            algorithm = c('MXD',"MXS"), 
                            #thr = c(type='MAX_TSS','JACCARD','SORENSEN'), 
                            thr = c(type='MAX_TSS'),
                            msdm = c(method='PRES'), 
                            ensemble = NULL,
                            extrapolation = FALSE, 
                            cores = 1)

myrtifolia_ENM <- ENMTML(pred_dir = "./env_layers_1km", 
                         proj_dir = NULL, 
                         result_dir = "./myrtifolia",
                         occ_file = "./occurence_data/A_myrtifolia_cleaned.txt", 
                         sp = "species", 
                         x = "decimalLon", 
                         y = "decimalLat", 
                         min_occ = 10,
                         thin_occ = NULL, 
                         eval_occ = NULL, 
                         colin_var = c(method='PEARSON', threshold='0.7'),
                         imp_var = TRUE, 
                         sp_accessible_area = c(method='BUFFER', type='1'), 
                         pseudoabs_method = c(method='RND'),
                         pres_abs_ratio = 1, 
                         part = c(method='BLOCK'), save_part = FALSE, 
                         save_final = TRUE,
                         algorithm = c('MXD',"MXS"), 
                         #thr = c(type='MAX_TSS','JACCARD','SORENSEN'), 
                         thr = c(type='MAX_TSS'),
                         msdm = c(method='PRES'), 
                         ensemble = NULL,
                         extrapolation = FALSE, 
                         cores = 1)


nevadensis_ENM <- ENMTML(pred_dir = "./env_layers_1km", 
                         proj_dir = NULL, 
                         result_dir = "./nevadensis",
                         occ_file = "./occurence_data/A_nevadensis_cleaned.txt", 
                         sp = "species", 
                         x = "decimalLongitude", 
                         y = "decimalLatitude", 
                         min_occ = 10,
                         thin_occ = c(method="CELLSIZE"), 
                         eval_occ = NULL, 
                         colin_var = c(method='PEARSON', threshold='0.7'),
                         imp_var = TRUE, 
                         sp_accessible_area = c(method='BUFFER', type='1'), 
                         pseudoabs_method = c(method='RND'),
                         pres_abs_ratio = 1, 
                         part = c(method='BLOCK'), save_part = FALSE, 
                         save_final = TRUE,
                         algorithm = c('MXD',"MXS"), 
                         #thr = c(type='MAX_TSS','JACCARD','SORENSEN'), 
                         thr = c(type='MAX_TSS'),
                         msdm = c(method='PRES'), 
                         ensemble = NULL,
                         extrapolation = FALSE, 
                         cores = 1)


nissenana_ENM <- ENMTML(pred_dir = "./env_layers_1km", 
                         proj_dir = NULL, 
                         result_dir = "./nissenana",
                         occ_file = "./occurence_data/A_nissenana_cleaned.txt", 
                         sp = "species", 
                         x = "decimalLon", 
                         y = "decimalLat", 
                         min_occ = 10,
                         thin_occ = NULL, 
                         eval_occ = NULL, 
                         colin_var = c(method='PEARSON', threshold='0.7'),
                         imp_var = TRUE, 
                         sp_accessible_area = c(method='BUFFER', type='1'), 
                         pseudoabs_method = c(method='RND'),
                         pres_abs_ratio = 1, 
                         part = c(method='BLOCK'), save_part = FALSE, 
                         save_final = TRUE,
                         algorithm = c('MXD',"MXS"), 
                         #thr = c(type='MAX_TSS','JACCARD','SORENSEN'), 
                         thr = c(type='MAX_TSS'),
                         msdm = c(method='PRES'), 
                         ensemble = NULL,
                         extrapolation = FALSE, 
                         cores = 1)

nortensis_ENM <- ENMTML(pred_dir = "./env_layers_1km", 
                        proj_dir = NULL, 
                        result_dir = "./nortensis",
                        occ_file = "./occurence_data/A_nortensis_cleaned.txt", 
                        sp = "species", 
                        x = "decimalLon", 
                        y = "decimalLat", 
                        min_occ = 10,
                        thin_occ = NULL, 
                        eval_occ = NULL, 
                        colin_var = c(method='PEARSON', threshold='0.7'),
                        imp_var = TRUE, 
                        sp_accessible_area = c(method='BUFFER', type='1'), 
                        pseudoabs_method = c(method='RND'),
                        pres_abs_ratio = 1, 
                        part = c(method='BOOT', replicates='2', proportion='0.7'), save_part = FALSE, 
                        save_final = TRUE,
                        algorithm = c('MXD',"MXS"), 
                        #thr = c(type='MAX_TSS','JACCARD','SORENSEN'), 
                        thr = c(type='MAX_TSS'),
                        msdm = c(method='PRES'), 
                        ensemble = NULL,
                        extrapolation = FALSE, 
                        cores = 1)

obispoensis_ENM <- ENMTML(pred_dir = "./env_layers_1km", 
                        proj_dir = NULL, 
                        result_dir = "./obispoensis",
                        occ_file = "./occurence_data/A_obispoensis_cleaned.txt", 
                        sp = "species", 
                        x = "decimalLon", 
                        y = "decimalLat", 
                        min_occ = 10,
                        thin_occ = c(method = "CELLSIZE"), 
                        eval_occ = NULL, 
                        colin_var = c(method='PEARSON', threshold='0.7'),
                        imp_var = TRUE, 
                        sp_accessible_area = c(method='BUFFER', type='1'), 
                        pseudoabs_method = c(method='RND'),
                        pres_abs_ratio = 1, 
                        part = c(method='BLOCK'), save_part = FALSE, 
                        save_final = TRUE,
                        algorithm = c('MXD',"MXS"), 
                        #thr = c(type='MAX_TSS','JACCARD','SORENSEN'), 
                        thr = c(type='MAX_TSS'),
                        msdm = c(method='PRES'), 
                        ensemble = NULL,
                        extrapolation = FALSE, 
                        cores = 1)

ohloneana_ENM <- ENMTML(pred_dir = "./env_layers_1km", 
                       proj_dir = NULL, 
                       result_dir = "./ohloneana",
                       occ_file = "./occurence_data/A_ohloneana_cleaned.txt", 
                       sp = "species", 
                       x = "decimalLon", 
                       y = "decimalLat", 
                       min_occ = 10,
                       thin_occ = NULL, 
                       eval_occ = NULL, 
                       colin_var = c(method='PEARSON', threshold='0.7'),
                       imp_var = TRUE, 
                       sp_accessible_area = c(method='BUFFER', type='1'), 
                       pseudoabs_method = c(method='RND'),
                       pres_abs_ratio = 1, 
                       part = c(method='BOOT', replicates='2', proportion='0.7'), save_part = FALSE, 
                       save_final = TRUE,
                       algorithm = c('MXD',"MXS"), 
                       #thr = c(type='MAX_TSS','JACCARD','SORENSEN'), 
                       thr = c(type='MAX_TSS'),
                       msdm = c(method='PRES'), 
                       ensemble = NULL,
                       extrapolation = FALSE, 
                       cores = 1)

osoensis_ENM <- ENMTML(pred_dir = "./env_layers_1km", 
                          proj_dir = NULL, 
                          result_dir = "./osoensis",
                          occ_file = "./occurence_data/A_osoensis_cleaned.txt", 
                          sp = "species", 
                          x = "decimalLon", 
                          y = "decimalLat", 
                          min_occ = 10,
                          thin_occ = NULL, 
                          eval_occ = NULL, 
                          colin_var = c(method='PEARSON', threshold='0.7'),
                          imp_var = TRUE, 
                          sp_accessible_area = c(method='BUFFER', type='1'), 
                          pseudoabs_method = c(method='RND'),
                          pres_abs_ratio = 1, 
                          part = c(method='BOOT', replicates='2', proportion='0.7'), save_part = FALSE, 
                          save_final = TRUE,
                          algorithm = c('MXD',"MXS"), 
                          #thr = c(type='MAX_TSS','JACCARD','SORENSEN'), 
                          thr = c(type='MAX_TSS'),
                          msdm = c(method='PRES'), 
                          ensemble = NULL,
                          extrapolation = FALSE, 
                          cores = 1)


otayensis_ENM <- ENMTML(pred_dir = "./env_layers_1km", 
                       proj_dir = NULL, 
                       result_dir = "./otayensis",
                       occ_file = "./occurence_data/A_otayensis_cleaned.txt", 
                       sp = "species", 
                       x = "decimalLon", 
                       y = "decimalLat", 
                       min_occ = 10,
                       thin_occ = NULL, 
                       eval_occ = NULL, 
                       colin_var = c(method='PEARSON', threshold='0.7'),
                       imp_var = TRUE, 
                       sp_accessible_area = c(method='BUFFER', type='1'), 
                       pseudoabs_method = c(method='RND'),
                       pres_abs_ratio = 1, 
                       part = c(method='BOOT', replicates='2', proportion='0.7'), save_part = FALSE, 
                       save_final = TRUE,
                       algorithm = c('MXD',"MXS"), 
                       #thr = c(type='MAX_TSS','JACCARD','SORENSEN'), 
                       thr = c(type='MAX_TSS'),
                       msdm = c(method='PRES'), 
                       ensemble = NULL,
                       extrapolation = FALSE, 
                       cores = 1)

pacifica_ENM <- ENMTML(pred_dir = "./env_layers_1km", 
                       proj_dir = NULL, 
                       result_dir = "./pacifica",
                       occ_file = "./occurence_data/A_pacifica_cleaned.txt", 
                       sp = "species", 
                       x = "decimalLon", 
                       y = "decimalLat", 
                       min_occ = 10,
                       thin_occ = NULL, 
                       eval_occ = NULL, 
                       colin_var = c(method='PEARSON', threshold='0.7'),
                       imp_var = TRUE, 
                       sp_accessible_area = c(method='BUFFER', type='1'), 
                       pseudoabs_method = c(method='RND'),
                       pres_abs_ratio = 1, 
                       part = c(method='BOOT', replicates='2', proportion='0.7'), save_part = FALSE, 
                       save_final = TRUE,
                       algorithm = c('MXD',"MXS"), 
                       #thr = c(type='MAX_TSS','JACCARD','SORENSEN'), 
                       thr = c(type='MAX_TSS'),
                       msdm = c(method='PRES'), 
                       ensemble = NULL,
                       extrapolation = FALSE, 
                       cores = 1)

pajaroensis_ENM <- ENMTML(pred_dir = "./env_layers_1km", 
                       proj_dir = NULL, 
                       result_dir = "./pajaroensis",
                       occ_file = "./occurence_data/A_pajaroensis_cleaned.txt", 
                       sp = "species", 
                       x = "decimalLon", 
                       y = "decimalLat", 
                       min_occ = 10,
                       thin_occ = NULL, 
                       eval_occ = NULL, 
                       colin_var = c(method='PEARSON', threshold='0.7'),
                       imp_var = TRUE, 
                       sp_accessible_area = c(method='BUFFER', type='1'), 
                       pseudoabs_method = c(method='RND'),
                       pres_abs_ratio = 1, 
                       part = c(method='BLOCK'), save_part = FALSE, 
                       save_final = TRUE,
                       algorithm = c('MXD',"MXS"), 
                       #thr = c(type='MAX_TSS','JACCARD','SORENSEN'), 
                       thr = c(type='MAX_TSS'),
                       msdm = c(method='PRES'), 
                       ensemble = NULL,
                       extrapolation = FALSE, 
                       cores = 1)


pallida_ENM <- ENMTML(pred_dir = "./env_layers_1km", 
                          proj_dir = NULL, 
                          result_dir = "./pallida",
                          occ_file = "./occurence_data/A_pallida_cleaned.txt", 
                          sp = "species", 
                          x = "decimalLon", 
                          y = "decimalLat", 
                          min_occ = 10,
                          thin_occ = NULL, 
                          eval_occ = NULL, 
                          colin_var = c(method='PEARSON', threshold='0.7'),
                          imp_var = TRUE, 
                          sp_accessible_area = c(method='BUFFER', type='1'), 
                          pseudoabs_method = c(method='RND'),
                          pres_abs_ratio = 1, 
                          part = c(method='BOOT', replicates='2', proportion='0.7'), save_part = FALSE, 
                          save_final = TRUE,
                          algorithm = c('MXD',"MXS"), 
                          #thr = c(type='MAX_TSS','JACCARD','SORENSEN'), 
                          thr = c(type='MAX_TSS'),
                          msdm = c(method='PRES'), 
                          ensemble = NULL,
                          extrapolation = FALSE, 
                          cores = 1)

parrayana_ENM <- ENMTML(pred_dir = "./env_layers_1km", 
                          proj_dir = NULL, 
                          result_dir = "./parrayana",
                          occ_file = "./occurence_data/A_parrayana_cleaned.txt", 
                          sp = "species", 
                          x = "decimalLon", 
                          y = "decimalLat", 
                          min_occ = 10,
                          thin_occ = c(method = "CELLSIZE"), 
                          eval_occ = NULL, 
                          colin_var = c(method='PEARSON', threshold='0.7'),
                          imp_var = TRUE, 
                          sp_accessible_area = c(method='BUFFER', type='1'), 
                          pseudoabs_method = c(method='RND'),
                          pres_abs_ratio = 1, 
                          part = c(method='BLOCK'), save_part = FALSE, 
                          save_final = TRUE,
                          algorithm = c('MXD',"MXS"), 
                          #thr = c(type='MAX_TSS','JACCARD','SORENSEN'), 
                          thr = c(type='MAX_TSS'),
                          msdm = c(method='PRES'), 
                          ensemble = NULL,
                          extrapolation = FALSE, 
                          cores = 1)

pechoensis_ENM <- ENMTML(pred_dir = "./env_layers_1km", 
                      proj_dir = NULL, 
                      result_dir = "./pechoensis",
                      occ_file = "./occurence_data/A_pechoensis_cleaned.txt", 
                      sp = "species", 
                      x = "decimalLon", 
                      y = "decimalLat", 
                      min_occ = 10,
                      thin_occ = NULL, 
                      eval_occ = NULL, 
                      colin_var = c(method='PEARSON', threshold='0.7'),
                      imp_var = TRUE, 
                      sp_accessible_area = c(method='BUFFER', type='1'), 
                      pseudoabs_method = c(method='RND'),
                      pres_abs_ratio = 1, 
                      part = c(method='BOOT', replicates='2', proportion='0.7'), save_part = FALSE, 
                      save_final = TRUE,
                      algorithm = c('MXD',"MXS"), 
                      #thr = c(type='MAX_TSS','JACCARD','SORENSEN'), 
                      thr = c(type='MAX_TSS'),
                      msdm = c(method='PRES'), 
                      ensemble = NULL,
                      extrapolation = FALSE, 
                      cores = 1)

pilosula_ENM <- ENMTML(pred_dir = "./env_layers_1km", 
                         proj_dir = NULL, 
                         result_dir = "./pilosula",
                         occ_file = "./occurence_data/A_pilosula_cleaned.txt", 
                         sp = "species", 
                         x = "decimalLon", 
                         y = "decimalLat", 
                         min_occ = 10,
                         thin_occ = c(method="CELLSIZE"), 
                         eval_occ = NULL, 
                         colin_var = c(method='PEARSON', threshold='0.7'),
                         imp_var = TRUE, 
                         sp_accessible_area = c(method='BUFFER', type='1'), 
                         pseudoabs_method = c(method='RND'),
                         pres_abs_ratio = 1, 
                         part = c(method='BLOCK'), save_part = FALSE, 
                         save_final = TRUE,
                         algorithm = c('MXD',"MXS"), 
                         #thr = c(type='MAX_TSS','JACCARD','SORENSEN'), 
                         thr = c(type='MAX_TSS'),
                         msdm = c(method='PRES'), 
                         ensemble = NULL,
                         extrapolation = FALSE, 
                         cores = 1)

pumila_ENM <- ENMTML(pred_dir = "./env_layers_1km", 
                       proj_dir = NULL, 
                       result_dir = "./pumila",
                       occ_file = "./occurence_data/A_pumila_cleaned.txt", 
                       sp = "species", 
                       x = "decimalLon", 
                       y = "decimalLat", 
                       min_occ = 10,
                       thin_occ = NULL, 
                       eval_occ = NULL, 
                       colin_var = c(method='PEARSON', threshold='0.7'),
                       imp_var = TRUE, 
                       sp_accessible_area = c(method='BUFFER', type='1'), 
                       pseudoabs_method = c(method='RND'),
                       pres_abs_ratio = 1, 
                       part = c(method='BOOT', replicates='2', proportion='0.7'), save_part = FALSE, 
                       save_final = TRUE,
                       algorithm = c('MXD',"MXS"), 
                       #thr = c(type='MAX_TSS','JACCARD','SORENSEN'), 
                       thr = c(type='MAX_TSS'),
                       msdm = c(method='PRES'), 
                       ensemble = NULL,
                       extrapolation = FALSE, 
                       cores = 1)

purissima_ENM <- ENMTML(pred_dir = "./env_layers_1km", 
                     proj_dir = NULL, 
                     result_dir = "./purrisima",
                     occ_file = "./occurence_data/A_purissima_cleaned.txt", 
                     sp = "species", 
                     x = "decimalLon", 
                     y = "decimalLat", 
                     min_occ = 10,
                     thin_occ = c(method ="CELLSIZE"), 
                     eval_occ = NULL, 
                     colin_var = c(method='PEARSON', threshold='0.7'),
                     imp_var = TRUE, 
                     sp_accessible_area = c(method='BUFFER', type='1'), 
                     pseudoabs_method = c(method='RND'),
                     pres_abs_ratio = 1, 
                     part = c(method='BLOCK'), save_part = FALSE, 
                     save_final = TRUE,
                     algorithm = c('MXD',"MXS"), 
                     #thr = c(type='MAX_TSS','JACCARD','SORENSEN'), 
                     thr = c(type='MAX_TSS'),
                     msdm = c(method='PRES'), 
                     ensemble = NULL,
                     extrapolation = FALSE, 
                     cores = 1)

rainbowensis_ENM <- ENMTML(pred_dir = "./env_layers_1km", 
                        proj_dir = NULL, 
                        result_dir = "./rainbowensis",
                        occ_file = "./occurence_data/A_rainbowensis_cleaned.txt", 
                        sp = "species", 
                        x = "decimalLon", 
                        y = "decimalLat", 
                        min_occ = 10,
                        thin_occ = c(method ="CELLSIZE"), 
                        eval_occ = NULL, 
                        colin_var = c(method='PEARSON', threshold='0.7'),
                        imp_var = TRUE, 
                        sp_accessible_area = c(method='BUFFER', type='1'), 
                        pseudoabs_method = c(method='RND'),
                        pres_abs_ratio = 1, 
                        part = c(method='BLOCK'), save_part = FALSE, 
                        save_final = TRUE,
                        algorithm = c('MXD',"MXS"), 
                        #thr = c(type='MAX_TSS','JACCARD','SORENSEN'), 
                        thr = c(type='MAX_TSS'),
                        msdm = c(method='PRES'), 
                        ensemble = NULL,
                        extrapolation = FALSE, 
                        cores = 1)

refugioensis_ENM <- ENMTML(pred_dir = "./env_layers_1km", 
                           proj_dir = NULL, 
                           result_dir = "./refugioensis",
                           occ_file = "./occurence_data/A_refugioensis_cleaned.txt", 
                           sp = "species", 
                           x = "decimalLon", 
                           y = "decimalLat", 
                           min_occ = 10,
                           thin_occ = NULL, 
                           eval_occ = NULL, 
                           colin_var = c(method='PEARSON', threshold='0.7'),
                           imp_var = TRUE, 
                           sp_accessible_area = c(method='BUFFER', type='1'), 
                           pseudoabs_method = c(method='RND'),
                           pres_abs_ratio = 1, 
                           part = c(method='BLOCK'), save_part = FALSE, 
                           save_final = TRUE,
                           algorithm = c('MXD',"MXS"), 
                           #thr = c(type='MAX_TSS','JACCARD','SORENSEN'), 
                           thr = c(type='MAX_TSS'),
                           msdm = c(method='PRES'), 
                           ensemble = NULL,
                           extrapolation = FALSE, 
                           cores = 1)

regismontana <- ENMTML(pred_dir = "./env_layers_1km", 
                           proj_dir = NULL, 
                           result_dir = "./regismontana",
                           occ_file = "./occurence_data/A_regismontana_cleaned.txt", 
                           sp = "species", 
                           x = "decimalLon", 
                           y = "decimalLat", 
                           min_occ = 10,
                           thin_occ = NULL, 
                           eval_occ = NULL, 
                           colin_var = c(method='PEARSON', threshold='0.7'),
                           imp_var = TRUE, 
                           sp_accessible_area = c(method='BUFFER', type='1'), 
                           pseudoabs_method = c(method='RND'),
                           pres_abs_ratio = 1, 
                           part = c(method='BOOT', replicates='2', proportion='0.7'), save_part = FALSE, 
                           save_final = TRUE,
                           algorithm = c('MXD',"MXS"), 
                           #thr = c(type='MAX_TSS','JACCARD','SORENSEN'), 
                           thr = c(type='MAX_TSS'),
                           msdm = c(method='MCP'), 
                           ensemble = NULL,
                           extrapolation = FALSE, 
                           cores = 1)

rudis_ENM <- ENMTML(pred_dir = "./env_layers_1km", 
                           proj_dir = NULL, 
                           result_dir = "./rudis",
                           occ_file = "./occurence_data/A_rudis_cleaned.txt", 
                           sp = "species", 
                           x = "decimalLon", 
                           y = "decimalLat", 
                           min_occ = 10,
                           thin_occ = c(method = "CELLSIZE"), 
                           eval_occ = NULL, 
                           colin_var = c(method='PEARSON', threshold='0.7'),
                           imp_var = TRUE, 
                           sp_accessible_area = c(method='BUFFER', type='1'), 
                           pseudoabs_method = c(method='RND'),
                           pres_abs_ratio = 1, 
                           part = c(method='BLOCK'), save_part = FALSE, 
                           save_final = TRUE,
                           algorithm = c('MXD',"MXS"), 
                           #thr = c(type='MAX_TSS','JACCARD','SORENSEN'), 
                           thr = c(type='MAX_TSS'),
                           msdm = c(method='PRES'), 
                           ensemble = NULL,
                           extrapolation = FALSE, 
                           cores = 1)

sensitiva_ENM <- ENMTML(pred_dir = "./env_layers_1km", 
                    proj_dir = NULL, 
                    result_dir = "./sensitiva",
                    occ_file = "./occurence_data/A_sensitiva_cleaned.txt", 
                    sp = "species", 
                    x = "decimalLon", 
                    y = "decimalLat", 
                    min_occ = 10,
                    thin_occ = NULL, 
                    eval_occ = NULL, 
                    colin_var = c(method='PEARSON', threshold='0.7'),
                    imp_var = TRUE, 
                    sp_accessible_area = c(method='BUFFER', type='1'), 
                    pseudoabs_method = c(method='RND'),
                    pres_abs_ratio = 1, 
                    part = c(method='BLOCK'), save_part = FALSE, 
                    save_final = TRUE,
                    algorithm = c('MXD',"MXS"), 
                    #thr = c(type='MAX_TSS','JACCARD','SORENSEN'), 
                    thr = c(type='MAX_TSS'),
                    msdm = c(method='PRES'), 
                    ensemble = NULL,
                    extrapolation = FALSE, 
                    cores = 1)

silvicola_ENM <- ENMTML(pred_dir = "./env_layers_1km", 
                        proj_dir = NULL, 
                        result_dir = "./silvicola",
                        occ_file = "./occurence_data/A_silvicola_cleaned.txt", 
                        sp = "species", 
                        x = "decimalLon", 
                        y = "decimalLat", 
                        min_occ = 10,
                        thin_occ = c(method = "CELLSIZE"), 
                        eval_occ = NULL, 
                        colin_var = c(method='PEARSON', threshold='0.7'),
                        imp_var = TRUE, 
                        sp_accessible_area = c(method='BUFFER', type='1'), 
                        pseudoabs_method = c(method='RND'),
                        pres_abs_ratio = 1, 
                        part = c(method='BLOCK'), save_part = FALSE, 
                        save_final = TRUE,
                        algorithm = c('MXD',"MXS"), 
                        #thr = c(type='MAX_TSS','JACCARD','SORENSEN'), 
                        thr = c(type='MAX_TSS'),
                        msdm = c(method='PRES'), 
                        ensemble = NULL,
                        extrapolation = FALSE, 
                        cores = 1)

stanfordiana_ENM <- ENMTML(pred_dir = "./env_layers_1km", 
                        proj_dir = NULL, 
                        result_dir = "./stanfordiana",
                        occ_file = "./occurence_data/A_stanfordiana_cleaned.txt", 
                        sp = "species", 
                        x = "decimalLon", 
                        y = "decimalLat", 
                        min_occ = 10,
                        thin_occ = c(method = "CELLSIZE"), 
                        eval_occ = NULL, 
                        colin_var = c(method='PEARSON', threshold='0.7'),
                        imp_var = TRUE, 
                        sp_accessible_area = c(method='BUFFER', type='1'), 
                        pseudoabs_method = c(method='RND'),
                        pres_abs_ratio = 1, 
                        part = c(method='BLOCK'), save_part = FALSE, 
                        save_final = TRUE,
                        algorithm = c('MXD',"MXS"), 
                        #thr = c(type='MAX_TSS','JACCARD','SORENSEN'), 
                        thr = c(type='MAX_TSS'),
                        msdm = c(method='PRES'), 
                        ensemble = NULL,
                        extrapolation = FALSE, 
                        cores = 1)

tomentosa_ENM <- ENMTML(pred_dir = "./env_layers_1km", 
                            proj_dir = NULL, 
                            result_dir = "./tomentosa",
                            occ_file = "./occurence_data/A_tomentosa_cleaned.txt", 
                            sp = "species", 
                            x = "decimalLon", 
                            y = "decimalLat", 
                            min_occ = 10,
                            thin_occ = c(method = "CELLSIZE"), 
                            eval_occ = NULL, 
                            colin_var = c(method='PEARSON', threshold='0.7'),
                            imp_var = TRUE, 
                            sp_accessible_area = c(method='BUFFER', type='1'), 
                            pseudoabs_method = c(method='RND'),
                            pres_abs_ratio = 1, 
                            part = c(method='BLOCK'), save_part = FALSE, 
                            save_final = TRUE,
                            algorithm = c('MXD',"MXS"), 
                            #thr = c(type='MAX_TSS','JACCARD','SORENSEN'), 
                            thr = c(type='MAX_TSS'),
                            msdm = c(method='PRES'), 
                            ensemble = NULL,
                            extrapolation = FALSE, 
                            cores = 1)

virgata_ENM <- ENMTML(pred_dir = "./env_layers_1km", 
                        proj_dir = NULL, 
                        result_dir = "./virgata",
                        occ_file = "./occurence_data/A_virgata_cleaned.txt", 
                        sp = "species", 
                        x = "decimalLon", 
                        y = "decimalLat", 
                        min_occ = 10,
                        thin_occ = NULL, 
                        eval_occ = NULL, 
                        colin_var = c(method='PEARSON', threshold='0.7'),
                        imp_var = TRUE, 
                        sp_accessible_area = c(method='BUFFER', type='1'), 
                        pseudoabs_method = c(method='RND'),
                        pres_abs_ratio = 1, 
                        part = c(method='BLOCK'), save_part = FALSE, 
                        save_final = TRUE,
                        algorithm = c('MXD',"MXS"), 
                        #thr = c(type='MAX_TSS','JACCARD','SORENSEN'), 
                        thr = c(type='MAX_TSS'),
                        msdm = c(method='PRES'), 
                        ensemble = NULL,
                        extrapolation = FALSE, 
                        cores = 1)


viridissima_ENM <- ENMTML(pred_dir = "./env_layers_1km", 
                      proj_dir = NULL, 
                      result_dir = "./viridissima",
                      occ_file = "./occurence_data/A_viridissima_cleaned.txt", 
                      sp = "species", 
                      x = "decimalLon", 
                      y = "decimalLat", 
                      min_occ = 10,
                      thin_occ = NULL, 
                      eval_occ = NULL, 
                      colin_var = c(method='PEARSON', threshold='0.7'),
                      imp_var = TRUE, 
                      sp_accessible_area = c(method='BUFFER', type='1'), 
                      pseudoabs_method = c(method='RND'),
                      pres_abs_ratio = 1, 
                      part = c(method='BOOT', replicates='2', proportion='0.7'), save_part = FALSE, 
                      save_final = TRUE,
                      algorithm = c('MXD',"MXS"), 
                      #thr = c(type='MAX_TSS','JACCARD','SORENSEN'), 
                      thr = c(type='MAX_TSS'),
                      msdm = c(method='PRES'), 
                      ensemble = NULL,
                      extrapolation = FALSE, 
                      cores = 1)

viscida_ENM <- ENMTML(pred_dir = "./env_layers_1km", 
                        proj_dir = NULL, 
                        result_dir = "./viscida",
                        occ_file = "./occurence_data/A_viscida_cleaned.txt", 
                        sp = "species", 
                        x = "decimalLon", 
                        y = "decimalLat", 
                        min_occ = 10,
                        thin_occ = c(method = "CELLSIZE"), 
                        eval_occ = NULL, 
                        colin_var = c(method='PEARSON', threshold='0.7'),
                        imp_var = TRUE, 
                        sp_accessible_area = c(method='BUFFER', type='1'), 
                        pseudoabs_method = c(method='RND'),
                        pres_abs_ratio = 1, 
                        part = c(method='BLOCK'), save_part = FALSE, 
                        save_final = TRUE,
                        algorithm = c('MXD',"MXS"), 
                        #thr = c(type='MAX_TSS','JACCARD','SORENSEN'), 
                        thr = c(type='MAX_TSS'),
                        msdm = c(method='PRES'), 
                        ensemble = NULL,
                        extrapolation = FALSE, 
                        cores = 1)




###after the models are constructed, then start from here.
rm(list = ls())

wd = "C:/Users/gzl02/Desktop/Yi2020Research/Ecological_differentiation_chapter/ENMTML_MSDS"
setwd(wd)

library(raster)
library(hypervolume)
library(rgdal)
library(dismo)
library(RStoolbox)
library(ggplot2)
library(dplyr)
library(tidyr)
library(gtools)

glauca_map <- raster("./glauca/Algorithm/MXD/MSDMPosterior/A_glauca.tif")
glandulosa_map <- raster("./glandulosa/Algorithm/MXD/MSDMPosterior/A_glandulosa.tif")
andersonii_map <- raster("./andersonii/Algorithm/MXD/MSDMPosterior/A_andersonii.tif")
pechoensis_map <- raster("./pechoensis/Algorithm/MXD/MSDMPosterior/A_pechoensis.tif")

windows()
par(mfrow=c(2,2))
plot(glauca_map, main="A. glauca")
plot(glandulosa_map, main = "A. glandulosa")
plot(andersonii_map, main = "A. andersonii")
###Need to modify the code below to zoom in focal area
plot(pechoensis_map, main = "A. pechoensis")
dev.off()

##Set 0.8 suitability as a threshold for making binary map
make.binary.map <- function(model){
  
  ###Reclassify the raster; set threshold to minimum suitability score at a known occurrence
  threshold <- 0.8;
  
  M <- c(0, threshold, 0,  threshold, 1, 1); 
  
  rclmat <- matrix(M, ncol=3, byrow=TRUE); 
  
  Dist <- reclassify(model, rcl = rclmat);
}

glauca_binary_map <- make.binary.map(glauca_map)
glandulosa_binary_map <- make.binary.map(glandulosa_map)
andersonii_binary_map <- make.binary.map(andersonii_map)
pechoensis_binary_map <- make.binary.map(pechoensis_map)


windows()
par(mfrow=c(2,2))
plot(glauca_binary_map, main="A. glauca")
plot(glandulosa_binary_map, main = "A. glandulosa")
plot(andersonii_binary_map, main = "A. andersonii")
###Need to modify the code below to zoom in focal area
plot(pechoensis_binary_map, main = "A. pechoensis")
dev.off()



get_environmentaldata <- function(binary_projection, envt) {
  dist.points <-  rasterToPoints(binary_projection)#Need predicted occurrence points (calculated from thresholded model)
  hv.dat <- raster::extract(envt, dist.points[,1:2]);
  hv.dat <- hv.dat[complete.cases(hv.dat),];
  hv.dat <- scale(hv.dat, center=TRUE, scale=TRUE)
  #estimate_bandwidth(enaEnvt, method = "silverman")
  #enaExp <- expectation_ball(enaEnvt)
  #hv <- hypervolume(data = hv.dat, method = "box")
}


setwd("./env_layers_1km")
layer_list <- list.files(path = "./", pattern='.asc$', 
                         all.files=TRUE, full.names=FALSE)


allrasters <- lapply(layer_list, raster)
allrasters

#envt.subset <- stack(asc_rasters[[1]], asc_rasters[[2]])
envt.stack <- stack(allrasters)
crs(envt.stack) <- "+proj=longlat +datum=WGS84 +no_defs"


#x<- rasterToPoints(glauca_binary_map)
#class(x)
#summary(x)

glauca_env <- get_environmentaldata(binary_projection = glauca_binary_map, envt = envt.stack)
glauca_dist.points <-  rasterToPoints(glauca_binary_map)
glauca_env_table <- cbind(glauca_dist.points, glauca_env)
head(glauca_env_table)
write.csv(glauca_env_table, "../ENM_derieved_environmental_data/glauca_env.csv")

str(glauca_env)
###below step is very time-consuming
glacua_hv <- hypervolume(data = glauca_env, method = "box")


andersonii_env <- get_environmentaldata(binary_projection = andersonii_binary_map, envt = envt.stack)
andersonii_dist.points <-  rasterToPoints(andersonii_binary_map)
andersonii_env_table <- cbind(andersonii_dist.points, andersonii_env)
write.csv(andersonii_env_table, "../ENM_derieved_environmental_data/andersonii_env.csv")

andersonii_hv <- hypervolume(data = andersonii_env, method = "box")


pechoensis_env <- get_environmentaldata(binary_projection = pechoensis_binary_map, envt = envt.stack)
pechoensis_dist.points <-  rasterToPoints(pechoensis_binary_map)
pechoensis_env_table <- cbind(pechoensis_dist.points, pechoensis_env)
write.csv(pechoensis_env_table, "../ENM_derieved_environmental_data/pechoensis_env.csv")

pechoensis_hv <- hypervolume(data = pechoensis_env, method = "box")

glandulosa_env <- get_environmentaldata(binary_projection = glandulosa_binary_map, envt = envt.stack)
glandulosa_dist.points <-  rasterToPoints(glandulosa_binary_map)
glandulosa_env_table <- cbind(glandulosa_dist.points, glandulosa_env)
write.csv(glandulosa_env_table, "../ENM_derieved_environmental_data/glandulosa_env.csv")

glandulosa_hv <- hypervolume(data = glandulosa_env, method = "box")


hv_set1 <- hypervolume_set(hv1 = andersonii_hv, hv2 = glacua_hv, check.memory = F)
hypervolume_overlap_statistics(hv_set1)

hv_set2 <- hypervolume_set(hv1 = andersonii_hv, hv2 = glandulosa_hv, check.memory = F)
hypervolume_overlap_statistics(hv_set2)

hv_set3 <- hypervolume_set(hv1 = andersonii_hv, hv2 = pechoensis_hv, check.memory = F)
hypervolume_overlap_statistics(hv_set3)

hv_set4 <- hypervolume_set(hv1 = glandulosa_hv, hv2 = glacua_hv, check.memory = F)
hypervolume_overlap_statistics(hv_set4)

hv_set5 <- hypervolume_set(hv1 = glandulosa_hv, hv2 = pechoensis_hv, check.memory = F)
hypervolume_overlap_statistics(hv_set5)


hv_set6 <- hypervolume_set(hv1 = glacua_hv, hv2 = pechoensis_hv, check.memory = F)
hypervolume_overlap_statistics(hv_set6)




###try to visualize the matrix and do the clustering
####NOTES: save the excel into a txt file. remember to delete the first empty cell in the txt file.
#otherwise, you could see a waring: In storage.mode(m) <- "numeric" : NAs introduced by coercion
x <- read.table("../Niche_overlap_matric_jaccard.txt", sep = "\t")
y <- as.dist(as(x, "matrix"))

dist <- as.dist(1 - y)
species.tree <- hclust(dist, method="single")


windows()
plot(species.tree)
dev.off()


species.tree1 <- hclust(dist, method="single")
species.tree2 <- hclust(dist, method="complete")
species.tree3 <- hclust(dist, method="average")


windows()
par(mfrow=c(1,3))
plot(species.tree1)
plot(species.tree2)
plot(species.tree3)
dev.off()


windows()
#par(mfrow=c(1,2))
#for (i in 2:3){
#  plot(species.tree3)
# rect.hclust(species.tree, k=2)
#  }
species.tree3$height
plot(species.tree3)
#rect.hclust(species.tree3, h=0.9829897)
dev.off()


barplot(species.tree$height, names.arg = 3:1)
#install.packages("dendextend")
#library(dendextend)
#species.dend <- as.dendrogram(species.tree)
#nleaves(species.dend)
#nnodes(species.dend)

#otherwise, you could see a waring: In storage.mode(m) <- "numeric" : NAs introduced by coercion
x1 <- read.table("../Niche_overlap_matrix_sorensen.txt", sep = "\t")
y1 <- as.dist(as(x, "matrix"))

dist1 <- as.dist(1 - y1)


species.tree_1 <- hclust(dist1, method="single")
species.tree_2 <- hclust(dist1, method="complete")
species.tree_3 <- hclust(dist1, method="average")


windows()
par(mfrow=c(1,3))
plot(species.tree_1)
plot(species.tree_2)
plot(species.tree_3)
dev.off()


windows()
plot(species.tree_3)
dev.off()

