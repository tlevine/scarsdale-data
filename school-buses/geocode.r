#!/usr/bin/env Rscript
# Baeed on
# https://raw.github.com/gist/3834498/bc34457d67a5639af8bc9fab6093644c3eec4b65/gistfile1.rebol

library('rjson') # For parsing json in R
library('RCurl') # For sending an http request
library('plyr')  # For ddply

geocode <- function(query) {

  # Avoid rate limits by pausing from 1 to 3 seconds
  Sys.sleep(sample(seq(1, 3, by=0.001), 1))

  # Compose the URL.
  url.base <- "http://maps.googleapis.com/maps/api/geocode/json?address="
  url <- paste(url.base, URLencode(query, reserved = T), "&sensor=false", sep="")

  #
  # Download.
  #

  # Try with getURL.
  geo.text <- try(getURL(url))
  
  # If it didn't work with getURL, give it a go with readLines.
  if(class(geo.text)=="try-error"){
    geo.text = try(readLines(url))
  }
  
  # Give up.
  if (class(geo.text)=="try-error"){
    print(paste("having trouble reading this query:", query))
  }
  
  #
  # Parse.
  #
  geo.json <- fromJSON(geo.text)

  # There are other data points you can grab but I'm most interested in these. 
  if(geo.json$status == "OK"){
    print(query)
    lat = geo.json$results[[1]]$geometry$location$lat
    lng = geo.json$results[[1]]$geometry$location$lng
    type = geo.json$results[[1]]$geometry$location_type
    info <- data.frame(query, lat, lng, type, stringsAsFactors=F)
    return(info)
  } else{
    if(geo.json$status == "OVER_QUERY_LIMIT") {
      stop(paste("Hit rate limit at:", query))
    } 
  }
}                

do.geocode <- function(){
  stops <- read.csv('bus_stops.csv')

  # Add an identifier row.
  stops$id <- row.names(stops)

  stops.geocoded <- ddply(stops, .(id), function(df){
    # Add "Scarsdale, NY" to the location.
    location <- paste(df[1,'location'], ', Scarsdale, NY', sep = '')

    # Geocode.
    geocode(location)
  }, .progress = 'text')
  stops <- join(stops, stops.geocoded, by = 'id')

  # Order the new file the same as the old one so they are easily related.
  stops <- stops[order(as.numeric(stops$id)),]

  # Remove the identifier row.
  stops$id <- NULL

  write.csv(stops, file = 'bus_stops-geocoded.csv', row.names = F)

  stops
}

do.plot <- function() {
  stops <- read.csv('bus_stops-geocoded.csv', stringsAsFactors = T)
  stops$direction <- factor(grepl('am', stops$time), levels = c(T, F))
  levels(stops$direction) <- c('am', 'pm')
# ggplot(stops) + aes(x = lng, y = lat, group = route.name, color = direction) + geom_path() 
}
