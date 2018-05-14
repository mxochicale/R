
# Recurrent Character Function
# version 00
# author: Miguel P Xochicale
# Last Modification date: Mon 14 May 23:05:21 BST 2018




################################
# Recurrence Character Function
rc <- function(v){
# v: string vector 

L <- length(v)

acum <-NULL
for (k in 1:L){
	#message('k: ', k  )
	
	vr<-1
	for (j in 1:L)
	
	if ( j!=k  ){
		#message(j)
		if ( v[k]== v[j] ){
		#message( v[j], ' appear ', vr+1 )	
		acum <- rbind(acum, v[j])
		}
	}
		
	
}

return(acum[1])
}

####################
# Testing Function 
rc( c('a','b', 'c', 'a')  )
rc( c('b','c', 'a', 'b', 'a')  ) #"BCABA" > return ( B )
rc( c('a','b', 'c')  ) #"ABC" > return ( NA )
rc( c('d','b', 'c', 'a', 'b','a')  ) # < B
