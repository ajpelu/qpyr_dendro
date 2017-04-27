# Name: rw_byTree

# Compute rw mean by tree
# This function needs a dataframe with the ring width measurements (a dataframe of the class 'rwl' from dplR pkg) 
# It creates a new dataframe with the average value of the ring width (RW) by tree; and also a varible with the year. 
# Tree names coming from colnames of the dataframe (see from class::rwl). The colnames of this rwl have the 
# following structure: SNA0101 (SNA|id_tree|id_core). 
 
rw_byTree <- function(rwdf){ 
  require(dplyr)
  
  # Create output with rownmaes (year) as a variable 
  output_avg <- rwdf %>% 
    mutate(year = as.numeric(rownames(.))) %>% 
    dplyr::select(year)
  
  # Get name of each tree (each serie: i.e.:  SNA0101 (SNA|id_tree|id_core)) 
  tree_names <- unique(stringr::str_sub(names(rwdf), start=1, end=5))
  
  # Loop 
  for (i in tree_names) {
    # Create a variable name for the average by tree 
    name_avg <- paste0('rw_',stringr::str_sub(i, star=3, end=5))
    
    # Create aux dataframe with rwl mean values and the year
    aux <- rwdf %>% 
      dplyr::select(starts_with(i)) %>% 
      mutate_(.dots = setNames(list(~rowMeans(., na.rm=TRUE),
                                    ~as.numeric(rownames(.))),
                               nm=c(name_avg, "year"))) %>% 
      dplyr::select(-starts_with(i))
    
    # Inner join with output by year  
    output_avg <- output_avg %>% inner_join(aux, by='year')
  }
  
  # Change NaN by NA
  output_avg[is.na(output_avg)] <- NA
  
  output_avg
}
