#source( paste( getwd(),'/program5.R',sep='' )    , echo=TRUE )

#Problem 5
#Write a program that outputs all possibilities 
#to put + or - or nothing between the numbers 1, 2, ..., 9 
#(in this order) such that the result is always 100. 
#For example: 1 + 2 + 34 – 5 + 67 – 8 + 9 = 100.

####
#ABC
# A B C (3)  >>> A+B+C or A-B-C or A+B-C or A-B+C (4)
#A BC  (1,2) >>> A+BC or A-BC
#AB C  (2,1) >>> AB+C or AB-C


#####
#ABCD (4) 
# A B C D >>>  A+B+C+D or  A-B-C-D or A+B+C-D or  A-B-C+D or  A+B-C-D or  A-B+C+D (6)
#A BCD (1,3)
#ABC D (3,1)

#AB CD (2,2)


######
#ABCDF  (5)
#A BCDF (1,4)
#ABDF F (4,1)

# ABC DF (3,2)
# AB DCF (2,3)

# AB CD F (2,2,1)
# A BC DF (1,2,2)
# AB C DF (2,1,2)




#for (i in 0:9){
#message( factorial(i)  )
#}
#

#nn <- c(1:9)
#N <- length(nn)
#
#for (i in 1:N){
#message('nn[i]=', nn[i] )
#}




fac <- function(x) {

if (x==0) {
return(1)
} else {
return(  fac(x-1) * x   )
}

}

#2^3=8
#fac(3)=6



###########
# 4may2018 12h00m

######################
### LOOP for symbols
maths <- function(x){

if (x==1)
{
return( c('+','-') )
}else if(x==2){
	a1a0<-NULL
	for (i in 1:2){
	a1<-maths(x-1)[i]  
		for (k in 1:2){
		a0<-  maths(x-1)[k]  
		a1a0 <- rbind(a1a0, c(a1,a0) )
				}
		}
	return( a1a0 )
} else {

nr <- dim(maths(x-1))[1] # number of rows

}


}

#maths(1)
#maths(2)


###########
# 4may2018 01h35m

######################
### LOOP for symbols
m2 <- function(x){

if (x==1)
{
return( rbind('+','-') )
} else{


#cbind ( rbind( m2(1)[1], m2(1)[1], m2(1)[2], m2(1)[2] ), rbind( m2(1), m2(1) ) )
#return ( cbind ( rbind( m2(x-1)[1], m2(x-1)[1], m2(x-1)[2], m2(x-1)[2] ), rbind( m2(x-1), m2(x-1) ) )  ) 

#return (    rbind ( m2(x-1)[1], m2(x-1)[1], m2(x-1)[2], m2(x-1)[2]   )  ) 
return(    rbind ( m2(x-1) , m2(x-1)  )     )

#a<-NULL
#for (i in 1:(x)) {
#a <-cbind(a, m2(x-1)[i] )
#}
#return (a)


}


}

m2(1)
m2(2)
m2(3)











###############################
###############################
### My thinking to solve this problem:

####################################################
### (a)  Create a function that produce the symbols
#
#opp(2)
#  [,1] [,2]
#p "+"  "+" 
#p "+"  "-" 
#m "-"  "+" 
#m "-"  "-" 



################################
## Sun May  6 22:02:49 BST 2018

m3 <- function(x){


p1<-NULL
m1<-NULL
p <- '+'
m <- '-'

for( i in 1: ((2^x)/2) ){
p1<- rbind( p1, p)
m1<- rbind( m1, m)
}

return(  rbind( p1, m1)  )

}

m3(1)
m3(2)
m3(3)


###############################
##Sun May  6 22:43:20 BST 2018


opp <- function(x){

mm <- NULL
ccc <- NULL

for (cc1 in x:1){
mm <- m3(cc1)
cc <- NULL
	for(cc2 in 1:2^(x-cc1)  ) {
	cc <- rbind(cc, mm)		
	}
	ccc <- cbind(ccc, cc)
}
return(ccc)

}


opp(1)
opp(2)



#
#######################################################
### (b) Create a funtion for the permutation of values
####
#ABC
# A B C (1,1,1)  >>> A+B+C or A-B-C or A+B-C or A-B+C (2^2=4)
#A BC  (1,2) >>> A+BC or A-BC  (2^1=2)
#AB C  (2,1) >>> AB+C or AB-C  (2^1=2)


