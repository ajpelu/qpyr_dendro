# Function ton compute Percentage of Growth Change using the approach of Nowacki and Abrams 1997. Ecol. Monograph. 67(2):225
# Arguments: 
# * dfrwl: a RWL dataframe
# * ws: window size: the 
# * prefijo: name of the series site, i.e.: 'CA' 


computeGC <- function(dfrwl, ws, prefijo){ 
  require(dplyr)
  require(stringr)
  
  # window_size 
  ws <- as.numeric(ws) 
  # n_series (or n_series by tree)
  name_series <- colnames(dfrwl)
  
  out_gc <- c() 
  
  for (ns in name_series){ 
    # selected series 
    ss <- dfrwl %>% 
      dplyr::select_(.dots = ns) %>% 
      mutate(year = as.numeric(row.names(.))) %>% 
      na.omit() %>% 
      as.data.frame()
    
    # Range years 
    range_years <- (min(ss$year)+ws):(max(ss$year)-ws)
    
    aux_serie <- c()
    
    for (y in range_years){
      # subsequent and precedent subset 
      m2 <- ss %>% filter(year > y & year <= (y+ws)) %>% data.frame()
      m1 <- ss %>% filter(year <= y & year >= (y-ws+1)) %>% data.frame()
      # mean values
      mean_m2 <- mean(m2[,1])
      mean_m1 <- mean(m1[,1])
      # GC 
      gc = ((mean_m2 - mean_m1) / mean_m1) * 100 
      
      # out 
      gc_aux <- data.frame(gc = gc, year = y, name_serie = ns)
      gc_aux$tree <- as.numeric(stringr::str_replace(gc_aux$name_serie, prefijo, ""))
      
      aux_serie <- rbind(aux_serie, gc_aux)
    }
    
    # Out 
    out_gc <- rbind(out_gc, aux_serie)
  }
  return(out_gc)
}
