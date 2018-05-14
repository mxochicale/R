#Problem 3
#Write a function that computes the list of the first 
#100 Fibonacci numbers. By definition, the first two numbers 
#in the Fibonacci sequence are 0 and 1, and each subsequent 
#number is the sum of the previous two. 
#As an example, here are the first 
#10 Fibonnaci numbers: 0, 1, 1, 2, 3, 5, 8, 13, 21, and 34.



#######################
## fibonacci function
fibo <- function(x){

#val<-0
#for (i in 1:x){

if (x==0){
val<-0
}
else if (x==1){
val<-1
}
else {

val <- fibo(x-1) + fibo(x-2)
#val <- cbind ( val, ( fibo(x-1) + fibo(x-2)) )

}



return(  val   )
}



######################
### main script
x <- 10

if (x==0) {
fn <- fibo(0) 
} else if (x==1) {
fn<- cbind( fibo(0), fibo(1) )
} else { #STARTelse

fn<- cbind( fibo(0), fibo(1) )
for (i in 2:x){#STARfor
fn <- cbind(fn, sum(  fn[i],fn[i-1] ))
}#ENDfor


}#ENDelse


fn



