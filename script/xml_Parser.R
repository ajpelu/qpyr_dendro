library("XML")
#library('xml2')
#library(tidyverse)

machine <- 'ajpelu'
# machine <- 'ajpeluLap'
di <- paste0('/Users/', machine, '/Dropbox/phd/phd_repos/qpyr_dendro/', sep='')

# XML 
x <- paste0(di, 'data_raw/meteo/5514_base_aerea_monthly.xml')

# Create a tree with the elements of the XML document
doc <- xmlTreeParse(x, getDTD = FALSE)

r <- xmlRoot(doc)

# How many nodes 
xmlSize(r[[1]])

# Get metadata of estacion
xmlRoot(doc)[['Estacion']]

# Name station 
md_station <- as.data.frame(t(xmlSApply(r, xmlAttrs)))
rownames(md_station) <- NULL 

# Get variables 
md_variables <- as.data.frame(t(xmlSApply(r[['Estacion']][['Sensores']], xmlAttrs)))
rownames(md_variables) <- NULL


# Get all nodes of Estacion 
valores <- r[['Estacion']]

# Remove two first nodes
valores <- valores[-(1:2)]




aux_final <- c()

for (n in 1:xmlSize(valores)){ 

  # Get date 
  mydate <- xmlGetAttr(valores[[n]], "Fecha")
 
  # Get subnodes by date  
  subn <- xmlSize(valores[[n]])

  aux_valores <- c() 
    for (j in 1:subn){
      vb <- as.character(xmlAttrs(valores[[n]][[j]]))
      # vb <- as.character(xmlAttrs(valores[[800]][[1]]))
      value <- xmlValue(valores[[n]][[j]])
      # value <- xmlValue(valores[[800]][[1]])
      
      aux <- data.frame(vb, value, mydate)
      
      aux_valores <- rbind(aux_valores, aux)
    }
    
  aux_final <- rbind(aux_final, aux_valores)
}

  

  
  