# Ecological Differentiation Among Manzanita Species
In this project, I used Ecological Niche Modeling and clustering analysis to investigate the environmental differentiation among manzanita species.

#Overview

1_ENMTML_MSDS.R is used to construct the ecological niche models and obtain sepecies distribution maps of manzania species that have more than 10 occurence data. 

2_Fixed_ESM_methods.R is used to construt the ecological niche models and obtain sepecies distribution maps of manzanita species that have less than 10 occurence data. Remember to create a new R project for running this code.

3_niche_comparison.R composes three analysis: (1) extract environmental data from the presence pixel of distribution maps for every species. (2) use hypervolume method to quantify the niche of every species and generate a niche-comparison matrix by calculating pair-wise niche comparison. (3) apply hierachy clustering and k-means clustering to identify ecological distinct groups and assign species into those groups.

4-1_Classification.R and 4-2_Decision_tree.ipynb are used for multicalss classification analysis to intrepret what environmental factors distingusih these ecological distinct groups identifed in the clustering analysis.
