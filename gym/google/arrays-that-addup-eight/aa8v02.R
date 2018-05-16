

##############################
### FOR SORTED ARRAY OF VALUES
aa <- function(v,sum){

low <- 1
hi <- length(v)


while ( low < hi ){

sumi <- v[low] + v[hi]
	if (sumi == sum){
	return( list(TRUE, cbind(v[low], v[hi]) ) )	
	} else if (sumi > sum) {
	hi<-hi-1
	} else if (sumi < sum){
	low <- low+1
	}	

}
return(FALSE)

#message(v[low])

}

#r<-aa(c(1,2,3,9),8)
#r<-aa(c(1,4,2,4),8)
#r<-aa(c(1,2,3,5,8),8)
#message( r )





###############################
#### FOR A NOTSORTED ARRAY OF VALUES

findval <- function(v,val){
vL <- length(v)
if (vL>1){
	for (i in 1:vL ){
		if (v[i]==val) return(TRUE)
	}#for
	return(FALSE)
} else {
return(FALSE)
}

}#findval



nar <- function(v,sum){
Lv <- length(v)
comvec <- NULL
comval <- NULL

for (k in 1:Lv){
val<- v[k]
#message(comvec)
if (  findval(comvec, val )    ){
	return (TRUE)
} else {
	comval <- sum-val 
	comvec <- cbind(comvec, comval)
}

}#for
return(FALSE)
}#nar


#r<-nar(c(1,2,3,9),8)
#r<-nar(c(1,2,4,4),8)
#r<-nar(c(1,4,1,4),8)
#r<-nar(c(1,2,1,4),8)
r<-nar(c(3,2,5,4),8)


message( r )


