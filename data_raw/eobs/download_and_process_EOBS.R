# Load pkgs

library('loadeR')
library('transformeR')
library('rgdal')
library('raster')
library('latticeExtra')

# tutorials 
# http://www.meteo.unican.es/climate4R
# https://github.com/SantanderMetGroup/loadeR/wiki
# https://github.com/SantanderMetGroup/transformeR/wiki
# https://github.com/SantanderMetGroup/visualizeR/wiki 

# download data from EOBS (dec 2017)
# http://www.ecad.eu/download/ensembles/download.php#datafiles 

dir <- "C:/Users/alpelu/eobs"


# Load qp distribution
# Read spatial data 
qp<- rgdal::readOGR(dsn=paste0(dir,'/geo_data'),
                    layer = 'q_pyr_sn_4326', verbose = FALSE, encoding = "UTF-8")



# list files nc
list.files(dir, pattern = "\\.nc$")

# Doing inventory 
di <- dataInventory("C:/Users/alpelu/eobs/rr_0.25deg_reg_v16.0.nc")

# Define limits location: 

# Load data
preraw <- loadGridData(dataset = "C:/Users/alpelu/eobs/rr_0.25deg_reg_v16.0.nc", 
                    var = "rr", 
                    lonLim = c(-3.6, -3.2), 
                    latLim= c(36.75,37.25), 
                    aggr.m = "sum")

pre_cli_raw <- climatology(pre_raw)



spatialPlot(pre_cli,
            backdrop.theme = "none",
            scales = list(draw = TRUE)) + layer(sp.polygons(qp))


pre <- loadGridData(dataset = "C:/Users/alpelu/eobs/rr_0.25deg_reg_v16.0.nc", 
                    var = "rr", 
                    lonLim = c(-3.625,-3.375), 
                    latLim= c(36.875,37.125), 
                    aggr.m = "sum")
pre_cli <- climatology(pre)
spatialPlot(pre_cli,
            backdrop.theme = "none",
            scales = list(draw = TRUE)) + layer(sp.polygons(qp))

# See coordinates
pre_cli$xyCoords


# Create multigrids with variables

# Doing inventory 
ditg <- dataInventory("C:/Users/alpelu/eobs/tg_0.25deg_reg_v16.0.nc")
str(ditg)
ditn <- dataInventory("C:/Users/alpelu/eobs/tn_0.25deg_reg_v16.0.nc")
str(ditn)
ditx <- dataInventory("C:/Users/alpelu/eobs/tx_0.25deg_reg_v16.0.nc")
str(ditx)


pre <- loadGridData(dataset = "C:/Users/alpelu/eobs/rr_0.25deg_reg_v16.0.nc", 
                    var = "rr", 
                    lonLim = c(-3.625,-3.375), 
                    latLim= c(36.875,37.125), 
                    aggr.m = "sum")

tmea <- loadGridData(dataset = "C:/Users/alpelu/eobs/tg_0.25deg_reg_v16.0.nc", 
                    var = "tg", 
                    lonLim = c(-3.625,-3.375), 
                    latLim= c(36.875,37.125), 
                    aggr.m = "mean")

tmin <- loadGridData(dataset = "C:/Users/alpelu/eobs/tn_0.25deg_reg_v16.0.nc", 
                     var = "tn", 
                     lonLim = c(-3.625,-3.375), 
                     latLim= c(36.875,37.125), 
                     aggr.m = "mean")

tmax <- loadGridData(dataset = "C:/Users/alpelu/eobs/tx_0.25deg_reg_v16.0.nc", 
                     var = "tx", 
                     lonLim = c(-3.625,-3.375), 
                     latLim= c(36.875,37.125), 
                     aggr.m = "mean")


mg <- makeMultiGrid(pre, tmea, tmin, tmax)


# 
tmea_monthly <- climatology()


tmea_norte <- subsetGrid(tmea, lonLim = -3.375, latLim = 36.875)




objetos_eobs <- c(pre, tmea, tmin, tmax)
out_norte <- c()



separateNS <- function(objeto_eobs){ 
  
  clima_norte <- subsetGrid(objeto_eobs, lonLim = -3.375, latLim = 37.125)
  clima_sur <- subsetGrid(objeto_eobs, lonLim = -3.375, latLim = 36.875)
  
  aux_norte <- data.frame(
    value = clima_norte$Data,
    startDate = clima_norte$Dates$start,
    endDate = clima_norte$Dates$end, 
    lat = clima_norte$xyCoords$y,
    lon = clima_norte$xyCoords$x,
    variable = clima_norte$Variable$varName, 
    loc = "N")
  
  aux_sur <- data.frame(
    value = clima_sur$Data,
    startDate = clima_sur$Dates$start,
    endDate = clima_sur$Dates$end, 
    lat = clima_sur$xyCoords$y,
    lon = clima_sur$xyCoords$x,
    variable = clima_sur$Variable$varName,
    loc = "S")
  
  aux <- rbind(aux_sur, aux_norte)
  
  return(aux)
}


eobs_pre <- separateNS(pre)
eobs_tmea <- separateNS(tmea)
eobs_tmin <- separateNS(tmin)
eobs_tmax <- separateNS(tmax)

eobs_data <- rbind(eobs_pre, eobs_tmax, eobs_tmea, eobs_tmin)
write.csv(eobs_data, file="C:/Users/alpelu/eobs/eobs_data_robles.csv", row.names = FALSE)

