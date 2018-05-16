# problet:
# arrays add up 8

a <- function(v){


L <- length(v)
pair <- NULL
boolsum <- FALSE
for (i in 1:(L-1)){
#message('i:',i)	
vi <- v[i]
	for (j in (i+1):L){
		#message(' j:', j)
		sum <- v[i]+v[j]  
		if (sum==8){
		boolsum <- TRUE
		pair <- cbind(v[i],v[j])	
		}
	}
	
}

return(  list(boolsum,pair) )
}


a(c(1,2,3,9))
a(c(1,2,4,4))




