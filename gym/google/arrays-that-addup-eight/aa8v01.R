# binary search


# Recursive Binary Search
# https://www.youtube.com/watch?v=T2sFYY-fT5o
bs <- function(v,L,R,x){

if (L > R) return(NA)

mid <- L +  ( (R-L)  %/%  2 )
#message(L,R,mid)
if (v[mid] == x){
	return(mid)
} else if ( v[mid] > x ) {
	return( bs(v,L,mid-1,x)   )
} else{
	return( bs(v,mid+1,R,x)    )
}
}


bs( c( 0,2,3,    4  ,10,40,44) ,  1,7,10)
bs( c( 0,2,3,    4  ,10,40) ,  1,6,10)

#bs( c( 0,2,3,    4  ,10,40,44) ,  1,7,44)
#bs( c( 0,2,3,    4  ,10,40,44) ,  1,7,2)


################################
#[1,2,3,9], sum=8, no
#[1,2,4,4], sum=8, yes

aa <- function(v,sum){

Lv <- length(v)

for(i in 1: (Lv-1) ){
#message('i:',i)
vi <- v[i]
cvi <- sum - vi
#message(cvi)

cvindex <- c( (i+1):Lv  ) 
 
vc <- v[ (i+1):Lv  ]  
#message(vc)
#message(Lv-i)
vbs <- bs(vc,1,(Lv-i),cvi)
#message(vbs)

cvv <-  cvindex[vbs] 
#message( cvv )


if(  !is.na(vbs) ) return(  list( TRUE, cbind( v[i],v[cvv] )  )    )   
#} else {
#	return (  list(FALSE) )
#}

}

}


#aa(c(1,2,3,9),8)
#aa(c(1,2,4,4),8)
#aa(c(1,4,2,4),8)
#aa(c(1,6,2,4),8)
#aa(c(1,7,2,4),8)
aa(c(1,2,4,7),8)






