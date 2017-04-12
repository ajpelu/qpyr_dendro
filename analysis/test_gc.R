# vector 
install.packages('rowr')

x <- 1:10

y <- c(1,2,1,3,1,2,4,3,2,1)

library(zoo)

rollapply(y, 2, mean)

y <- c(1,2,3,2,2)


rollApply(y, sum, window = 2, align = 'left')
rollApply(y, sum, window = 2, align='right')





