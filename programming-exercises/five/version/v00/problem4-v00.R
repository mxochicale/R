#source(  paste( getwd(), '/problem4.R',sep='' ), echo=TRUE  )  
#Problem 4
#Write a function that given a list of non negative integers, 
#arranges them such that they form the largest possible number. 
#For example, given [50, 2, 1, 9], the largest formed number is 95021.


############################
### Function lanu
lanu <- function(vec){

N <- length(vec)
vals<-NULL
for(i in 1:N){
vi <- paste('v',i,sep='')
assign (vi, as.character(vec[i])  ) 
#message(vi,'=',get(vi))
}



for(k in 1:N){
vk <- paste('v',k,sep='')

vik<-NULL
for (j in 1:N) {

if (k==j) {
} else
{
vj <- paste('v',j,sep='')
vik <- cbind( vik, get(vj))
}

}#for j
vcik <- cbind( get(vk), vik)
vals <- rbind(vals,vcik)
}#for k


#for(kk in 1:N){
#t <- vals[kk,]
#tt<-NULL
#for(jj in 1:N){
#tt<-paste(tt, t[jj],sep='')
#}
##message(tt)
#tt< as.numeric(tt)
#}




return( vals )
}




##########################
### Main
#v <- c(50,2,1,9)
v <- c(1,2,3)
lanu(v)
