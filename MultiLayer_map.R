#LIB LOAD-----------------------------------------------------------------------
#  LOAD libraries

library(ggplot2)
library(rworldmap)
library(leaflet)
library(ggmap)
library(rgdal)
library(wesanderson)
library(geojson)
library(geosphere)

#READ DF------------------------------------------------------------------------
#    READ the dataframes

players.df= read.csv("players.csv", sep = ";")
MVteams.df= read.csv("teams_MV.csv", sep = ";")
SAteams.df=read.csv("serieA.csv", sep = ";")
CO.df=read.csv("national_teams.csv", sep = ";")

#VAR MVTEAMS--------------------------------------------------------------------
#    ASSIGN values to VARIABLES
#    First I define the names of the teams in the MV league
#    Then I define the names of the manager of each MV team
#    Then I define the long, lat of the manager of each team,
#    and these locations are also used as headquarters for the teams.
#    To do so I use a small df so that I don't have doubles in
#    the variables.

MVteam= MVteams.df[,"team_name"]
manager=MVteams.df[,"manager"]
HQ_y=MVteams.df[,"lat"]
HQ_x=MVteams.df[,"lon"]

#VAR SA-TEAMS-------------------------------------------------------------------
#    Here I define the long, lat of each team in Serie A from a separate
#    df to avoid having each team more than once

SA_y=SAteams.df[,"SA_lat"]
SA_x=SAteams.df[,"SA_lon"]
SA_team=SAteams.df[,"serie_A_team"]

#VAR NATIONAL-TEAMS-------------------------------------------------------------
#   Here I define the long, lat of each National team
#   It's different from lines 84-85. Here I call the long,lat from CO.df, 
#   while in lines 84-85, I call the same variables from the players.df
#   I do this because here I just need to set the coords for each national
#   team represented in the MV league

CO_x=CO.df[,"player_lon"] 
CO_y=CO.df[,"player_lat"]
CO=CO.df[,"Nation"]

#VAR PLAYERS--------------------------------------------------------------------
#   Here I define the long, lat of each player using the coords of the
#   Serie A team, because I will later use these variables to assign
#   each player to his Serie A team.
#   I also define the player name (calling from the column "player" in the 
#   players.df) and in which MVteam they play (calling from the column 
#   "team_name" in players.df)

Player_x=players.df[,"SA_lon"]
Player_y=players.df[,"SA_lat"]
Player=players.df[,"player"]
SAteamofplayer=players.df[,"serie_A_team"]
PlayerMVteam=players.df[,"team_name"]

#PLAYERS COORDS-----------------------------------------------------------------
#    Here I define variables for the players coordinates,to plot the points
#    in the Leaflet map.
#    long is the column SA team of each player as drawn from players.df
#    lat is the column SA team of each player as drawn from players.df
#    NAME of each player as drawn from players.df - I need this for labels
#    MVteam of each player as drawn from players.df - I need this for popups

Player_name=c(Player[1:200]) 
playing_for=c(PlayerMVteam[1:200])
playing_in=c(SAteamofplayer[1:200])
Player_lon=c(Player_x[1:200]) 
Player_lat=c(Player_y[1:200]) 

#SA-TEAMS COORDS----------------------------------------------------------------
#    Here I define variables for the SA teams coordinates,to plot the points
#    in the Leaflet map.
#    I need these for the segments

SA_name=c(SA_team[1:20])
SA_lon=c(SA_x[1:20]) 
SA_lat=c(SA_y[1:20])

#MV-TEAMS COORDS----------------------------------------------------------------
#    Here I define variables for the MVteams coordinates,to plot the points
#    in the Leaflet map.
#    I need these for the segments

MV_name=c(MVteam[1:8]) 
HQ_lon=c(HQ_x[1:8]) 
HQ_lat=c(HQ_y[1:8]) 

#LOAD GeoJSON files-------------------------------------------------------------

FR= geojsonio::geojson_read("France_polygon.geojson")
PL= geojsonio::geojson_read("Poland_polygon.geojson")
IT= geojsonio::geojson_read("Italy_polygon.geojson")
ES= geojsonio::geojson_read("Spain_polygon.geojson")
IRQ= geojsonio::geojson_read("Iraq_polygon.geojson")

