# Function to create a colunm with the hydrological year 
# It's based on https://stackoverflow.com/questions/27626533/r-create-function-to-add-water-year-column 

hydro_year <- function(dates, start_month=9) {
  # Convert dates into POSIXlt
  dates.posix = as.POSIXlt(dates)
  # Year offset
  offset = ifelse(dates.posix$mon >= start_month - 1, 1, 0)
  # Water year
  adj.year = dates.posix$year + 1900 + offset
  # Return the water year
  adj.year
}