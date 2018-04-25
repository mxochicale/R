

#Problem 2
#Write a function that combines two lists by alternatingly 
#taking elements. For example: given the two lists [a, b, c] 
#and [1, 2, 3], the function should return [a, 1, b, 2, c, 3].
#

#################################
## function combination(la,lb)
## la - vector with N size c(a,b,...,N)
## lc - vector with N size c(1,2,...,N)
## su - return a concatenated vector e.g. [a,1,b,2,...N, N]
combination <- function(la, lb){

N <- length(la)
su <- NULL
for (i in 1:N)
{
tmp <- c( la[i], lb[i])
su <- c(su,tmp  )
}

return(su)
}


####################
## MAIN SCRIPT
la <- c('a','b','c')
lb <- c('1','2','3')
combination(la,lb)