#ICONS--------------------------------------------------------------------------
#    DRAW custom icons for MARKER1(Players)
#    & MARKER2(National Teams) & MARKER3(MV team managers) using the
#    awesomeIcons libraries -  for MARKER4 & 5  I will use circle markers

icons = awesomeIcons(
  icon = 'ios-football',
  iconColor = 'white',
  library = 'ion',
  markerColor = "black")

icons2 = awesomeIcons(
  icon = 'ios-flag',
  iconColor = 'white',
  library = 'ion',
  markerColor = "red")

icons3 = awesomeIcons(
  icon = 'ios-body',
  iconColor = 'black',
  library = 'ion',
  markerColor = "white")

#LEAFLET MAP--------------------------------------------------------------------
#    Finally, GET THE LEAFLET MAP. Remember that in Leaflet, the "%>%" works
#    as the ",". Also, with the addTiles() - unless I specify otherwise, 
#    Leaflet will add default OpenStreetMap tiles

m= leaflet(players.df)%>% 
  addTiles()%>%  

#ADD MARKER1--------------------------------------------------------------------  
#    & Assign to overlayGroup.    

  addAwesomeMarkers(lng = Player_lon,
                    lat = Player_lat,
                    icon=icons,
                    popup = Player_name,
                    label = Player_name,
                    clusterOptions = markerClusterOptions
                    (showCoverageOnHover = FALSE,
                      zoomToBoundsOnClick = TRUE,
                      spiderfyOnMaxZoom = TRUE,
                      removeOutsideVisibleBounds = TRUE,
                      color= "#333331",
                      spiderLegPolylineOptions =
                        list(weight = 1.5, color = "#229", opacity = 0.5),
                      freezeAtZoom = FALSE),
                    group = "MV Players")%>% 
 
   addAwesomeMarkers(lng = Player_lon,
                    lat = Player_lat,
                    icon=icons,
                    popup = Player_name,
                    label = playing_for,
                    clusterOptions = markerClusterOptions
                    (showCoverageOnHover = FALSE,
                      zoomToBoundsOnClick = TRUE,
                      spiderfyOnMaxZoom = TRUE,
                      removeOutsideVisibleBounds = TRUE,
                      color= "#333331",
                      spiderLegPolylineOptions =
                        list(weight = 1.5, color = "#229", opacity = 0.5),
                      freezeAtZoom = FALSE),
                    group = "In which MV Team do MV Players play?")%>% 
  
 
   addAwesomeMarkers(lng = Player_lon,
                    lat = Player_lat,
                    icon=icons,
                    popup = Player_name,
                    label = playing_in,
                    clusterOptions = markerClusterOptions
                    (showCoverageOnHover = FALSE,
                      zoomToBoundsOnClick = TRUE,
                      spiderfyOnMaxZoom = TRUE,
                      removeOutsideVisibleBounds = TRUE,
                      color= "#333331",
                      spiderLegPolylineOptions =
                        list(weight = 1.5, color = "#229", opacity = 0.5),
                      freezeAtZoom = FALSE),
                    group = "In which Serie A team do the MV Players play?")%>%

#ADD MARKER2--------------------------------------------------------------------  
#    & Assign to overlayGroup.    

  addAwesomeMarkers(lng = CO_x,
                   lat = CO_y, 
                   icon=icons2,
                   label = CO,
                   popup = CO,
                   clusterOptions = markerClusterOptions
                   (showCoverageOnHover = FALSE,
                     zoomToBoundsOnClick = TRUE,
                     spiderfyOnMaxZoom = TRUE,
                     removeOutsideVisibleBounds = TRUE,
                     color= "#333331",
                     spiderLegPolylineOptions =
                       list(weight = 1.5, color = "#229", opacity = 0.5),
                     freezeAtZoom = FALSE),
                   group= "Which National Teams are represented in the MV League?")%>%

