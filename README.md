# animated choropleth map of philadelphia (census tract level)
## Rent-Behavior-Preference-Change-Map-In-Philadelphia

 
## topic: tenure situation :the percentage of house renter occupied 
- time series : 2010 :2016 ( no earlier than 2010, in case of changing census boundaries)
- data source : NHGIS data 
## introducation:
   I developed a gif to deliver a idea about the tenure situation. And the data shows that people in the
   philadelphia county, are increasingly like to rent the house, instead of owners. The owners is decreasing 
  and the renters is increasing.
 
## Process:
   1. i downloaded the tenure data and did some filter and data process
      The most important step is to create the variabel :
      percentage of renters = renters/(renters+owners) (this should be calculated by each tract and year)
   2. plot the map for each year
   3 process data for whole percentage of renters for whole philadelphia county
   4. plot the line graph for each year
   5. combine the map 
   6. upload it online tool to create gif
   
## conclusion:
   From the animated choropleth map. the data shows a clear conclusion, peolple in philadelphia are more willing to 
 rent the house, instead of buying. 
 
## Problems and improvement (for class hour to ask the prof.Max)
    1. how to create a loop to simplify my data process block
    2. how to combine the graph without distrotion
    3. how to create the break using the ggplot, without define it early
    4. how to get more accessbile data from real estate
    5. when write the plot how to make it more clear without reconstruct the legend and other item's size.
- ![Logic](https://github.com/fangnandu/Rent-Behavior-Preference-Change-Map-In-Philadelphia/blob/master/rent%20behavior%20perference%20change%20map.gif "Logic")
