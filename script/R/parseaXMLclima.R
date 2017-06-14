## Function to parser REDIAM XML Climate data 
# @ajpelu 2017 
# A custom function to parser the climate data 
# nameXML: '5514_base_aerea_dialy.xml' 
# path: paste0(di, 'data_raw/meteo/') 

parseaXMLclima <- function(nameXML, path){ 
  require('XML')
  require('stringr')
  require('lubridate')
  
  # get name of file 
  name_f <- str_replace(nameXML, pattern = '.xml', '')
  
  # get file 
  xml_f <- paste0(path, nameXML)
  
  # Parse file
  # Create a tree with the elements of the XML document
  doc <- xmlTreeParse(xml_f, getDTD = FALSE)
  
  # rootXML
  r <- xmlRoot(doc)
  
  # Get Name station 
  md_station <- as.data.frame(t(xmlSApply(r, xmlAttrs)))
  rownames(md_station) <- NULL 
  
  # Get name variables 
  md_variables <- as.data.frame(t(xmlSApply(r[['Estacion']][['Sensores']], xmlAttrs)))
  rownames(md_variables) <- NULL
  
  # Get all nodes of Estacion 
  valores <- r[['Estacion']]
  
  # Remove two first nodes
  valores <- valores[-(1:2)]
  
  # Create dataframe 
  formateados <- c()
  
  for (n in 1:xmlSize(valores)){ 
    # Get date 
    mydate <- xmlGetAttr(valores[[n]], "Fecha")
    
    # Get subnodes by date  
    subn <- xmlSize(valores[[n]])
    
    aux_valores <- c() 
    for (j in 1:subn){
      vb <- as.factor(as.character(xmlAttrs(valores[[n]][[j]]))) 
      value <- as.numeric(xmlValue(valores[[n]][[j]])) 
      
      aux <- data.frame(vb, value)
      
      aux_valores <- rbind(aux_valores, aux)
    }
    
    aux_valores$date <- dmy(mydate)
    
    formateados <- rbind(formateados, aux_valores)
  }
  
  out <- list() 
  out$station <- md_station
  out$variables <- md_variables
  out$values <- formateados
  return(out) 
} 

