library("XML")
library('xml2')
library(tidyverse)

# machine <- 'ajpelu'
machine <- 'ajpeluLap'
di <- paste0('/Users/', machine, '/Dropbox/phd/phd_repos/qpyr_dendro/', sep='')

# XML 
x <- paste0(di, 'data_raw/meteo/5514_base_aerea_monthly.xml')

# Create a tree with the elements of the XML document
doc <- xmlTreeParse(x, getDTD = FALSE, encoding = 'ISO-8859-1')

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

valores[[800]][c('Medida')]

Dates 
d <- as.data.frame(t(xmlAttrs(valores[[1]])))


dd = sapply(xmlChildren(valores),
            function(x)
              xmlValue(x[['Valores']][['Medida']]))


tt = xmlSApply(r, xmlGetAttr, 'Fecha')


r <- xmlRoot(doc[[]])
ttt <- r[['Estacion']][[800]]

getSibling(ttt, after= FALSE)

cc = xmlSApply(r, "[[", 800)
mg = as.character(sapply(cc, xmlGetAttr, 'Medida'))

mg = as.numeric(xmlSApply(r, 
                          function(node)
                            xmlGetAttr(node[[800]], 'Medida')))


valores[[800]]
length(valores)
xmlSize(valores[[3]])

# Get dates 
xx <- xmlSApply(r[['Estacion']], xmlValue)


variables_names <- md_variables$ID

lapply(variables_names, 
       function(var) {
         xp = sprintf("//Medida[@ID= ´%s´]", var)
         xpathSApply(r, xp, xmlGetAttr, "value")
       })

xx[[3]]

xx[[1]]
xx[[2]]
xx[[3]]
xx[[4]]
xx[800]$Valores

out <- getNodeSet(r[[1]], "//Valores", fun=xmlToList)


t(xmlSApply(r[['Estacion']], xmlAttrs))

u <- xmlToList(r[['Estacion']][['Ubicacion']])

r[['Estaciones']]

sensor <- as.data.frame(sensor)

r[['Estacion']][['Sensores']]
xml_find_all(r, 'ID')





n <- getNodeSet(r, "Sensores")





getNodeSet(doc)


head(doc$file)
doc$children$Estaciones
doc[[1]][[1]]

class(doc$children$Estaciones)




# Read xml 
x <- read_xml()











x <- xmlParse(paste0(di, 'data_raw/meteo/5514_base_aerea_monthly.xml'))
d <- xmlRoot(x)

xmlValue(d[[//"Ubicacion"]])


rows = xmlApply(d,
                function(x)
                  xmlSApply(x, xmlValue))

xml_data <- xmlToList(data)


xml_data["Estacion"]$Estacion$Valores



# Read xml 
x <- read_xml(paste0(di, 'data_raw/meteo/5514_base_aerea_monthly.xml'))

# See structure 
xml_structure(x, indent = 4)
xml_text(xml_children(x))

xml_child(x, 'Valores')
xml_ns(x)

xml_type(x)



r <- xmlRoot(doc)

# How many nodes 
xmlSize(r)

xmlSize(r[[1]])




xmlSApply(xmlRoot(doc)[['Estaciones']], xmlSize)



sapply(xmlChildren(r[[1]]), xmlName)
sapply(xmlChildren(r[[1]]), xmlValue)


xmlSApply(r[[1]], xmlName)
xmlApply(r[[1]], xmlAttrs)
xmlSApply(r[[1]], xmlSize)

d$dtd




estacion <- xml_find_all(x, "//Estacion/Estacion")

e# Get variables 
sensor <- xml_find_all(x, "//Sensores")

vals <- xml_text(sensor)


library(XML)
doc<-xmlParse(paste0(di, 'data_raw/meteo/5514_base_aerea_monthly.xml'))
rd <- xmlRoot(doc)

# Get info about estacion
rd[[1]][1]$Ubicacion


xmlSApply(rd[
  xmlSApply(rd[[1]], xmlSize)
  
  
  
  
  
  ub <- xmlChildren(rootnode)[[1]][1]
  
  s <- sapply(xmlToDataFrame(), xmlValue)
  
  > cd.catalog <- data.frame(t(data),row.names=NULL)
  
  a <- xpathSApply(rootNode, "//Estaciones/Estacion/", xmlValue)                    
  
  
  xmldf <- xmlToDataFrame(nodes = getNodeSet(doc, "//Medida"))
  
  
  rr <- xml_find_all(estacion, "Valores")
  
  
  # See structure
  st <- xml_structure(x)
  
  # Get all nodesets with tag 'Valores'
  rr <- xml_find_all(x, "//Valores")
  
  d <- xml_find_all(recs, "//Medida")
  
  
  pg <- read_xml("http://www.ggobi.org/book/data/olive.xml")
  
  xml_name(x)
  xml_contents(x)
  
  x 
  rootnode <- xmlToDataFrame(paste0(di, 'data_raw/meteo/5514_base_aerea_monthly.xml'))
  
  
  
  
  
  xmltop = xmlRoot(data) #gives content of root
  class(xmltop)#"XMLInternalElementNode" "XMLInternalNode" "XMLAbstractNode"
  xmlName(xmltop) #give name of node, PubmedArticleSet
  xmlSize(xmltop[[1]]) #how many children in node, 19
  xmlName(xmltop[[1]]) #name of root's children
  
  xmlSApply(xmltop[[1]], xmlAttrs)
  
  xmlSApply(xmltop[[1]], xmlSize)
  xmltop[[1]][[310]]
  
  
  
  head(xmltop)
  
  xmltop[[1]][[3]]
  
  
  str(xmltop[[]][[3]])
  
  
  
  
  
  result <- as.data.frame(t(xmlSApply(data["/Estaciones/Estacion/Valores/Medida"],xmlAttrs)),
                          stringsAsFactors=FALSE)
  
  XML:::xmlAttrsToDataFrame(xmlRoot(data))
  getNodeSet(data)
  
  
  