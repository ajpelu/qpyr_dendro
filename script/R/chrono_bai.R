## Function to create a chronology 

## The function require a bai_object (mean bai of each year by tree). 
## It computes the mean, sd and se of BAI by row (ie by year)
## It also computes the sample deepth, i.e. number of trees used to build the chrono. 

chrono_bai <- function(bai_object){ 
  require(dplyr) 
  
  b <- bai_object 
  
  # Prepare data 
  b_aux <- b %>% 
    ##  Create a variable of year 
    mutate(year = as.numeric(rownames(.))) %>% 
    ## melt data 
    gather(series, bai, -year) %>% 
    # remove NA values 
    filter(bai != "") 
  
  # Compute mean, sd, se and sample deepth (n_trees)
  out <- b_aux %>% 
    group_by(year) %>% 
    summarise(bai_mean = mean(bai, na.rm = TRUE), 
              bai_sd = sd(bai), 
              bai_se = bai_sd / sqrt(n()), 
              n_trees = n()) %>% 
    as.data.frame()
  
  out 
} 