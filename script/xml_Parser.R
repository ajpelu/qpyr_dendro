library("XML")
library('tidyverse')

# WD 
# machine <- 'ajpelu'
machine <- 'ajpeluLap'
di <- paste0('/Users/', machine, '/Dropbox/phd/phd_repos/qpyr_dendro/', sep='')

# read xmls 

f <- list.files(paste0(di, 'data_raw/meteo/'))

for (m in seq_along(f)){
  
  # get name of file 
  name_f <- str_replace(f[1], pattern = '.xml', '')
  
  # get file 
  xml_file <- paste0(di, 'data_raw/meteo/', f[1]) 
  
  # Parse file
  # Create a tree with the elements of the XML document
  doc <- xmlTreeParse(xml_file, getDTD = FALSE)
  
  # rootXML
  r <- xmlRoot(doc)
  
  # Get Name station 
  md_station <- as.data.frame(t(xmlSApply(r, xmlAttrs)))
  rownames(md_station) <- NULL 
  
  # Get name variables 
  md_variables <- as.data.frame(t(xmlSApply(r[['Estacion']][['Sensores']], xmlAttrs)))
  rownames(md_variables) <- NULL
  
  
}

x <- paste0(di, 'data_raw/meteo/5514_base_aerea_monthly.xml')





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

  

  
  
