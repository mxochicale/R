

#Problem 1
#Write three functions that compute the sum of the numbers 
#in a given list using a for-loop, a while-loop, and recursion.

# github.com/mxochicale/tests






#####################################
message('### (1/3) for-loop')

## Function
sumforloop <- function(vector){
N <- length(vector)
sum <- 0

for (i in  1:N){
#message( vector[i] )
sum <- sum + vector[i]
#message(sum)

}

return(sum)
}


vec <- 4:6
sumforloop(vec)



#####################################
message('### (2/3)  while-loop')

## Function
sumwhileloop <- function(vector){

N <- length(vector)
sum <- 0
i<-1

while (i <= N){

#message(i, vector[i] )
sum <- sum + vector[i]

i <- i+1
#message(sum)

}


return(sum)
}


vec <- 4:6
sumwhileloop(vec)




#####################################
message('###  (3/3) recursive-loop')

## Function
sumab <- function(L,vec){


if (L==2) return(  vec[L-1] + vec[L]  )
else {
val <- vec[L]
#message(val)
return( val  + sumab(L-1,vec) )
}


}


vec <- 4:20
L <- length(vec)
sumab(L,vec)






