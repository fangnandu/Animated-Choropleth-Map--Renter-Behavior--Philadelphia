# data wrangling and visualization 
# hw1 create an animated choropleth map of philadelphia( census tract level)
# 
# topic: tenure situation :the percentage of house renter occupied 
# time series : 2010 :2016 ( no earlier than 2010, in case of changing census boundaries)
# data source : NHGIS data
# 
# introducation:
#   I developed a gif to deliver a idea about the tenure situation. And the data shows that people in the
#   philadelphia county, are increasingly like to rent the house, instead of owners. The owners is decreasing 
#   and the renters is increasing.
# 
# Process:
#   1 i downloaded the tenure data and did some filter and data process
#      The most important step is to create the variabel :
#          percentage of renters = renters/(renters+owners) (this should be calculated by each tract and year)
#   2 plot the map for each year
#   3 process data for whole percentage of renters for whole philadelphia county
#   4 plot the line graph for each year
#   5 combine the map 
#   6 upload it online tool to create gif
#   
# conclusion:
#   From the animated choropleth map. the data shows a clear conclusion, peolple in philadelphia are more willing to 
# rent the house, instead of buying. 
# 
# Problems and improvement (for class hour to ask the prof.Max)
#    1 how to create a loop to simplify my data process block
#    2 how to combine the graph without distrotion
#    3 how to create the break using the ggplot, without define it early
#    4 how to get more accessbile data from real estate
#    5 when write the plot how to make it more clear without reconstruct the legend and other item's size.
  















# Code:


library(ggplot2)
library(maptools)
library(dplyr)
library(stringr)
library(sf)
library(tidyverse)
library(ggthemes)
# this can be used to read the shapefile instead of the readShapeSpatial commend 
# library(rgdal)
# fsas <- readOGR("d:/","philly-census-tract")
#1.1 data process
#import the the number of tenure  unprocessed data which is census tract level(from 20010-2016)
tenure2010 <- read.csv("tenure2010.csv")
#filter the data belongs to philadelphia county
phillytenure2010<-filter(tenure2010,COUNTY =='Philadelphia County')
# because we are going to look at the change of tenure percentage so we will create it
phillytenure2010percentage <- mutate(phillytenure2010, percentage = 100 *phillytenure2011$MS4E003  / phillytenure2011$MS4E001 )
#filter the useful 
phillytenure2010percentage<- phillytenure2010percentage %>%
  select(GISJOIN,COUNTY,TRACTA,percentage)
#round the percentage to integer and numeric it
phillytenure2010percentage$percentage<-round(phillytenure2010percentage$percentage)
phillytenure2010percentage$percentage <- as.numeric(as.character(phillytenure2010percentage$percentage))

#1.2 shapefile process and get the joined data with geospatial info.
#import then philadelphia shapefile
#fsas <- readShapeSpatial("census-tracts-philly.shp")
#data <- fortify(fsas, region = "GISJOIN")
#change the format of one column of processed tenure data 
phillytenure2010percentage$GISJOIN<- as.character(phillytenure2010percentage$GISJOIN)
#join it to the shapefile data
plotData <- left_join(data, phillytenure2010percentage, by=c("id" = "GISJOIN"))
#change the percentage to numeric
plotData$percentage <- as.numeric(as.character(plotData$percentage))

plotData[is.na(plotData)] <- 0

#1.3 plot the data into spatial 
#the color is from the color brewer http://colorbrewer2.org/#type=sequential&scheme=YlGnBu&n=5
pallete5_colors <- c('#ffffd9',"#edf8b1","#c7e9b4","#7fcdbb", "#41b6c4",'#1d91c0','#225ea8','#253494','#081d58')

#plot10_1<-
    ggplot() +
      geom_polygon(data = plotData, aes(x = long, y = lat, group = id,
                                        fill = percentage), color = "black", size =0.1) +
      annotate("text", label = "2011", x = -75.2, y = max(plotData$lat), color = "mediumblue", size =20)+
      coord_map() +# Mercator projection
      scale_fill_gradientn(colors = pallete5_colors,         
                           breaks=c(0,25,50,75,100)) +
      #scale_fill_brewer(palette="Greens") +
      labs(title = "Which year do people perfer to rent home ? ",
           subtitle = "Renter Occupation Percentage 
in Philadelphia, 2010-2016, by Census Tract",
           caption = "NHGIS Data",
           # remove the caption from the legend
           fill = "Renter percentage") +
      #set the plot theme
      theme_void() +
      theme(text = element_text(size = 25),
            plot.title = element_text(size = 33, face = "bold"),
            plot.subtitle = element_text(size = 25, face = 'italic' ),
            panel.background = element_rect(fill = "NA", colour = "#cccccc"),
            legend.text = element_text(size = 25),
            legend.key.size = unit(0.7, "in"),
            legend.position = c(.83, .25))#set the color scale,
    imagepath <- paste0("japan",".jpg") 
    png(file="11-2.png",width=800,height=800)
    print(plot10_1)
    dev.off()
    
    
    

  
  
  


