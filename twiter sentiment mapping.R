library(tidyverse)
library(corrplot)
library(car)
library(spdep)
library(nlme)
library(tidycensus)
library(viridis)
library(spatialreg)
library(xtable)
library(maps)
library(maptools)
library(sp)
library(rgdal)
library(ggplot2)
library(spData)
library(RColorBrewer)
library(readxl)


setwd("/Users/kenny/Downloads") 
#load data
formap <- read_csv("Downloads/PHD degree preparation/GMU/HAP618 phyton/final project/twitter large data/formap.csv")

#get acs geo codes
us <- get_acs(geography = "state", 
              variables = "B01003_001", 
              geometry = TRUE)
View(us[,1:2])
##rename acs geo codes from cha. to num.
us$GEOID <- as.numeric(us$GEOID )
##merge acs and tweets data
data.usa <- merge(us,formap,by="GEOID")
##plot
ggplot(data.usa, aes(fill = data.usa$comp, color =data.usa$comp )) +
  geom_sf() +
  coord_sf(crs = 26914) +
  scale_fill_viridis(option = "magma") +
  scale_color_viridis(option = "magma")+
  labs(title = "sentiment")