#####
#ABCD (4) 
# A B C D (1,1,1,1)>>>  A+B+C+D  (2^3=8)

#A BCD (1,3)  
#ABC D (3,1)

#AB CD (2,2)

#AB C D (2,1,1)
#A BC D (1,2,1)
#A B CD (1,1,2)


#####################################################
# A B C D F E G H I  (1,1,1,1,1,1,1,1,1)  ( 2^8=256 )
# 
# (2,1,1,1,1,1,1,1)
# (1,2,1,1,1,1,1,1)
# ...
# (1,1,1,1,1,1,1,2)
# 
# (3,1,1,1,1,1,1)
# (4,1,1,1,1,1)
# (5,1,1,1,1)
# (6,1,1,1)
# (7,1,1)
# (8,1)
#
# (2,2,1,1,1,1,1) 
# (1,2,2,1,1,1,1) 
# (1,1,2,2,1,1,1) 
# (1,1,1,2,2,1,1) 
# (1,1,1,1,2,2,1) 
# (1,1,1,1,1,2,2)
# 
# (2,2,1,1,1,1,1) 
# (2,1,2,1,1,1,1)

# (2,3,1,1,1,1)
# (2,2,3,1,1)
# (2,2,2,3)
# (2,3,3,1)
# (4,3,2)
# (4,4,1)







#######################
## Tue May  8 00:43:13 BST 2018
# (2,1,1,1,1,1,1,1)
# (1,2,1,1,1,1,1,1)
# ...
# (1,1,1,1,1,1,1,2)


rot <- function(v){

N <- length(v)
v0 <- v[1]
v1N <- v[2:N]

M <- NULL
for (ri in 1: N  ){
	
	tmp <- c(1:N)
	v1Nii <- 0
	for (ci in 1: N ){	
		
		#Using the index help me to add an incremental variable		
		#23
		#13
		#12
		
		if(ci==ri){
		tmp[ci] <- v0
		} else {
		v1Nii <- v1Nii + 1
		tmp[ci] <- v1N[v1Nii]
		}

	}
	M<-rbind(M,tmp)

}

return(M)

}

rot( c(3,1,1,1,1,1,1)  )



################################
#Wed May  9 00:34:43 BST 2018


#####
#ABCD (4) 
# A B C D (1,1,1,1)>>>  A+B+C+D  (2^3=8)

#AB C D (2,1,1)
#A BC D (1,2,1)
#A B CD (1,1,2)

#A BCD (1,3)  
#ABC D (3,1)
#AB CD (2,2)

four <- function(v){

M <- NULL
L <- length(v)

nL <- c(L:1)


for (nLi in 1:L ){
	#message( nL[nLi] )
	Li <- paste( 'L',nLi,sep='' )
	assign(Li, c(1: nL[nLi] ))
}

#############
## main vector Lenghts (Li) with individual digit lenghts (Lik)
## \sum Lik == L 
## for instance : ( 1+1+1+1 == 4 ), (1,2,1==4), etc

message( L1 = 4 ) 
# permute 1,2,3 with four digits
# A B C D (1,1,1,1)>>>  A+B+C+D  (2^3=8)

message( L2 = 3 )
# permute 1,2,3 with three digits
#AB C D (2,1,1)
#A BC D (1,2,1)
#A B CD (1,1,2)



message( L3 )
message( L4 )


return(M)
}


four( c(1,2,3,4) )






###############################
##Thu May 10 09:35:57 BST 2018

#https://stackoverflow.com/a/20199902
permu <- function(n){

if (n==1){
return ( matrix(1) )
} else {
	sp <- permu(n-1)
	p <- nrow(sp)
	#create empty matrix with the dimensions
	A <- matrix( nrow=n*p,ncol=n )
	for ( i in 1:n ){
		A[(i-1)*p+1:p,]	<- cbind(i,sp+(sp>=i) )
		#message(sp )
		#message(sp>=i )
		#message(sp+(sp>=i) )
	}	

	return(A)
}


}

permu( 1 )
permu( 2 )
#permu( 3 )






#
#################################
###  Thu May 10 23:51:49 BST 2018
#
#
#dgs <- function(x){
#
##d <- 1:x
#
##### Lenght of digits
#for (i in x:2){
#message(i)
#}
#
#
##return(  rbind( p1, m1)  )
#
#}
#
#dgs(9)
#


######################################################
### (c combine previous functions in one




