#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(leaflet)
library(dplyr)


# data<-read.csv("/srv/shiny-server/apps/stlmap/Homicide2008.csv")
# datatwo<-read.csv("/srv/shiny-server/apps/stlmap/Homicide2009.csv")
# datathree<-read.csv("/srv/shiny-server/apps/stlmap/Homicide2010.csv")
# datafour<-read.csv("/srv/shiny-server/apps/stlmap/Homicide2011.csv")
# datafive<-read.csv("/srv/shiny-server/apps/stlmap/Homicide2012.csv")
# datasix<-read.csv("/srv/shiny-server/apps/stlmap/Homicide2013.csv")
# dataseven<-read.csv("/srv/shiny-server/apps/stlmap/Homicide2014.csv")
# dataeight<-read.csv("/srv/shiny-server/apps/stlmap/Homicide2015.csv")


data<-read.csv("~/stlmap/Homicide2008.csv")
datatwo<-read.csv("~/stlmap/Homicide2009.csv")
datathree<-read.csv("~/stlmap/Homicide2010.csv")
datafour<-read.csv("~/stlmap/Homicide2011.csv")
datafive<-read.csv("~/stlmap/Homicide2012.csv")
datasix<-read.csv("~/stlmap/Homicide2013.csv")
dataseven<-read.csv("~/stlmap/Homicide2014.csv")
dataeight<-read.csv("~/stlmap/Homicide2015.csv")



# Define server logic required to draw a histogram
server <- shinyServer(function(input, output) {
  icon.home <- makeAwesomeIcon(icon= 'star', markerColor = "white", iconColor = 'black',spin = TRUE)
  icon.home2 <- makeAwesomeIcon(icon= 'star', markerColor = 'purple', iconColor = 'black',spin = TRUE)
  icon.home3 <- makeAwesomeIcon(icon= 'star', markerColor = 'darkgreen', iconColor = 'black',spin = TRUE)
  icon.home4 <- makeAwesomeIcon(icon= 'star', markerColor = 'darkred', iconColor = 'black',spin = TRUE)
  icon.home5 <- makeAwesomeIcon(icon= 'star', markerColor = 'blue', iconColor = 'black',spin = TRUE)
  icon.home6 <- makeAwesomeIcon(icon= 'star', markerColor = 'orange', iconColor = 'black',spin = TRUE)
  icon.home7 <- makeAwesomeIcon(icon= 'star', markerColor = 'pink', iconColor = 'black',spin = TRUE)
  icon.home8 <- makeAwesomeIcon(icon= 'star', markerColor = 'green', iconColor = 'black',spin = TRUE)
  
  # 
  # produce the basic leaflet map with single marker
   
    map<- leaflet() %>%
      # setView(-38.6270, 90.1994, zoom = 1) %>%
      addTiles(group = "OSM (default)") %>%
      addProviderTiles("Stamen.Toner", group = "Toner") %>%
      addProviderTiles("Stamen.TonerLite", group = "Toner Lite") %>%
      addProviderTiles("Stamen.Watercolor", group = "Watercolor") %>%
      addProviderTiles("CartoDB.Positron", group="Carto")%>%
      addProviderTiles("Esri.WorldImagery", group="Esri")%>%
      addProviderTiles("Esri.WorldStreetMap", group="Esri2")%>%
      addProviderTiles("OpenTopoMap", group="Topo")%>%
      addTiles() %>%  # Add default OpenStreetMap map tiles
      addAwesomeMarkers(data = data,popup = ~Address,  group = "2008", icon =  icon.home)%>%
      addAwesomeMarkers(data = datatwo,popup = ~Address,group = "2009",icon = icon.home2)%>%
      addAwesomeMarkers(data = datathree,popup = ~Address,group = "2010",icon =  icon.home3)%>%
      addAwesomeMarkers(data = datafour,popup = ~Address,group = "2011",icon =  icon.home4)%>%
     # addAwesomeMarkers(data = datafive,popup = ~Address,group = "2012",icon =  icon.home6)%>%
      addAwesomeMarkers(data = datasix,popup = ~Address,group = "2013", icon = icon.home5)%>%
      addAwesomeMarkers(data = dataseven,popup = ~Address,group = "2014", icon = icon.home7)%>%
      addAwesomeMarkers(data = dataeight,popup = ~Street,group = "2015", icon = icon.home8)%>%
      addLegend(position = "topright",title = "Saint Louis Homicides 2008-2015", colors = c("white","purple","darkgreen","darkred","orange","blue","pink","green"),labels = c("2008","2009","2010","2011","2012","2013","2014","2015"))%>%
      addLayersControl(
        baseGroups = c("OSM", "Toner", "Toner Lite","Watercolor","Carto","Esri","Esri2","Topo"),
        ##Postition can be topright,bottomright,topleft,bottomleft
        overlayGroups = c("2008","2009","2010","2011","2012","2013","2014","2015"),
        ##Control Options set to True collapses Control unti it is hovered over
        options = layersControlOptions(collapsed = TRUE)
      )
  
  output$mymap <- renderLeaflet(map)
})

