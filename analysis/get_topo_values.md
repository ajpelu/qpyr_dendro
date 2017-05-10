``` r
library("tidyverse")
library("raster")
library("stringr")
library('rgdal')
library("sp")
```

Read and prepare data
=====================

``` r
machine <- 'ajpelu'
# machine <- 'ajpeluLap'
di <- paste0('/Users/', machine, '/Dropbox/phd/phd_repos/qpyr_dendro/', sep='')


# Read spatial data 
# Centroid of focal tree 
## filename 
mygpx_ca <- paste0(di, 'data_raw/geoinfo/dendro_ca.GPX')
mygpx_sj <- paste0(di, 'data_raw/geoinfo/dendro_sj.GPX')

## reading  
field_work_ca <- readOGR(mygpx_ca, layer="waypoints", verbose = FALSE)
field_work_sj <- readOGR(mygpx_sj, layer="waypoints", verbose = FALSE)
```

Topographic data
================

``` r
# Get Elevation and derivate data 
# We use DEM fron SN 

# Connect with NAS and copy the mde file located at 
# '/cartografia/Informacion_Ambiental/BASES_DE_REFERENCIA_TERRITORIAL/MDE_SN_AreaInfluecia_10m/mde_sn_area_influencia.asc' 
ditemp <- paste('/Users/', machine, '/Documents/', sep='')
setwd(ditemp)

# read DEM 
demsn <- raster("mde_sn_area_influencia.asc")

setwd(di)

## Projection 
# Get projection
projection(demsn)

# Set projection
crs(demsn) <- "+proj=utm +zone=30 +ellps=WGS84 +datum=WGS84 +units=m +no_defs"

# Get slope and aspect 
slopesn10 <- terrain(demsn, opt="slope", unit = 'degrees')
aspectsn10 <- terrain(demsn, opt="aspect", unit = 'degrees')

# Reproject spatial info of trees 
field_work_ca_re <- spTransform(field_work_ca, crs(demsn))
field_work_sj_re <- spTransform(field_work_sj, crs(demsn))

# Extract elev 
ca_elev <- extract(demsn, field_work_ca_re, method = 'simple', sp=TRUE)
sj_elev <- extract(demsn, field_work_sj_re, method = 'simple', sp=TRUE)

# Extract Slope
ca_slope <- extract(slopesn10, field_work_ca_re, method = 'simple', sp=TRUE)
sj_slope <- extract(slopesn10, field_work_sj_re, method = 'simple', sp=TRUE)

# Extract Aspect 
ca_aspect <- extract(aspectsn10, field_work_ca_re, method = 'simple', sp=TRUE)
sj_aspect <- extract(aspectsn10, field_work_sj_re, method = 'simple', sp=TRUE)

## Reorganize and join 
ca_elev_s <- as.data.frame(ca_elev) %>% 
  dplyr::select(name, mde = mde_sn_area_influencia)

ca_slope_s <- as.data.frame(ca_slope) %>% 
  dplyr::select(name,slope)

ca_aspect_s <- as.data.frame(ca_aspect) %>% 
  dplyr::select(name,aspect)
    
ca_topo <- ca_elev_s %>% left_join(ca_slope_s, by='name') %>% left_join(ca_aspect_s, by= 'name')


## Reorganize and join 
sj_elev_s <- as.data.frame(sj_elev) %>% 
  dplyr::select(name, mde = mde_sn_area_influencia)

sj_slope_s <- as.data.frame(sj_slope) %>% 
  dplyr::select(name,slope)

sj_aspect_s <- as.data.frame(sj_aspect) %>% 
  dplyr::select(name,aspect)
    
sj_topo <- sj_elev_s %>% left_join(sj_slope_s, by='name') %>% left_join(sj_aspect_s, by= 'name')

# Join all sites and convert aspect into categorical 
topo <- sj_topo %>% rbind(ca_topo) %>% 
  mutate(aspectF = cut(aspect, 
                       breaks= c(0,22.5, 67.5, 112.5, 157.5, 202.5, 247.5, 292.5, 337.5, 359.5),
                       labels = c("N", "NE", "E", "SE", "S", "SW", "W", "NW","N")))



# Export data
write.csv(topo, file=paste(di, "/data/topo/topo.csv", sep=""), row.names = FALSE)
```