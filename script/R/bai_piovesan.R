## BAI Function Piovesan 

## See Piovesan et al. 2008 http://dx.doi.org/10.1111/j.1365-2486.2008.01570.x 
## BAI = (pi/4)*[ (dbh_{t})^2 - [dbh_{t} - 2*w_{t}]^2 ] 
## r_{t} = r_{t-1} + w_{t} 

bai_piovesan <- function(rwdf, diam_df){
  # rwdf: a ringwidth dataframe. row: years; col: id_cores
  # diam_df: a dataframe with two columns: 
  #   * diameter = diameter 
  #   * id = id_core or id_tree or whatever 
  
  # Output 
  bai <- rwdf 
  
  if("nseries" %in% colnames(rwdf)) { 
    rwdf <- subset(rwdf, select=-nseries)
    }


  # length years in Ring-width Data frame 
  vec_ly <- seq_len(nrow(rwdf))
  
  # ID cores 
  cores <- colnames(rwdf)
  
  
  for (i in cores){ 
    # 1 # Select core 
    id_core <- i 
    
    # 2 # Select ring width serie 
    rws <- rwdf[[id_core]]
    
    # 3 # Select diameter 
    dbh <- subset(diam_df, id == id_core)
    dbh <- dbh$diameter
    
    # 4 # Prepare data to compute bai 
    #### Omit NA 
    rwsomit <- na.omit(rws)
    
    #### Revert w 
    rws_rev <- rev(rwsomit)
    
    # Cumsum rever w
    # cum_rs_rev <- cumsum(rs_rev)
    cum_rws_rev <- c(0, cumsum(rws_rev))
    
    # Compute d_{t} 
    d <- dbh - 2*cum_rws_rev
    
    # Remove last element 
    d <- d[-length(d)]
    
    # Bai
    b <- rev((base::pi/4) * ((d)^2 - (d - 2*rws_rev)^2))
    
    # Store BAI and NA 
    ### Which elements are NA? 
    na <- attributes(rwsomit)$na.action
    ### Which ones no? 
    no_na <- vec_ly[!vec_ly %in% na]
    ### Put bai in those element with no NA
    bai[no_na, i] <- b 
  }

  bai 
}