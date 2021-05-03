## National Deworming Day Replication Package
## Author: Michael Beeli 
## Section: Exploratory Data Analysis
## Function: Map of High Capacity/Double Treated States in India




library(tidyverse)
library(ggplot2)
library(maptools)
library(googlesheets4)
library(lubridate)
library(openintro)
library(maps)
library(ggthemes)
library(rgeos)
library(ggmap)
library(scales)
library(RColorBrewer)
library(sp)
library(rgdal)
library(raster)
set.seed(8000)
require(maps)
require(viridis)

map <- readRDS("/Users/michaelbeeli/Downloads/gadm36_IND_1_sp (1).rds")

ind1 = "Rajasthan"

spplot(map, "NAME_1",   scales=list(draw=T), colorkey=F, main="India")

ind1$NAME_1 =as.factor()









library(raster); library(ggplot2)
india <- getData('GADM', country="IND", level=1) 
f_india <- fortify(india)
i <- sapply(india@data$NAME_1, function(x) agrep(x, data$Row.Labels, max.distance=.3, ignore.case=T)[1]) 
india@data$maj <- data$MAJORITY[i]
f_india <- merge(x=f_india, y=unique(india@data), by.x="id", by.y="ID_1",all.x=T) 
f_india <- f_india[with(f_india, order(id, order)), ] # to prevent this http://stackoverflow.com/questions/24039621/code-not-working-for-other-shp-files
ggplot(f_india, aes(x=long, y=lat, group=group, fill=maj)) + 
  geom_polygon(colour="black") 


india <- getData("GADM", country = "India", level = 2)


india_map <- get_stamenmap(
  bbox = c(left=66.163 , bottom =6.058 , right =97.883 , top =35.392 ), 
  maptype = "toner-lite", zoom =5
)

regions <- data.frame(Region=c("Andaman and Nicobar Islands",  "Andhra Pradesh", "Arunachal Pradesh", "Assam", "Bihar", "Chhattisgarh", "Chandigarh", "Delhi", "Dadra and Nagar Haveli",  "Jammu and Kashmir", "Ladakh", "Lakshadweep",  "Goa", "Gujarat", "Haryana", "Himachal Pradesh", "Jharkhand", "Karnataka", "Kerala", "Madhya Pradesh", "Maharashtra", "Manipur", "Meghalaya", "Mizoram", "Nagaland", "Odisha", "Puducherry", "Punjab", "Rajasthan", "Sikkim", "Tamil Nadu", "Telangana", "Tripura", "Uttarakhand", "Uttar Pradesh", "West Bengal" ), 
                      treatment=c(1, 1, 1, 2, 2, 2, 1, 2, 2, 1, 1, 1, 1, 1, 2, 1, 1, 2, 1, 2, 2, 1, 1, 1, 1, 1, 1, 1, 2, 1, 2, 1, 2, 1, 1, 1))

ggmap(india_map)

states <- (subset(india, NAME_1 %in% regions$Region))

x=0
for (i in regions$Region) {
  x = x +1
  
  print(i)
  
  assign(paste0("ind_", x), i)

#indx <- states$ID_x[states$NAME_x == i]
  
}



foo <- data.frame(id = c(ind_1, ind_2, ind_3, ind_4, ind_5, ind_6, ind_7, ind_8, ind_9, ind_10, ind_11, ind_12, ind_13, ind_14, ind_15, ind_16, ind_17, ind_18, ind_19, ind_20, ind_21, ind_22, ind_23, ind_24, ind_25, ind_26, ind_27, ind_28, ind_29, ind_30, ind_31, ind_32, ind_33, ind_34), treat =rep(regions$treatment, times = c(length(ind_1), length(ind_2), length(ind_3), length(ind_4), length(ind_5), length(ind_6), length(ind_7), length(ind_8), length(ind_9), length(ind_10), length(ind_11), length(ind_12), length(ind_13), length(ind_14), length(ind_15), length(ind_16), length(ind_17), length(ind_18), length(ind_19), length(ind_20), length(ind_21), length(ind_22), length(ind_23), length(ind_24), length(ind_25), length(ind_26), length(ind_27), length(ind_28), length(ind_29), length(ind_30), length(ind_31), length(ind_32), length(ind_33), length(ind_34) )))
                 

ind1 <- states$ID_2[states$NAME_1 == "Telangana"]


states <- fortify(states)




shape <- readShapeSpatial('~/Dropbox/PhD_Arka/Exploratory Indian Data Analysis/India Shapefile With Kashmir/india_shapefile_git/Admin2.shp')

plot(shape)


india_map <- map_data("India")

## Map of Treated Regions 

states <- c("Andhra Pradesh")