#data process for the line chart
# 2010
data_10<-sum(phillytenure2010$JRKE003 )/ sum(phillytenure2010$JRKE001)
# the result is 0.44
#2011
#import the the number of tenure  unprocessed data which is census tract level(from 20010-2016)
tenure2010 <- read.csv("tenure2010.csv")

tenure2011 <- read.csv("tenure2011.csv")
tenure2012 <- read.csv("tenure2012.csv")
tenure2013 <- read.csv("tenure2013.csv")
tenure2014 <- read.csv("tenure2014.csv")
tenure2015 <- read.csv("tenure2015.csv")
tenure2016 <- read.csv("tenure2016.csv")
phillytenure2010<-filter(tenure2010,COUNTY =='Philadelphia County')

phillytenure2011<-filter(tenure2011,COUNTY =='Philadelphia County')
phillytenure2012<-filter(tenure2012,COUNTY =='Philadelphia County')
phillytenure2013<-filter(tenure2013,COUNTY =='Philadelphia County')
phillytenure2014<-filter(tenure2014,COUNTY =='Philadelphia County')
phillytenure2015<-filter(tenure2015,COUNTY =='Philadelphia County')
phillytenure2016<-filter(tenure2016,COUNTY =='Philadelphia County')

data_10<-sum(phillytenure2010$JRKE003 )/ sum(phillytenure2010$JRKE001)

data_11<-sum(phillytenure2011$MS4E003 )/ sum(phillytenure2011$MS4E001)
data_12<-sum(phillytenure2012$QX8E003 )/ sum(phillytenure2012$QX8E001)
data_13<-sum(phillytenure2013$UKOE003 )/ sum(phillytenure2013$UKOE001)
data_14<-sum(phillytenure2014$ABGXE003 )/ sum(phillytenure2014$ABGXE001)
data_15<-sum(phillytenure2015$ADP0E003 )/ sum(phillytenure2015$ADP0E001)
data_16<-sum(phillytenure2016$AF7PE003 )/ sum(phillytenure2016$AF7PE001)

#  4      dataplot11
dataplot10<-data.frame(c(2010:2016),c(data_10,NA,NA,NA,NA,NA,NA))
colnames(dataplot10) <- c('time','number')

PLOT1 <-ggplot(data=dataplot10, aes(x=time, y=number, group=1)) + 
  scale_y_continuous(name="percentage", limits=c(0.44, 0.48))+
  geom_point(aes(x = time, y = number),colour="red", size=4, shape=21, fill="red")+
  labs(title = "average rent occupation percentage for each year (2010-2016) ",
       caption = "Source : NHGIS Data")+
  # remove the caption from the legend
  theme_solarized_2(light = FALSE) +
  scale_colour_solarized("blue")+
  theme(text = element_text(size = 25),
        plot.title = element_text(size = 24, color = 'white',face = "bold"))
imagepath <- paste0("11",".jpg") 
png(file="10-1.png",width=800,height=400)
print(PLOT1)
dev.off()


dataplot11<-data.frame(c(2010:2016),c(data_10,data_11,NA,NA,NA,NA,NA))
colnames(dataplot11) <- c('time','number')
#plot the line chart
PLOT1<-ggplot(data=dataplot11, aes(x=time, y=number, group=1)) + 
  geom_line(colour="white", size=1.5) + 
  scale_y_continuous(name="percentage", limits=c(0.44, 0.48))+
  geom_point(aes(x = time[2], y = number[2]),colour="red", size=4, shape=21, fill="red")+
  labs(title = "average rent occupation percentage for each year (2010-2016) ",
       caption = "Source : NHGIS Data")+
  # remove the caption from the legend
  theme_solarized_2(light = FALSE) +
  scale_colour_solarized("blue")+
  theme(text = element_text(size = 25),
        plot.title = element_text(size = 24, color = 'white',face = "bold"))
imagepath <- paste0("11",".jpg") 
png(file="11-1.png",width=800,height=400)
print(PLOT1)
dev.off()

# 4   dataplot 12
dataplot12<-data.frame(c(2010:2016),c(data_10,data_11,data_12,NA,NA,NA,NA))
colnames(dataplot12) <- c('time','number')

