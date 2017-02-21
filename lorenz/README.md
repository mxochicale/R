Lorenz
====


#### lorenz00.R

```
> Lorenz <- function(t, state, parameters){
> #define controlling parameters
> parameters <- c(a= -8/3, b=-10, c=28)

> #define initial state
> state <- c(X=1, Y=1, Z=1)

> #perform the integration and assign it to variable 'out'
> out <- ode(y=state, times= times, func=Lorenz, parms=parameters)
```

# TODO List
* create an intuitive description of the scripts 
