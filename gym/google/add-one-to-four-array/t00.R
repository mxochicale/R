
a1a <- function(v){

carry<-1
L <- length(v)
nv <- rep(0,L)

for (i in L:1 ){
	message( v[i]  )
	sum <- v[i] + carry
	if(sum == 10 ) {
	carry <- 1
	} else {
	carry <- 0
	nv[i] = sum %% 10
	}
}#endfor
if (carry == 1){
	nv<-rep(0,L+1)
	nv[1]<-1
}


message(nv)
return(nv)

}#func


a1a( c(9,9,9)  )
a1a( c(1,9,9)  )
