#source(  paste( getwd(), '/problem4.R',sep='' ), echo=TRUE  )  
#Problem 4
#Write a function that given a list of non negative integers, 
#arranges them such that they form the largest possible number. 
#For example, given [50, 2, 1, 9], the largest formed number is 95021.


############################
### Function lanu
lanu <- function(x){

N<-length(x)

if (N== 2){
return( rbind( c(x[1], x[2] ), c( x[2], x[1] ) )  )
} else {


TT<-NULL
for (k in 1:N){
	#message('k=',k)
	
	tmp <- NULL
	for (j in 1:N){
	if (k==j){
	}else{
	#message('j=',j)
	
	### only for N=3	
	if (  (k==1&&j==2)  ||    (k==2&&j==1) ){
	ttt<-x[3]
	} else if (  (k==1&&j==3)  ||    (k==3&&j==1) ){
	ttt<-x[2]
	} else if (  (k==2&&j==3)  ||    (k==3&&j==2) ){
	ttt<-x[1]
	}
		
	X<-c(x[k],x[j])
	#message(X)
	tmp<-lanu(X)
	kk<-rbind(ttt,ttt)
	tmp <- cbind(kk,tmp)	
	#message(tmp)
	
	TT<-rbind(TT,tmp)
	}
	}#forj

}#fork


#N <- N-1

}#else

tmax <- 0
r<-dim(TT)[1]
for (i in 1:r){
k<-TT[i,]
n<- paste(k[1],k[2],k[3],sep='')
n <- as.numeric(n)
message(n)


if (n> tmax){
tmax <- n
} 


}#for

return( tmax )

}




##########################
### Main
#v <- c(50,2,1,9)
#v <- c(1,2,3,4)
v <- c(91211,232,9)
#v <- c(2,3)
lanu(v)
