###
# This code is part of a job application
# Origo, Oslo Kommune
# March 2020
# Marte Nordin
###

###################################################################################################
# This code collects data on city bikes from an open API.
# Small alterations to the data is done in the code, then output as a CSV to be used in PowerBI
###################################################################################################


# Libraries for API
library(httr)
library(curl)
library(jsonlite)

# Calls to the API
url = "https://gbfs.urbansharing.com/oslobysykkel.no/station_information.json" # Info about the bike stations
url_status <- "https://gbfs.urbansharing.com/oslobysykkel.no/station_status.json" # Real time data from bike stations


# Call API to get the station info
get_api_stations <- GET(url, add_headers('Client-Identifier' = "Origo-JobbSøknadsCase")) # Call API

text <- content(get_api_stations, "text") # Get content of the response
data <- jsonlite::fromJSON(text, flatten = TRUE) # Flatten the content

# Store data as flat table
Stations <- data$data$stations 


# Call API to get the data from the stations
get_api_status <- GET(url_status, add_headers('Client-Identifier' = "Origo-JobbSøknadsCase")) # Call API

text <- content(get_api_status, "text") # Get content of the response
data <- jsonlite::fromJSON(text, flatten = TRUE)  # Flatten the content


# Store data as flat table
Status <- data$data$stations

#####################################
# Transform data for reporting
#####################################

Bikes <- merge(Stations,Status, by = "station_id", all = TRUE) # Join to one dataset

# Converting the time
Bikes$last_reported <-  as.POSIXct(Bikes$last_reported , origin = "1970-01-01")


# Merge the station names with the adress, to get one searchable field for end user
Bikes$name <- ifelse(Bikes$name != Bikes$address, paste(Bikes$name, Bikes$address, sep = " / "), Bikes$name)

# Reduce columns
keep_Bikes <- c("station_id","name","lat","lon", "last_reported", "num_bikes_available", "num_docks_available")
Bikes <- Bikes[keep_Bikes]


# Create columns to filter the data based on availiability of Bikes and Locks
Bikes$LedigeSykler <- ""
Bikes$LedigDock <- ""

Bikes$LedigeSykler[Bikes$num_bikes_available > 0] <- "Vis ledige sykler"
Bikes$LedigDock[Bikes$num_docks_available > 0] <- "Vis ledige låser"



# Write data to file, as the default option to get data into PowerBI
write.csv2(Bikes, file="C:/Users/marte.nordin/Bysykler.csv", row.names = FALSE)
