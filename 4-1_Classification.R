library(MASS)

#test data
data(package="MASS")
boston<-Boston
dim(boston)
names(boston)

require(randomForest)
set.seed(101)
train = sample(1:nrow(boston), 300)
rf.boston = randomForest(medv~., data = boston, subset = train)
rf.boston


##Start the real data

setwd("C:/Users/gzl02/Desktop/Yi2020Research/Ecological_differentiation_chapter/Niche_comparison/Classification")

dir = "C:/Users/gzl02/Desktop/Yi2020Research/Ecological_differentiation_chapter/Niche_comparison/Classification/input"

library(data.table)

multmerge = function(path){
  filenames=list.files(path=path, full.names=TRUE)
  rbindlist(lapply(filenames, fread))
}


combined <- multmerge(path = dir)

str(combined)
se{"cluster2"}
library(dplyr)

cluster1 <- c("A_obispoensis", "A_pilosula")
cluster2 <- c("A_klamathensis", "A_regismontana")
cluster3 <- c("A_nissenana", "A_montaraensis", "A_montana")
cluster4 <- c("A_ohloneana")
cluster5 <- c("A_edmundsii", "A_montereyensis", "A_hookeri")
cluster6 <- c("A_catalinae", "A_pumila")
cluster7 <- c("A_luciana", "A_auriculata", "A_hooveri", "A_silvicola", "A_malloryi", "A_gabilanensis", "A_myrtifolia", "A_virgata", "A_sensitiva")
cluster8 <- c("A_bakeri", "A_purissima", "A_pajaroensis", "A_otayensis", "A_confertiflora", "A_rainbowensis", "A_insularis", "A_pallida", "A_cruzensis","A_rudis")
cluster9 <- c("A_osoensis","A_glutinosa")
cluster10 <- c("A_andersonii", "A_pechoensis", "A_refugioensis", "A_morroensis", "A_nortensis", "A_viridissima")
x <- combined %>%
  mutate(cluster = case_when(
    species %in% cluster1 ~ "cluster1",
    species %in% cluster2 ~ "cluster2",
    species %in% cluster3 ~ "cluster3",
    species %in% cluster4 ~ "cluster4",
    species %in% cluster5 ~ "cluster5",
    species %in% cluster6 ~ "cluster6",
    species %in% cluster7 ~ "cluster7",
    species %in% cluster8 ~ "cluster8",
    species %in% cluster9 ~ "cluster9",
    species %in% cluster10 ~ "cluster10"
  ))


which(is.na(x))
#x[16021,]
df <- data.frame(x[,2:9])
str(df)
df$cluster <- as.factor(df$cluster)
df <- df %>% mutate(cluster_category = as.numeric(cluster))
df = df[,!names(df)=="cluster"]

write.table(df, "./classification_input_for_python.csv")
write.table(df, "./classification_input_for_python.txt", sep = "\t")

library(MASS)


#extract 70% data as traning data
train = sample(1:nrow(df), (nrow(df) * 0.7))

#install.packages("tree")
#library(ISLR)
require(tree)

#install.packages("partykit")
#install.packages("libcoin")
#install.packages("CHAID", repos="http://R-Forge.R-project.org")

require(CHAID)
require(purrr)
require(caret)


df %>%
  select_if(is.factor) %>%
  ncol

df %>%
  mutate(
    cluster = factor(cluster)
  ) %>% 
  str

cluster <- df %>% 
  select_if(is.factor)
dim(cluster)

##plot the distribution of numeric variables
library(tidyr)

df %>%
  select_if(is.numeric) %>%
  gather(metric, value) %>%
  ggplot(aes(value, fill = metric)) +
  geom_density(show.legend = FALSE) +
  facet_wrap( ~ metric, scales = "free")

##divide the data into bins
df %>% 
  mutate_if(is.numeric, funs(cut_number(., n=5)))

summary(df)
chaid.df <- chaid(cluster~ ., data = df)
print(chaid.df)


summary(tree.df)