#ADD MARKER3--------------------------------------------------------------------  
#    & Assign to overlayGroup.    

  addAwesomeMarkers(lng = HQ_lon,
                  lat = HQ_lat, 
                  icon=icons3,
                  label = manager,
                  popup = MVteam,
                  group= "MV Teams")%>%
  
  addAwesomeMarkers(lng = HQ_lon,
                    lat = HQ_lat, 
                    icon=icons3,
                    label = manager,
                    popup = MVteam,
                    group= "Show MV teams")%>%
#ADD MARKER4--------------------------------------------------------------------  
#    & Assign to overlayGroup.    

  addCircleMarkers(lng = SA_lon,
                    lat = SA_lat, 
                    stroke=TRUE,
                    weight = 0.5,
                    color= "black",
                    radius=1.5,
                    opacity = 1,
                    fillColor = "red",
                    fillOpacity=1,
                    label = SA_name,
                    popup = SA_name,
                    group= "Show Serie A teams")%>%  

#SET MAP VIEW-------------------------------------------------------------------  
#    Set the view, meaning the "starting point" for the map. Remember that
#    for the zoom arg, a bigger number will zoom in, a smaller number will
#    zoom out.

setView(lng=22.142, lat=39.994, zoom = 4.3) %>% 
  
#ADD Custom Tiles---------------------------------------------------------------  
#    List of providers can be previewed here
#    http://leaflet-extras.github.io/leaflet-providers/preview/index.html

  addProviderTiles("CartoDB.Positron") %>%

#ADD GeoJSON files--------------------------------------------------------------  
#    Set color and appearance & Assign them to overlayGroup.

  addGeoJSON(FR,stroke = TRUE,
             color = "black",
             weight = 0.5,
             opacity = 1,
             fillColor = "lightgreen",
             fillOpacity = 1,
             group ="Where do we live?")%>%
  addGeoJSON(PL,stroke = TRUE,
             color = "black",
             weight = 0.5,
             opacity = 1,
             fillColor = "brown",
             fillOpacity = 1,
             group ="Where do we live?")%>%
  addGeoJSON(IT,stroke = TRUE,
             color = "black",
             weight = 0.5,
             opacity = 1,
             fillColor = "lightblue",
             fillOpacity = 1,
             group ="Where do we live?")%>%
  addGeoJSON(ES,stroke = TRUE,
             color = "black",
             weight = 0.5,
             opacity = 1,
             fillColor = "orange",
             fillOpacity = 1,
             group ="Where do we live?")%>%
  addGeoJSON(IRQ,stroke = TRUE,
             color = "black",
             weight = 0.5,
             opacity = 1,
             fillColor = "purple",
             fillOpacity = 1,
             group ="Where do we live?")%>%

#ADD MARKER5-------------------------------------------------------------------  
#    & Assign to overlayGroup.   

  addCircleMarkers(lng = HQ_lon,
                   lat = HQ_lat, 
                   stroke=TRUE,
                   weight = 0.5,
                   color= "blue",
                   radius=5,
                   opacity = 1,
                   fillColor = "white",
                   fillOpacity=1,
                   label = manager,
                   popup = manager,
                   group= "Where do we live?")%>%

#ADD LAYER CONTROL--------------------------------------------------------------  
#    
#    baseGroup=c() -> which map you see
#    overlayGroups=c()-> filter the map
#    hideGroup()-> which filter is already ticked off

addLayersControl(
  baseGroups = c("MV Teams", "MV Players"),
  overlayGroups = c("Where do we live?",
                    "Show MV teams",
                    "Show Serie A teams",
                    "In which Serie A team do the MV Players play?",
                    "In which MV Team do MV Players play?",
                    "Which National Teams are represented in the MV League?"),
  options = layersControlOptions(collapsed = TRUE)) %>%
  hideGroup("Show MV teams")%>%
  hideGroup("Where do we live?")%>%
  hideGroup("Show Serie A teams")%>%
  hideGroup("In which Serie A team do the MV Players play?")%>%
  hideGroup("In which MV Team do MV Players play?")%>%
  hideGroup("Which National Teams are represented in the MV League?")


#PRINT the map------------------------------------------------------------------  

print(m)


