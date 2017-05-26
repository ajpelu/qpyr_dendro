## Function to get correlation between cronos 

## The function require:
## * cronologia: chronology computed with chrono_bai 
## * win_vector: a vector with the window size (i.e.: c(1,2,3))
## * cronomame: a character with the name of the chrono (i.e: 'cro_caH')

suaviza_cronos <- function(cronologia, win_vector, crononame){
  
  cro_object <- cronologia 
  
  # Set bai and years variables 
  bai <- cro_object[,'bai_mean']
  yearss <- cro_object[,'year']
  
  # object to store 
  out <- c() 
  
  for (i in seq_along(win_vector)){ 
    # moving window size 
    f <- rep(1/i, i)
    
    # moving average smooth 
    bai_smooth <- stats::filter(bai, f, sides=2)
    
    # out 
    out_aux <- as.data.frame(cbind(yearss, bai_smooth))
    
    out_aux$size_wind <- i
    out <- rbind(out, out_aux)
  }
  out$crononame <- crononame 
  out
} 