PLOT1<-ggplot(data=dataplot12, aes(x=time, y=number, group=1)) + 
  geom_line(colour="white", size=1.5) + 
  scale_y_continuous(name="percentage", limits=c(0.44, 0.48))+
  geom_point(aes(x = time[3], y = number[3]),colour="red", size=4, shape=21, fill="red")+
  labs(title = "average rent occupation percentage for each year (2010-2016) ",
       caption = "Source : NHGIS Data")+
  # remove the caption from the legend
  theme_solarized_2(light = FALSE) +
  scale_colour_solarized("blue")+
  theme(text = element_text(size = 25),
        plot.title = element_text(size = 24, color = 'white',face = "bold"))
imagepath <- paste0("11",".jpg") 
png(file="12-1.png",width=800,height=400)
print(PLOT1)
dev.off()


# 4   dataplot 13
dataplot13<-data.frame(c(2010:2016),c(data_10,data_11,data_12,data_13,NA,NA,NA))
colnames(dataplot13) <- c('time','number')

PLOT1<-ggplot(data=dataplot13, aes(x=time, y=number, group=1)) + 
  geom_line(colour="white", size=1.5) + 
  scale_y_continuous(name="percentage", limits=c(0.44, 0.48))+
  geom_point(aes(x = time[4], y = number[4]),colour="red", size=4, shape=21, fill="red")+
  labs(title = "average rent occupation percentage for each year (2010-2016) ",
       caption = "Source : NHGIS Data")+
  # remove the caption from the legend
  theme_solarized_2(light = FALSE) +
  scale_colour_solarized("blue")+
  theme(text = element_text(size = 25),
        plot.title = element_text(size = 24, color = 'white',face = "bold"))
imagepath <- paste0("11",".jpg") 
png(file="13-1.png",width=800,height=400)
print(PLOT1)
dev.off()


## 4   dataplot 14
dataplot14<-data.frame(c(2010:2016),c(data_10,data_11,data_12,data_13,data_14,NA,NA))
colnames(dataplot14) <- c('time','number')

PLOT1<-ggplot(data=dataplot14, aes(x=time, y=number, group=1)) + 
  geom_line(colour="white", size=1.5) + 
  scale_y_continuous(name="percentage", limits=c(0.44, 0.48))+
  geom_point(aes(x = time[5], y = number[5]),colour="red", size=4, shape=21, fill="red")+
  labs(title = "average rent occupation percentage for each year (2010-2016) ",
       caption = "Source : NHGIS Data")+
  # remove the caption from the legend
  theme_solarized_2(light = FALSE) +
  scale_colour_solarized("blue")+
  theme(text = element_text(size = 25),
        plot.title = element_text(size = 24, color = 'white',face = "bold"))
imagepath <- paste0("11",".jpg") 
png(file="14-1.png",width=800,height=400)
print(PLOT1)
dev.off()


## 4   dataplot 15
dataplot15<-data.frame(c(2010:2016),c(data_10,data_11,data_12,data_13,data_14,data_15,NA))
colnames(dataplot15) <- c('time','number')

PLOT1<-ggplot(data=dataplot15, aes(x=time, y=number, group=1)) + 
  geom_line(colour="white", size=1.5) + 
  scale_y_continuous(name="percentage", limits=c(0.44, 0.48))+
  geom_point(aes(x = time[6], y = number[6]),colour="red", size=4, shape=21, fill="red")+
  labs(title = "average rent occupation percentage for each year (2010-2016) ",
       caption = "Source : NHGIS Data")+
  # remove the caption from the legend
  theme_solarized_2(light = FALSE) +
  scale_colour_solarized("blue")+
  theme(text = element_text(size = 25),
        plot.title = element_text(size = 24, color = 'white',face = "bold"))
imagepath <- paste0("11",".jpg") 
png(file="15-1.png",width=800,height=400)
print(PLOT1)
dev.off()

## 4   dataplot 16
dataplot16<-data.frame(c(2010:2016),c(data_10,data_11,data_12,data_13,data_14,data_15,data_16))
colnames(dataplot16) <- c('time','number')

b<-ggplot(data=dataplot16, aes(x=time, y=number, group=1)) + 
  geom_line(colour="white", size=1) + 
  scale_y_continuous(name="percentage", limits=c(0.44, 0.48))+
  geom_point(aes(x = time[7], y = number[7]),colour="red", size=4, shape=21, fill="red")+
  labs(title = "average rent occupation percentage for each year (2010-2016) ",
       caption = "Source : NHGIS Data")+
       # remove the caption from the legend
  theme_solarized_2(light = FALSE) +
  scale_colour_solarized("blue")+
  theme(text = element_text(size = 25),
        plot.title = element_text(size = 24, color = 'white',face = "bold"))
imagepath <- paste0("11",".jpg") 
png(file="11.png",width=800,height=400)
print(b)
dev.off()


library(gridExtra)

grid.arrange(a, b, ncol = 2, main = "Main title")
grid.arrange(plot10_1, b,heights = c(0.65,0.35),ncol = 1)

